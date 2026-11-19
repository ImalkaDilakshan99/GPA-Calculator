import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';
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

    // 6. Delete Subject Attempt
    await subjectRepo.deleteSubjectAttempt(updatedSubjects.first.id);
    final remainingSubjects = await container.read(semesterRepositoryProvider).getSemesterSubjects(semId);
    expect(remainingSubjects.length, 1);
    expect(remainingSubjects.first.credits, 4.0);

    // 7. Delete Semester cascades and cleans up
    await container.read(semesterRepositoryProvider).deleteSemester(semId);
    final finalSemesters = await container.read(semesterRepositoryProvider).getAllSemesters();
    expect(finalSemesters, isEmpty);
  });
}
