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

  /// Observes all semesters with their subjects and subject definitions reactively.
  /// Joining all three tables ensures Drift re-evaluates and emits whenever any
  /// semester, subject attempt, or subject definition changes.
  Stream<List<TypedResult>> watchSemestersWithSubjects() {
    final query = select(semesters).join([
      leftOuterJoin(
        semesterSubjects,
        semesterSubjects.semesterId.equalsExp(semesters.id),
      ),
      leftOuterJoin(
        subjects,
        subjects.id.equalsExp(semesterSubjects.subjectId),
      ),
    ]);
    query.orderBy([
      OrderingTerm.asc(semesters.academicYear),
      OrderingTerm.asc(semesters.semesterNumber),
      OrderingTerm.asc(semesterSubjects.id),
    ]);
    return query.watch();
  }

  /// Retrieves all semesters with their subjects and subject definitions.
  Future<List<TypedResult>> getAllSemestersWithSubjects() {
    final query = select(semesters).join([
      leftOuterJoin(
        semesterSubjects,
        semesterSubjects.semesterId.equalsExp(semesters.id),
      ),
      leftOuterJoin(
        subjects,
        subjects.id.equalsExp(semesterSubjects.subjectId),
      ),
    ]);
    query.orderBy([
      OrderingTerm.asc(semesters.academicYear),
      OrderingTerm.asc(semesters.semesterNumber),
      OrderingTerm.asc(semesterSubjects.id),
    ]);
    return query.get();
  }

  /// Observes all subject attempts with subject details for a given semester reactively.
  Stream<List<TypedResult>> watchSemesterSubjectsWithDetails(int semesterId) {
    final query = select(semesterSubjects).join([
      leftOuterJoin(
        subjects,
        subjects.id.equalsExp(semesterSubjects.subjectId),
      ),
    ])..where(semesterSubjects.semesterId.equals(semesterId));
    query.orderBy([OrderingTerm.asc(semesterSubjects.id)]);
    return query.watch();
  }

  /// Retrieves all subject attempts with subject details for a given semester.
  Future<List<TypedResult>> getSemesterSubjectsWithDetails(int semesterId) {
    final query = select(semesterSubjects).join([
      leftOuterJoin(
        subjects,
        subjects.id.equalsExp(semesterSubjects.subjectId),
      ),
    ])..where(semesterSubjects.semesterId.equals(semesterId));
    query.orderBy([OrderingTerm.asc(semesterSubjects.id)]);
    return query.get();
  }
}

