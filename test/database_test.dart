import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/core/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    // In-memory SQLite database for unit tests
    db = AppDatabase.forTesting(NativeDatabase.memory());
    // Trigger creation
    await db.customSelect('SELECT 1').get();
  });

  tearDown(() async {
    await db.close();
  });

  group('GradingScales & Predefined Seed Data', () {
    test('Default predefined scales are seeded automatically on creation', () async {
      final scales = await db.gradingScaleDao.getAllGradingScales();
      expect(scales.length, 3);

      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();
      expect(defaultScale, isNotNull);
      expect(defaultScale!.name, 'Standard 4.0 Scale');
      expect(defaultScale.maximumGpa, 4.0);
      expect(defaultScale.isDefault, isTrue);
      expect(defaultScale.scaleType, 'predefined');

      // Check entries for standard 4.0 scale
      final entries = await db.gradingScaleDao.getEntriesForScale(defaultScale.id);
      expect(entries.length, 11);
      expect(entries.first.grade, 'A+');
      expect(entries.first.gradePoint, 4.0);
      expect(entries.last.grade, 'F');
      expect(entries.last.gradePoint, 0.0);
    });

    test('Predefined grading scales cannot be modified or deleted', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();
      expect(defaultScale, isNotNull);

      // Attempting to delete predefined scale throws StateError
      expect(
        () => db.gradingScaleDao.deleteGradingScale(defaultScale!.id),
        throwsA(isA<StateError>()),
      );

      // Attempting to update predefined scale throws StateError
      expect(
        () => db.gradingScaleDao.updateGradingScale(
          defaultScale!.id,
          const GradingScalesCompanion(name: Value('Modified Scale')),
          null,
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('Custom grading scale can be created, updated, and deleted', () async {
      final customScaleId = await db.gradingScaleDao.insertGradingScale(
        GradingScalesCompanion.insert(
          name: 'Custom 10.0 Scale',
          maximumGpa: 10.0,
          scaleType: 'custom',
          isDefault: const Value(false),
        ),
        [
          GradingScaleEntriesCompanion.insert(
            gradingScaleId: 0,
            grade: 'O',
            gradePoint: 10.0,
          ),
          GradingScaleEntriesCompanion.insert(
            gradingScaleId: 0,
            grade: 'A',
            gradePoint: 9.0,
          ),
          GradingScaleEntriesCompanion.insert(
            gradingScaleId: 0,
            grade: 'F',
            gradePoint: 0.0,
          ),
        ],
      );

      expect(customScaleId, greaterThan(3));
      final entries = await db.gradingScaleDao.getEntriesForScale(customScaleId);
      expect(entries.length, 3);
      expect(entries.first.grade, 'O');

      // Update custom scale
      await db.gradingScaleDao.updateGradingScale(
        customScaleId,
        const GradingScalesCompanion(name: Value('Renamed 10.0 Scale')),
        null,
      );
      final updated = await db.gradingScaleDao.getGradingScaleById(customScaleId);
      expect(updated!.name, 'Renamed 10.0 Scale');

      // Delete custom scale
      await db.gradingScaleDao.deleteGradingScale(customScaleId);
      final deleted = await db.gradingScaleDao.getGradingScaleById(customScaleId);
      expect(deleted, isNull);

      // Entries should be deleted via cascade
      final remainingEntries = await db.gradingScaleDao.getEntriesForScale(customScaleId);
      expect(remainingEntries, isEmpty);
    });

    test('Unique constraint prevents duplicate grade in the same scale', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();

      // Adding duplicate grade 'A' to the same scale violates UNIQUE(grading_scale_id, grade)
      expect(
        () => db.into(db.gradingScaleEntries).insert(
              GradingScaleEntriesCompanion.insert(
                gradingScaleId: defaultScale!.id,
                grade: 'A',
                gradePoint: 3.9,
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    });
  });

  group('StudentProfiles', () {
    test('Creating and retrieving student profile', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();

      await db.studentDao.insertProfile(
        StudentProfilesCompanion.insert(
          name: 'Alex Rivera',
          degreeName: 'Computer Science',
          universityName: 'Stanford University',
          gradingScaleId: defaultScale!.id,
          profilePhotoPath: const Value('/path/to/photo.jpg'),
        ),
      );

      final profile = await db.studentDao.getProfile();
      expect(profile, isNotNull);
      expect(profile!.id, 1);
      expect(profile.name, 'Alex Rivera');
      expect(profile.degreeName, 'Computer Science');
      expect(profile.universityName, 'Stanford University');
      expect(profile.profilePhotoPath, '/path/to/photo.jpg');
    });

    test('Single profile constraint enforces id = 1', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();

      // Inserting with id != 1 violates CHECK (id = 1)
      expect(
        () => db.into(db.studentProfiles).insert(
              StudentProfilesCompanion.insert(
                id: const Value(2),
                name: 'Jane Doe',
                degreeName: 'Engineering',
                universityName: 'MIT',
                gradingScaleId: defaultScale!.id,
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('Updating student profile information', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();

      await db.studentDao.insertProfile(
        StudentProfilesCompanion.insert(
          name: 'Alex Rivera',
          degreeName: 'Computer Science',
          universityName: 'Stanford University',
          gradingScaleId: defaultScale!.id,
        ),
      );

      await db.studentDao.updateProfile(
        const StudentProfilesCompanion(
          name: Value('Alex R. Rivera'),
          degreeName: Value('Software Engineering'),
        ),
      );

      final updated = await db.studentDao.getProfile();
      expect(updated!.name, 'Alex R. Rivera');
      expect(updated.degreeName, 'Software Engineering');
      expect(updated.universityName, 'Stanford University');
    });

    test('Prevent deleting grading scale assigned to student profile', () async {
      final defaultScale = await db.gradingScaleDao.getDefaultGradingScale();

      await db.studentDao.insertProfile(
        StudentProfilesCompanion.insert(
          name: 'Alex Rivera',
          degreeName: 'Computer Science',
          universityName: 'Stanford University',
          gradingScaleId: defaultScale!.id,
        ),
      );

      expect(
        () => db.gradingScaleDao.deleteGradingScale(defaultScale.id),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('Semesters & Subjects & Relationships', () {
    test('Create semesters and enforce unique(academicYear, semesterNumber)', () async {
      final sem1Id = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );
      expect(sem1Id, greaterThan(0));

      final sem2Id = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Spring 2026',
          academicYear: 2026,
          semesterNumber: 2,
        ),
      );
      expect(sem2Id, greaterThan(sem1Id));

      // Duplicate semesterNumber in the same academicYear is rejected
      expect(
        () => db.semesterDao.createSemester(
          SemestersCompanion.insert(
            name: 'Duplicate Fall 2026',
            academicYear: 2026,
            semesterNumber: 1,
          ),
        ),
        throwsA(isA<SqliteException>()),
      );

      final semesters = await db.semesterDao.getAllSemesters();
      expect(semesters.length, 2);
    });

    test('Create subjects, add to semester, update grades, and track attempts', () async {
      final sem1Id = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );

      final sub1Id = await db.subjectDao.createSubject(
        SubjectsCompanion.insert(
          subjectName: 'Data Structures',
          subjectCode: Value('CS101'),
        ),
      );

      // Attempt 1: Incomplete initially (grade = null)
      final attempt1Id = await db.subjectDao.addSubjectToSemester(
        SemesterSubjectsCompanion.insert(
          semesterId: sem1Id,
          subjectId: sub1Id,
          credits: 3.0,
        ),
      );
      expect(attempt1Id, greaterThan(0));

      var attempts = await db.subjectDao.getAttemptsForSubject(sub1Id);
      expect(attempts.length, 1);
      expect(attempts.first.grade, isNull);
      expect(attempts.first.gradePoint, isNull);

      // Assign grade 'C' (2.0)
      await db.subjectDao.updateSubjectAttempt(
        SemesterSubjectsCompanion(
          id: Value(attempt1Id),
          grade: const Value('C'),
          gradePoint: const Value(2.0),
        ),
      );

      attempts = await db.subjectDao.getAttemptsForSubject(sub1Id);
      expect(attempts.first.grade, 'C');
      expect(attempts.first.gradePoint, 2.0);

      // Repeat subject in Semester 2 (Attempt 2)
      final sem2Id = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Spring 2026',
          academicYear: 2026,
          semesterNumber: 2,
        ),
      );

      final nextAttempt = await db.subjectDao.getNextAttemptNumber(sub1Id);
      expect(nextAttempt, 2);

      await db.subjectDao.addSubjectToSemester(
        SemesterSubjectsCompanion.insert(
          semesterId: sem2Id,
          subjectId: sub1Id,
          attemptNumber: const Value(2),
          credits: 3.0,
          grade: const Value('A'),
          gradePoint: const Value(4.0),
        ),
      );

      attempts = await db.subjectDao.getAttemptsForSubject(sub1Id);
      expect(attempts.length, 2);
      expect(attempts[0].attemptNumber, 1);
      expect(attempts[0].gradePoint, 2.0);
      expect(attempts[1].attemptNumber, 2);
      expect(attempts[1].gradePoint, 4.0);
    });

    test('Prevent duplicate attempt numbers for the same subject', () async {
      final semId = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );

      final subId = await db.subjectDao.createSubject(
        SubjectsCompanion.insert(subjectName: 'Algorithms'),
      );

      await db.subjectDao.addSubjectToSemester(
        SemesterSubjectsCompanion.insert(
          semesterId: semId,
          subjectId: subId,
          attemptNumber: const Value(1),
          credits: 4.0,
        ),
      );

      // Adding attemptNumber = 1 again violates UNIQUE(subjectId, attemptNumber)
      expect(
        () => db.subjectDao.addSubjectToSemester(
          SemesterSubjectsCompanion.insert(
            semesterId: semId,
            subjectId: subId,
            attemptNumber: const Value(1),
            credits: 4.0,
          ),
        ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('Deleting semester cascades and deletes its semester_subjects', () async {
      final semId = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );

      final subId = await db.subjectDao.createSubject(
        SubjectsCompanion.insert(subjectName: 'Databases'),
      );

      await db.subjectDao.addSubjectToSemester(
        SemesterSubjectsCompanion.insert(
          semesterId: semId,
          subjectId: subId,
          credits: 3.0,
          grade: const Value('A'),
          gradePoint: const Value(4.0),
        ),
      );

      var semesterSubjects = await db.semesterDao.getSemesterSubjects(semId);
      expect(semesterSubjects.length, 1);

      // Delete semester
      await db.semesterDao.deleteSemester(semId);

      // Semester is deleted
      expect(await db.semesterDao.getSemesterById(semId), isNull);

      // Associated semester subject attempts are deleted via CASCADE
      semesterSubjects = await db.semesterDao.getSemesterSubjects(semId);
      expect(semesterSubjects, isEmpty);

      // Subject definition itself still exists
      expect(await db.subjectDao.getSubjectById(subId), isNotNull);
    });

    test('Prevent deleting a subject if attempts reference it', () async {
      final semId = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );

      final subId = await db.subjectDao.createSubject(
        SubjectsCompanion.insert(subjectName: 'Operating Systems'),
      );

      await db.subjectDao.addSubjectToSemester(
        SemesterSubjectsCompanion.insert(
          semesterId: semId,
          subjectId: subId,
          credits: 3.0,
        ),
      );

      // SubjectDao.deleteSubject checks for attempts and throws StateError
      expect(
        () => db.subjectDao.deleteSubject(subId),
        throwsA(isA<StateError>()),
      );
    });

    test('Check constraints enforce positive credits and non-negative grade points', () async {
      final semId = await db.semesterDao.createSemester(
        SemestersCompanion.insert(
          name: 'Fall 2026',
          academicYear: 2026,
          semesterNumber: 1,
        ),
      );

      final subId = await db.subjectDao.createSubject(
        SubjectsCompanion.insert(subjectName: 'Physics'),
      );

      // Credits <= 0 violates CHECK (credits > 0.0)
      expect(
        () => db.subjectDao.addSubjectToSemester(
          SemesterSubjectsCompanion.insert(
            semesterId: semId,
            subjectId: subId,
            credits: 0.0,
          ),
        ),
        throwsA(isA<SqliteException>()),
      );

      // Negative grade point violates CHECK (grade_point IS NULL OR grade_point >= 0.0)
      expect(
        () => db.subjectDao.addSubjectToSemester(
          SemesterSubjectsCompanion.insert(
            semesterId: semId,
            subjectId: subId,
            credits: 3.0,
            gradePoint: const Value(-1.0),
          ),
        ),
        throwsA(isA<SqliteException>()),
      );
    });
  });
}
