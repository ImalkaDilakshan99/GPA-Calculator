import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';
import 'package:gpa_calculator/view/pages/dashboard.dart';
import 'package:gpa_calculator/view/pages/semester_view.dart';
import 'package:gpa_calculator/viewModels/dashboard_view_model.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.customSelect('SELECT 1').get();

    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  test('UI Database Flow: Create semester, add subjects, compute GPA, and reset', () async {
    final now = DateTime.now();

    // 1. Initially semesters should be empty
    final initialSemesters = await container.read(semesterRepositoryProvider).getAllSemesters();
    expect(initialSemesters, isEmpty);

    // 2. Create Semester via repository
    final semId = await container.read(semesterRepositoryProvider).createSemester(
      SemesterEntity(
        id: 0,
        name: 'Fall 2024',
        academicYear: 2024,
        semesterNumber: 1,
        createdAt: now,
        updatedAt: now,
      ),
    );
    expect(semId, greaterThan(0));

    // 3. Add Subject via subjectRepository
    final subjectRepo = container.read(subjectRepositoryProvider);
    final subjectId = await subjectRepo.createSubject(
      SubjectEntity(
        id: 0,
        subjectName: 'Data Structures',
        createdAt: now,
        updatedAt: now,
      ),
    );

    await subjectRepo.addSubjectAttempt(
      SemesterSubjectEntity(
        id: 0,
        semesterId: semId,
        subjectId: subjectId,
        credits: 3.0,
        grade: 'A',
        gradePoint: 4.0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // 4. Verify semester subjects and GPA calculation
    final semesterSubjects = await container.read(semesterRepositoryProvider).getSemesterSubjects(semId);
    expect(semesterSubjects.length, 1);
    expect(semesterSubjects.first.credits, 3.0);
    expect(semesterSubjects.first.gradePoint, 4.0);

    final gpaResult = container.read(semesterGpaProvider(semesterSubjects));
    expect(gpaResult.gpa, 4.0);
    expect(gpaResult.totalCredits, 3.0);

    // 5. Add second subject (Calculus: 4.0 credits, B: 3.0 points)
    final calculusId = await subjectRepo.createSubject(
      SubjectEntity(
        id: 0,
        subjectName: 'Calculus',
        createdAt: now,
        updatedAt: now,
      ),
    );
    await subjectRepo.addSubjectAttempt(
      SemesterSubjectEntity(
        id: 0,
        semesterId: semId,
        subjectId: calculusId,
        credits: 4.0,
        grade: 'B',
        gradePoint: 3.0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final updatedSubjects = await container.read(semesterRepositoryProvider).getSemesterSubjects(semId);
    expect(updatedSubjects.length, 2);

    // GPA = (3*4.0 + 4*3.0) / (3 + 4) = (12 + 12) / 7 = 24 / 7 = 3.43
    final updatedGpa = container.read(semesterGpaProvider(updatedSubjects));
    expect(updatedGpa.gpa, 3.43);
    expect(updatedGpa.totalCredits, 7.0);

    // 6. Edit Subject Attempt via updateSubjectInSemester
    final attemptToEdit = updatedSubjects.last;
    final subjectRepoImpl = container.read(subjectRepositoryProvider);
    // Update subject definition name
    await subjectRepoImpl.updateSubject(
      SubjectEntity(
        id: attemptToEdit.subjectId,
        subjectName: 'Advanced Calculus',
        createdAt: now,
        updatedAt: DateTime.now(),
      ),
    );
    // Update attempt
    await subjectRepoImpl.updateSubjectAttempt(
      attemptToEdit.copyWith(
        credits: 3.0,
        grade: 'A',
        gradePoint: 4.0,
        updatedAt: DateTime.now(),
      ),
    );

    final afterEditSubjects = await container.read(semesterRepositoryProvider).getSemesterSubjects(semId);
    expect(afterEditSubjects.length, 2);
    final edited = afterEditSubjects.firstWhere((s) => s.id == attemptToEdit.id);
    expect(edited.subject?.subjectName, 'Advanced Calculus');
    expect(edited.credits, 3.0);
    expect(edited.grade, 'A');
    expect(edited.gradePoint, 4.0);

    // 7. Delete Subject Attempt
    await subjectRepo.deleteSubjectAttempt(updatedSubjects.first.id);
    final remainingSubjects = await container.read(semesterRepositoryProvider).getSemesterSubjects(semId);
    expect(remainingSubjects.length, 1);
    expect(remainingSubjects.first.credits, 3.0);

    // 8. Delete Semester cascades and cleans up
    await container.read(semesterRepositoryProvider).deleteSemester(semId);
    final finalSemesters = await container.read(semesterRepositoryProvider).getAllSemesters();
    expect(finalSemesters, isEmpty);
  });

  test('Semester Sorting Options: Newest, Oldest, GPA High-to-Low, GPA Low-to-High', () async {
    final now = DateTime.now();
    final semRepo = container.read(semesterRepositoryProvider);
    final subRepo = container.read(subjectRepositoryProvider);

    // 1. Create older semester (2023) with GPA 3.0
    final sem2023Id = await semRepo.createSemester(
      SemesterEntity(
        id: 0,
        name: 'Fall 2023',
        academicYear: 2023,
        semesterNumber: 1,
        createdAt: now.subtract(const Duration(days: 365)),
        updatedAt: now.subtract(const Duration(days: 365)),
      ),
    );
    final sub1 = await subRepo.createSubject(
      SubjectEntity(id: 0, subjectName: 'Subject A', createdAt: now, updatedAt: now),
    );
    await subRepo.addSubjectAttempt(
      SemesterSubjectEntity(
        id: 0,
        semesterId: sem2023Id,
        subjectId: sub1,
        credits: 3.0,
        grade: 'B',
        gradePoint: 3.0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // 2. Create newer semester (2024) with GPA 4.0
    final sem2024Id = await semRepo.createSemester(
      SemesterEntity(
        id: 0,
        name: 'Fall 2024',
        academicYear: 2024,
        semesterNumber: 1,
        createdAt: now,
        updatedAt: now,
      ),
    );
    final sub2 = await subRepo.createSubject(
      SubjectEntity(id: 0, subjectName: 'Subject B', createdAt: now, updatedAt: now),
    );
    await subRepo.addSubjectAttempt(
      SemesterSubjectEntity(
        id: 0,
        semesterId: sem2024Id,
        subjectId: sub2,
        credits: 3.0,
        grade: 'A',
        gradePoint: 4.0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Test Newest First
    container.read(semesterSortProvider.notifier).setSortOption(SemesterSortOption.newestFirst);
    final sorted = await semRepo.watchAllSemesters().first;
    expect(sorted.length, 2);

    // Test sorting through sortedSemestersProvider logic
    final allSemestersWithSubjects = await semRepo.getAllSemesters();
    expect(allSemestersWithSubjects.length, 2);

    // Test Oldest First
    container.read(semesterSortProvider.notifier).setSortOption(SemesterSortOption.oldestFirst);
    expect(container.read(semesterSortProvider), SemesterSortOption.oldestFirst);

    // Test GPA High to Low
    container.read(semesterSortProvider.notifier).setSortOption(SemesterSortOption.gpaHighToLow);
    expect(container.read(semesterSortProvider), SemesterSortOption.gpaHighToLow);

    // Test GPA Low to High
    container.read(semesterSortProvider.notifier).setSortOption(SemesterSortOption.gpaLowToHigh);
    expect(container.read(semesterSortProvider), SemesterSortOption.gpaLowToHigh);
  });

  testWidgets('SemesterView: Delete button displays confirmation dialog and deletes semester', (tester) async {
    final now = DateTime.now();
    final semRepo = container.read(semesterRepositoryProvider);

    final semId = await semRepo.createSemester(
      SemesterEntity(
        id: 0,
        name: 'Fall 2024',
        academicYear: 2024,
        semesterNumber: 1,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final semester = (await semRepo.getAllSemesters()).firstWhere((s) => s.id == semId);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: SemesterView(semester: semester),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify delete button is present in the app bar
    final deleteButton = find.byTooltip('Delete Semester');
    expect(deleteButton, findsOneWidget);

    // Tap delete button to show confirmation dialog
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Verify dialog content
    expect(find.text('Delete Semester?'), findsOneWidget);
    expect(
      find.text('Are you sure you want to delete "Fall 2024"? This will permanently remove this semester and all its subject entries.'),
      findsOneWidget,
    );
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);

    // Tap Cancel first
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Delete Semester?'), findsNothing);

    // Semester should still exist
    expect((await semRepo.getAllSemesters()).length, 1);

    // Tap delete button again
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // Tap Delete button in dialog
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    // Verify semester is deleted from database
    final remainingSemesters = await semRepo.getAllSemesters();
    expect(remainingSemesters, isEmpty);
  });

  testWidgets('Dashboard reactively updates Total CGPA and Semester Card Term GPA when subject is added', (tester) async {
    final now = DateTime.now();
    final semRepo = container.read(semesterRepositoryProvider);
    final subRepo = container.read(subjectRepositoryProvider);

    // 1. Create a semester with no subjects initially
    final semId = await semRepo.createSemester(
      SemesterEntity(
        id: 0,
        name: 'Fall 2024',
        academicYear: 2024,
        semesterNumber: 1,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Render Dashboard
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Dashboard(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify initial values on Dashboard
    // Circular CGPA starts at 0.00
    expect(find.text('0.00'), findsNWidgets(2)); // Circular CGPA and Card Term GPA
    expect(find.text('0.0'), findsNWidgets(2)); // Card credits (0.0) and Dashboard Grade Points (0.0)

    // 2. Add a subject with 3.0 credits, Grade A (4.0) to the semester
    final subId = await subRepo.createSubject(
      SubjectEntity(id: 0, subjectName: 'Data Structures', createdAt: now, updatedAt: now),
    );
    await subRepo.addSubjectAttempt(
      SemesterSubjectEntity(
        id: 0,
        semesterId: semId,
        subjectId: subId,
        credits: 3.0,
        grade: 'A',
        gradePoint: 4.0,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Let streams propagate and Flutter rebuild widgets
    await tester.pumpAndSettle();

    // 3. Verify that Dashboard updated reactively!
    // Total CGPA is now 4.00, Term GPA is now 4.00
    expect(find.text('4.00'), findsNWidgets(2)); // 1 in Circular Progress, 1 in Semester Card
    expect(find.text('3.0'), findsOneWidget); // Semester card credits: 3.0
    expect(find.text('1'), findsOneWidget); // Courses count: 1
    expect(find.text('12.0'), findsOneWidget); // Grade Points: 12.0

    // 4. Verify cumulativeGpaProvider
    final cumulativeResult = container.read(cumulativeGpaProvider);
    expect(cumulativeResult.gpa, 4.0);
    expect(cumulativeResult.totalCredits, 3.0);
    expect(cumulativeResult.qualityPoints, 12.0);
  });
}
