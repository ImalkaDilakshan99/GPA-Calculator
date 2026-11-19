import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/tables/grading_scales.dart';
import 'package:gpa_calculator/core/database/tables/student_profiles.dart';

part 'student_dao.g.dart';

@DriftAccessor(tables: [StudentProfiles, GradingScales])
class StudentDao extends DatabaseAccessor<AppDatabase> with _$StudentDaoMixin {
  StudentDao(super.db);

  /// Inserts or replaces the single student profile (fixed id = 1).
  Future<int> insertProfile(StudentProfilesCompanion profile) {
    return transaction(() async {
      final enforcedProfile = profile.copyWith(id: const Value(1));
      return into(studentProfiles).insertOnConflictUpdate(enforcedProfile);
    });
  }

  /// Retrieves the single student profile.
  Future<StudentProfile?> getProfile() {
    return (select(studentProfiles)..where((tbl) => tbl.id.equals(1)))
        .getSingleOrNull();
  }

  /// Observes changes to the student profile reactively.
  Stream<StudentProfile?> watchProfile() {
    return (select(studentProfiles)..where((tbl) => tbl.id.equals(1)))
        .watchSingleOrNull();
  }

  /// Updates fields on the student profile.
  Future<bool> updateProfile(StudentProfilesCompanion profile) {
    return transaction(() async {
      final updated = profile.copyWith(
        updatedAt: Value(DateTime.now()),
      );
      final affected = await (update(studentProfiles)
            ..where((tbl) => tbl.id.equals(1)))
          .write(updated);
      return affected > 0;
    });
  }

  /// Deletes the student profile.
  Future<int> deleteProfile() {
    return (delete(studentProfiles)..where((tbl) => tbl.id.equals(1))).go();
  }
}

