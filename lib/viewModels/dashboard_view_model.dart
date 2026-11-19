import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/core/services/gpa_calculator_service.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/student_profile_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';
import 'package:gpa_calculator/models/grade_model.dart';

// ── Grade definitions (single source of truth for UI) ────────────────
const List<GradeModel> gradeDefinitions = [
  GradeModel(grade: 'A+', colorValue: 0xFF4CAF50, gradePoint: 4.0),
  GradeModel(grade: 'A', colorValue: 0xFF4CAF50, gradePoint: 4.0),
  GradeModel(grade: 'A-', colorValue: 0xFF66BB6A, gradePoint: 3.7),
  GradeModel(grade: 'B+', colorValue: 0xFF2196F3, gradePoint: 3.3),
  GradeModel(grade: 'B', colorValue: 0xFF2196F3, gradePoint: 3.0),
  GradeModel(grade: 'B-', colorValue: 0xFF42A5F5, gradePoint: 2.7),
  GradeModel(grade: 'C+', colorValue: 0xFFFF9800, gradePoint: 2.3),
  GradeModel(grade: 'C', colorValue: 0xFFFF9800, gradePoint: 2.0),
  GradeModel(grade: 'C-', colorValue: 0xFFFFA726, gradePoint: 1.7),
  GradeModel(grade: 'D', colorValue: 0xFFF44336, gradePoint: 1.0),
  GradeModel(grade: 'F', colorValue: 0xFF212121, gradePoint: 0.0),
];

// ── All semesters (with subjects) from DB ────────────────────────────
final semestersStreamProvider = StreamProvider<List<SemesterEntity>>((ref) {
  final repo = ref.watch(semesterRepositoryProvider);
  return repo.watchAllSemesters();
});

// ── Semester subjects for a specific semester ────────────────────────
final semesterSubjectsStreamProvider =
    StreamProvider.family<List<SemesterSubjectEntity>, int>((ref, semesterId) {
  final repo = ref.watch(semesterRepositoryProvider);
  return repo.watchSemesterSubjects(semesterId);
});

// ── Semester GPA (derived from subjects) ─────────────────────────────
final semesterGpaProvider =
    Provider.family<GpaCalculationResult, List<SemesterSubjectEntity>>(
        (ref, subjects) {
  final service = ref.watch(gpaCalculatorServiceProvider);
  return service.calculateSemesterGpa(subjects);
});

// ── Cumulative GPA across all semesters ──────────────────────────────
final cumulativeGpaProvider = Provider<GpaCalculationResult>((ref) {
  final semestersAsync = ref.watch(semestersStreamProvider);
  final service = ref.watch(gpaCalculatorServiceProvider);

  return semestersAsync.when(
    data: (semesters) => service.calculateCumulativeGpa(semesters),
    loading: () => GpaCalculationResult.empty,
    error: (err, stack) => GpaCalculationResult.empty,
  );
});

// ── All reusable subjects from DB ────────────────────────────────────
final allSubjectsProvider = FutureProvider<List<SubjectEntity>>((ref) {
  final repo = ref.watch(subjectRepositoryProvider);
  return repo.getAllSubjects();
});

// ── Student profile stream ───────────────────────────────────────────
final studentProfileStreamProvider = StreamProvider<StudentProfileEntity?>((ref) {
  final repo = ref.watch(studentRepositoryProvider);
  return repo.watchProfile();
});

// ── Semester CRUD operations ─────────────────────────────────────────

/// Creates a new semester in the database.
Future<int> createSemester(WidgetRef ref, SemesterEntity semester) {
  final repo = ref.read(semesterRepositoryProvider);
  return repo.createSemester(semester);
}

/// Deletes a semester by its ID.
Future<void> deleteSemester(WidgetRef ref, int id) {
  final repo = ref.read(semesterRepositoryProvider);
  return repo.deleteSemester(id);
}

/// Deletes all semesters.
Future<void> deleteAllSemesters(WidgetRef ref) async {
  final repo = ref.read(semesterRepositoryProvider);
  final semesters = await repo.getAllSemesters();
  for (final s in semesters) {
    await repo.deleteSemester(s.id);
  }
}

// ── Subject CRUD operations ──────────────────────────────────────────

/// Creates a new reusable subject and adds an attempt to a semester.
Future<void> addSubjectToSemester(
  WidgetRef ref, {
  required String subjectName,
  required int semesterId,
  required double credits,
  required String grade,
  required double gradePoint,
}) async {
  final subjectRepo = ref.read(subjectRepositoryProvider);

  // Create the reusable subject definition
  final now = DateTime.now();
  final subjectId = await subjectRepo.createSubject(
    SubjectEntity(
      id: 0, // auto-increment
      subjectName: subjectName,
      createdAt: now,
      updatedAt: now,
    ),
  );

  // Add the attempt linking subject → semester with grade info
  await subjectRepo.addSubjectAttempt(
    SemesterSubjectEntity(
      id: 0,
      semesterId: semesterId,
      subjectId: subjectId,
      credits: credits,
      grade: grade,
      gradePoint: gradePoint,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

/// Updates an existing subject attempt (and its subject name) in the database.
Future<void> updateSubjectInSemester(
  WidgetRef ref, {
  required SemesterSubjectEntity attempt,
  required String subjectName,
  required double credits,
  required String grade,
  required double gradePoint,
  int? semesterId,
}) async {
  final subjectRepo = ref.read(subjectRepositoryProvider);

  // 1. Update the reusable subject definition if the name changed
  if (attempt.subject != null) {
    if (attempt.subject!.subjectName != subjectName) {
      await subjectRepo.updateSubject(
        attempt.subject!.copyWith(
          subjectName: subjectName,
          updatedAt: DateTime.now(),
        ),
      );
    }
  } else {
    final existing = await subjectRepo.getSubjectById(attempt.subjectId);
    if (existing != null && existing.subjectName != subjectName) {
      await subjectRepo.updateSubject(
        existing.copyWith(
          subjectName: subjectName,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  // 2. Update the attempt record
  await subjectRepo.updateSubjectAttempt(
    attempt.copyWith(
      credits: credits,
      grade: grade,
      gradePoint: gradePoint,
      semesterId: semesterId ?? attempt.semesterId,
      updatedAt: DateTime.now(),
    ),
  );
}

/// Deletes a subject attempt (and its reusable subject if no other attempts exist).
Future<void> deleteSubjectAttempt(WidgetRef ref, SemesterSubjectEntity attempt) async {
  final subjectRepo = ref.read(subjectRepositoryProvider);

  // Delete the attempt first
  await subjectRepo.deleteSubjectAttempt(attempt.id);

  // Check if any other attempts reference this subject
  final remaining = await subjectRepo.getAttemptsForSubject(attempt.subjectId);
  if (remaining.isEmpty) {
    // Safe to clean up the orphaned subject definition
    try {
      await subjectRepo.deleteSubject(attempt.subjectId);
    } catch (_) {
      // Ignore if still referenced elsewhere
    }
  }
}
