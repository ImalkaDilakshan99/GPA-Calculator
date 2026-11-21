import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/tables/semester_subjects.dart';
import 'package:gpa_calculator/core/database/tables/semesters.dart';
import 'package:gpa_calculator/core/database/tables/subjects.dart';

part 'subject_dao.g.dart';

@DriftAccessor(tables: [Subjects, SemesterSubjects, Semesters])
class SubjectDao extends DatabaseAccessor<AppDatabase> with _$SubjectDaoMixin {
  SubjectDao(super.db);

  /// Inserts a new subject definition.
  Future<int> createSubject(SubjectsCompanion subject) {
    return into(subjects).insert(subject);
  }

  /// Retrieves all reusable subjects.
  Future<List<Subject>> getAllSubjects() {
    return (select(subjects)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.subjectName)]))
        .get();
  }

  /// Observes all subjects.
  Stream<List<Subject>> watchAllSubjects() {
    return (select(subjects)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.subjectName)]))
        .watch();
  }

  /// Retrieves a subject by ID.
  Future<Subject?> getSubjectById(int id) {
    return (select(subjects)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Updates subject metadata.
  Future<bool> updateSubject(SubjectsCompanion subject) {
    return (update(subjects)..where((tbl) => tbl.id.equals(subject.id.value)))
        .write(subject.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  /// Safely deletes a subject if no semester attempts reference it.
  Future<int> deleteSubject(int id) {
    return transaction(() async {
      final attempts = await (select(semesterSubjects)
            ..where((tbl) => tbl.subjectId.equals(id)))
          .get();
      if (attempts.isNotEmpty) {
        throw StateError(
          'Cannot delete subject with existing semester attempts. Remove attempts first.',
        );
      }
      return (delete(subjects)..where((tbl) => tbl.id.equals(id))).go();
    });
  }

  /// Adds a subject attempt to a semester.
  Future<int> addSubjectToSemester(SemesterSubjectsCompanion attempt) {
    return into(semesterSubjects).insert(attempt);
  }

  /// Updates an individual subject attempt (grades, credits, etc.).
  Future<bool> updateSubjectAttempt(SemesterSubjectsCompanion attempt) {
    return (update(semesterSubjects)
          ..where((tbl) => tbl.id.equals(attempt.id.value)))
        .write(attempt.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  /// Deletes a specific subject attempt by ID.
  Future<int> deleteSubjectAttempt(int id) {
    return (delete(semesterSubjects)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Retrieves all attempts of a specific subject across all semesters in chronological order.
  Future<List<SemesterSubject>> getAttemptsForSubject(int subjectId) {
    return (select(semesterSubjects)
          ..where((tbl) => tbl.subjectId.equals(subjectId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.attemptNumber)]))
        .get();
  }

  /// Calculates the next attempt number for a given subject.
  Future<int> getNextAttemptNumber(int subjectId) async {
    final attempts = await getAttemptsForSubject(subjectId);
    if (attempts.isEmpty) return 1;
    final maxAttempt = attempts.map((a) => a.attemptNumber).reduce(
          (max, val) => val > max ? val : max,
        );
    return maxAttempt + 1;
  }

  /// Observes subject attempts for a given semester.
  Stream<List<SemesterSubject>> watchSemesterSubjects(int semesterId) {
    return (select(semesterSubjects)
          ..where((tbl) => tbl.semesterId.equals(semesterId)))
        .watch();
  }

  /// Retrieves all semester subject attempts across all semesters.
  Future<List<SemesterSubject>> getAllSemesterSubjects() {
    return select(semesterSubjects).get();
  }

  /// Updates a semester subject row directly.
  Future<bool> updateSemesterSubject(SemesterSubject row) {
    return update(semesterSubjects).replace(row);
  }
}

