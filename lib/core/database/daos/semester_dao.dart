import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/tables/semester_subjects.dart';
import 'package:gpa_calculator/core/database/tables/semesters.dart';
import 'package:gpa_calculator/core/database/tables/subjects.dart';

part 'semester_dao.g.dart';

@DriftAccessor(tables: [Semesters, SemesterSubjects, Subjects])
class SemesterDao extends DatabaseAccessor<AppDatabase>
    with _$SemesterDaoMixin {
  SemesterDao(super.db);

  /// Inserts a new semester.
  Future<int> createSemester(SemestersCompanion semester) {
    return into(semesters).insert(semester);
  }

  /// Retrieves all semesters ordered by academic year and semester number.
  Future<List<Semester>> getAllSemesters() {
    return (select(semesters)
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.academicYear),
            (tbl) => OrderingTerm.asc(tbl.semesterNumber),
          ]))
        .get();
  }

  /// Observes all semesters reactively.
  Stream<List<Semester>> watchSemesters() {
    return (select(semesters)
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.academicYear),
            (tbl) => OrderingTerm.asc(tbl.semesterNumber),
          ]))
        .watch();
  }

  /// Retrieves a specific semester by ID.
  Future<Semester?> getSemesterById(int id) {
    return (select(semesters)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Updates semester details.
  Future<bool> updateSemester(SemestersCompanion semester) {
    return (update(semesters)..where((tbl) => tbl.id.equals(semester.id.value)))
        .write(semester.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  /// Deletes a semester by ID (foreign keys cascade delete semester subjects).
  Future<int> deleteSemester(int id) {
    return (delete(semesters)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Retrieves all subject attempts for a given semester.
  Future<List<SemesterSubject>> getSemesterSubjects(int semesterId) {
    return (select(semesterSubjects)
          ..where((tbl) => tbl.semesterId.equals(semesterId)))
        .get();
  }

  /// Observes all subject attempts for a given semester.
  Stream<List<SemesterSubject>> watchSemesterSubjects(int semesterId) {
    return (select(semesterSubjects)
          ..where((tbl) => tbl.semesterId.equals(semesterId)))
        .watch();
  }
}

