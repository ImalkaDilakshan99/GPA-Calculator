import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/grading_scale_dao.dart';
import 'package:gpa_calculator/core/database/daos/semester_dao.dart';
import 'package:gpa_calculator/core/database/daos/student_dao.dart';
import 'package:gpa_calculator/core/database/daos/subject_dao.dart';
import 'package:gpa_calculator/core/services/gpa_calculator_service.dart';
import 'package:gpa_calculator/core/services/profile_photo_service.dart';
import 'package:gpa_calculator/data/repositories/grading_scale_repository_impl.dart';
import 'package:gpa_calculator/data/repositories/semester_repository_impl.dart';
import 'package:gpa_calculator/data/repositories/student_repository_impl.dart';
import 'package:gpa_calculator/data/repositories/subject_repository_impl.dart';
import 'package:gpa_calculator/domain/repositories/i_grading_scale_repository.dart';
import 'package:gpa_calculator/domain/repositories/i_semester_repository.dart';
import 'package:gpa_calculator/domain/repositories/i_student_repository.dart';
import 'package:gpa_calculator/domain/repositories/i_subject_repository.dart';

/// Database singleton provider.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// ── DAO Providers ──────────────────────────────────────────────────
final studentDaoProvider = Provider<StudentDao>((ref) {
  return ref.watch(appDatabaseProvider).studentDao;
});

final gradingScaleDaoProvider = Provider<GradingScaleDao>((ref) {
  return ref.watch(appDatabaseProvider).gradingScaleDao;
});

final semesterDaoProvider = Provider<SemesterDao>((ref) {
  return ref.watch(appDatabaseProvider).semesterDao;
});

final subjectDaoProvider = Provider<SubjectDao>((ref) {
  return ref.watch(appDatabaseProvider).subjectDao;
});

// ── Repository Providers ───────────────────────────────────────────
final studentRepositoryProvider = Provider<IStudentRepository>((ref) {
  return StudentRepositoryImpl(
    ref.watch(studentDaoProvider),
    ref.watch(gradingScaleDaoProvider),
  );
});

final gradingScaleRepositoryProvider = Provider<IGradingScaleRepository>((ref) {
  return GradingScaleRepositoryImpl(
    ref.watch(gradingScaleDaoProvider),
  );
});

final semesterRepositoryProvider = Provider<ISemesterRepository>((ref) {
  return SemesterRepositoryImpl(
    ref.watch(semesterDaoProvider),
    ref.watch(subjectDaoProvider),
  );
});

final subjectRepositoryProvider = Provider<ISubjectRepository>((ref) {
  return SubjectRepositoryImpl(
    ref.watch(subjectDaoProvider),
  );
});

// ── Service Providers ──────────────────────────────────────────────
final gpaCalculatorServiceProvider = Provider<GpaCalculatorService>((ref) {
  return const GpaCalculatorService();
});

final profilePhotoServiceProvider = Provider<ProfilePhotoService>((ref) {
  return ProfilePhotoService();
});

