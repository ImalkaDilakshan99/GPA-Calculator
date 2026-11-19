import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/core/services/gpa_calculator_service.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/enums/repeat_subject_policy.dart';

void main() {
  const service = GpaCalculatorService();

  group('Semester GPA Calculations', () {
    test('Calculates GPA correctly for standard completed subjects', () {
      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 101,
          credits: 3.0,
          grade: 'A',
          gradePoint: 4.0, // 12.0
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 102,
          credits: 4.0,
          grade: 'B+',
          gradePoint: 3.3, // 13.2
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        SemesterSubjectEntity(
          id: 3,
          semesterId: 1,
          subjectId: 103,
          credits: 3.0,
          grade: 'C',
          gradePoint: 2.0, // 6.0
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Points: 12.0 + 13.2 + 6.0 = 31.2
      // Credits: 3 + 4 + 3 = 10.0
      // GPA = 31.2 / 10 = 3.12
      final result = service.calculateSemesterGpa(subjects);
      expect(result.gpa, 3.12);
      expect(result.totalCredits, 10.0);
      expect(result.qualityPoints, 31.2);
      expect(result.completedSubjectsCount, 3);
      expect(result.incompleteSubjectsCount, 0);
      expect(result.failedSubjectsCount, 0);
    });

    test('Incomplete subjects (null gradePoint) are excluded from GPA calculation', () {
      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 101,
          credits: 3.0,
          grade: 'A',
          gradePoint: 4.0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 102,
          credits: 4.0,
          grade: null,
          gradePoint: null, // Incomplete!
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Only subject 1 is counted: 12.0 / 3.0 = 4.0
      final result = service.calculateSemesterGpa(subjects);
      expect(result.gpa, 4.0);
      expect(result.totalCredits, 3.0);
      expect(result.completedSubjectsCount, 1);
      expect(result.incompleteSubjectsCount, 1);
    });

    test('Failed subjects (0.0 gradePoint) are included in credit denominator', () {
      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 101,
          credits: 3.0,
          grade: 'A',
          gradePoint: 4.0, // 12.0 points
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 102,
          credits: 3.0,
          grade: 'F',
          gradePoint: 0.0, // 0.0 points
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Total points = 12.0 + 0.0 = 12.0
      // Total credits = 3.0 + 3.0 = 6.0
      // GPA = 12.0 / 6.0 = 2.0
      final result = service.calculateSemesterGpa(subjects);
      expect(result.gpa, 2.0);
      expect(result.totalCredits, 6.0);
      expect(result.failedSubjectsCount, 1);
    });

    test('Empty subjects list returns 0.0 GPA safely', () {
      final result = service.calculateSemesterGpa([]);
      expect(result.gpa, 0.0);
      expect(result.totalCredits, 0.0);
      expect(result.qualityPoints, 0.0);
    });
  });

  group('Cumulative GPA & Repeated-Subject Policies', () {
    // Subject 101 is taken twice:
    // Attempt 1: 3 credits, grade F (0.0 points)
    // Attempt 2: 3 credits, grade A (4.0 points)
    // Subject 102 is taken once: 3 credits, grade B (3.0 points)
    final attempt1Sub101 = SemesterSubjectEntity(
      id: 1,
      semesterId: 1,
      subjectId: 101,
      attemptNumber: 1,
      credits: 3.0,
      grade: 'F',
      gradePoint: 0.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final attempt2Sub101 = SemesterSubjectEntity(
      id: 2,
      semesterId: 2,
      subjectId: 101,
      attemptNumber: 2,
      credits: 3.0,
      grade: 'A',
      gradePoint: 4.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final attempt1Sub102 = SemesterSubjectEntity(
      id: 3,
      semesterId: 1,
      subjectId: 102,
      attemptNumber: 1,
      credits: 3.0,
      grade: 'B',
      gradePoint: 3.0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final semesters = [
      SemesterEntity(
        id: 1,
        name: 'Semester 1',
        academicYear: 2026,
        semesterNumber: 1,
        subjects: [attempt1Sub101, attempt1Sub102],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      SemesterEntity(
        id: 2,
        name: 'Semester 2',
        academicYear: 2026,
        semesterNumber: 2,
        subjects: [attempt2Sub101],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    test('RepeatSubjectPolicy.latestAttempt takes only the latest attempt', () {
      // Sub 101: Attempt 2 (A: 4.0 × 3 = 12.0)
      // Sub 102: Attempt 1 (B: 3.0 × 3 = 9.0)
      // Points = 21.0, Credits = 6.0
      // CGPA = 21.0 / 6.0 = 3.50
      final result = service.calculateCumulativeGpa(
        semesters,
        policy: RepeatSubjectPolicy.latestAttempt,
      );
      expect(result.gpa, 3.50);
      expect(result.totalCredits, 6.0);
      expect(result.completedSubjectsCount, 2);
    });

    test('RepeatSubjectPolicy.bestAttempt takes the highest gradePoint attempt', () {
      // If student got B (3.0) first, then retook and got C (2.0):
      final sub200Attempt1 = SemesterSubjectEntity(
        id: 10,
        semesterId: 1,
        subjectId: 200,
        attemptNumber: 1,
        credits: 4.0,
        grade: 'B',
        gradePoint: 3.0, // Best!
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final sub200Attempt2 = SemesterSubjectEntity(
        id: 11,
        semesterId: 2,
        subjectId: 200,
        attemptNumber: 2,
        credits: 4.0,
        grade: 'C',
        gradePoint: 2.0, // Lower retake
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final testSemesters = [
        SemesterEntity(
          id: 1,
          name: 'Sem 1',
          academicYear: 2026,
          semesterNumber: 1,
          subjects: [sub200Attempt1],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        SemesterEntity(
          id: 2,
          name: 'Sem 2',
          academicYear: 2026,
          semesterNumber: 2,
          subjects: [sub200Attempt2],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];

      // Best attempt policy should pick Attempt 1 (B: 3.0)
      final bestResult = service.calculateCumulativeGpa(
        testSemesters,
        policy: RepeatSubjectPolicy.bestAttempt,
      );
      expect(bestResult.gpa, 3.0);
      expect(bestResult.totalCredits, 4.0);

      // Latest attempt policy would pick Attempt 2 (C: 2.0)
      final latestResult = service.calculateCumulativeGpa(
        testSemesters,
        policy: RepeatSubjectPolicy.latestAttempt,
      );
      expect(latestResult.gpa, 2.0);
    });

    test('RepeatSubjectPolicy.allAttempts includes all attempts in CGPA calculation', () {
      // Attempt 1 Sub 101: 3 cr × 0.0 = 0.0
      // Attempt 2 Sub 101: 3 cr × 4.0 = 12.0
      // Attempt 1 Sub 102: 3 cr × 3.0 = 9.0
      // Points = 21.0, Credits = 9.0
      // CGPA = 21.0 / 9.0 = 2.33
      final result = service.calculateCumulativeGpa(
        semesters,
        policy: RepeatSubjectPolicy.allAttempts,
      );
      expect(result.gpa, 2.33);
      expect(result.totalCredits, 9.0);
      expect(result.completedSubjectsCount, 3);
    });
  });
}

