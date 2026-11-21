import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/semester_dao.dart';
import 'package:gpa_calculator/core/database/daos/subject_dao.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';
import 'package:gpa_calculator/domain/repositories/i_semester_repository.dart';

class SemesterRepositoryImpl implements ISemesterRepository {
  final SemesterDao _semesterDao;

  SemesterRepositoryImpl(this._semesterDao, [SubjectDao? _]);

  @override
  Future<List<SemesterEntity>> getAllSemesters() async {
    final rows = await _semesterDao.getAllSemestersWithSubjects();
    return _mapJoinedResultsToSemesters(rows);
  }

  @override
  Stream<List<SemesterEntity>> watchAllSemesters() {
    return _semesterDao.watchSemestersWithSubjects().map((rows) {
      return _mapJoinedResultsToSemesters(rows);
    });
  }

  @override
  Future<SemesterEntity?> getSemesterById(int id) async {
    final s = await _semesterDao.getSemesterById(id);
    if (s == null) return null;
    final subjects = await getSemesterSubjects(s.id);
    return _mapSemester(s, subjects);
  }

  @override
  Future<int> createSemester(SemesterEntity semester) {
    final companion = SemestersCompanion.insert(
      name: semester.name,
      academicYear: semester.academicYear,
      semesterNumber: semester.semesterNumber,
      startDate: Value(semester.startDate),
      endDate: Value(semester.endDate),
    );
    return _semesterDao.createSemester(companion);
  }

  @override
  Future<void> updateSemester(SemesterEntity semester) async {
    final companion = SemestersCompanion(
      id: Value(semester.id),
      name: Value(semester.name),
      academicYear: Value(semester.academicYear),
      semesterNumber: Value(semester.semesterNumber),
      startDate: Value(semester.startDate),
      endDate: Value(semester.endDate),
      updatedAt: Value(DateTime.now()),
    );
    await _semesterDao.updateSemester(companion);
  }

  @override
  Future<void> deleteSemester(int id) async {
    await _semesterDao.deleteSemester(id);
  }

  @override
  Future<List<SemesterSubjectEntity>> getSemesterSubjects(int semesterId) async {
    final rows = await _semesterDao.getSemesterSubjectsWithDetails(semesterId);
    return rows.map((row) {
      final a = row.readTable(_semesterDao.semesterSubjects);
      final sub = row.readTableOrNull(_semesterDao.subjects);
      final subjectEntity = sub != null
          ? SubjectEntity(
              id: sub.id,
              subjectName: sub.subjectName,
              subjectCode: sub.subjectCode,
              createdAt: sub.createdAt,
              updatedAt: sub.updatedAt,
            )
          : null;
      return _mapAttempt(a, subjectEntity);
    }).toList();
  }

  @override
  Stream<List<SemesterSubjectEntity>> watchSemesterSubjects(int semesterId) {
    return _semesterDao.watchSemesterSubjectsWithDetails(semesterId).map((rows) {
      return rows.map((row) {
        final a = row.readTable(_semesterDao.semesterSubjects);
        final sub = row.readTableOrNull(_semesterDao.subjects);
        final subjectEntity = sub != null
            ? SubjectEntity(
                id: sub.id,
                subjectName: sub.subjectName,
                subjectCode: sub.subjectCode,
                createdAt: sub.createdAt,
                updatedAt: sub.updatedAt,
              )
            : null;
        return _mapAttempt(a, subjectEntity);
      }).toList();
    });
  }

  List<SemesterEntity> _mapJoinedResultsToSemesters(List<TypedResult> rows) {
    final semesterMap = <int, SemesterEntity>{};
    final subjectsMap = <int, List<SemesterSubjectEntity>>{};

    for (final row in rows) {
      final s = row.readTable(_semesterDao.semesters);
      if (!semesterMap.containsKey(s.id)) {
        semesterMap[s.id] = SemesterEntity(
          id: s.id,
          name: s.name,
          academicYear: s.academicYear,
          semesterNumber: s.semesterNumber,
          startDate: s.startDate,
          endDate: s.endDate,
          subjects: const [],
          createdAt: s.createdAt,
          updatedAt: s.updatedAt,
        );
        subjectsMap[s.id] = [];
      }

      final a = row.readTableOrNull(_semesterDao.semesterSubjects);
      if (a != null) {
        final sub = row.readTableOrNull(_semesterDao.subjects);
        final subjectEntity = sub != null
            ? SubjectEntity(
                id: sub.id,
                subjectName: sub.subjectName,
                subjectCode: sub.subjectCode,
                createdAt: sub.createdAt,
                updatedAt: sub.updatedAt,
              )
            : null;

        subjectsMap[s.id]!.add(_mapAttempt(a, subjectEntity));
      }
    }

    return semesterMap.values.map((s) {
      return s.copyWith(subjects: List.unmodifiable(subjectsMap[s.id] ?? []));
    }).toList();
  }

  SemesterEntity _mapSemester(Semester s, List<SemesterSubjectEntity> subjects) {
    return SemesterEntity(
      id: s.id,
      name: s.name,
      academicYear: s.academicYear,
      semesterNumber: s.semesterNumber,
      startDate: s.startDate,
      endDate: s.endDate,
      subjects: subjects,
      createdAt: s.createdAt,
      updatedAt: s.updatedAt,
    );
  }

  SemesterSubjectEntity _mapAttempt(SemesterSubject a, SubjectEntity? subject) {
    return SemesterSubjectEntity(
      id: a.id,
      semesterId: a.semesterId,
      subjectId: a.subjectId,
      subject: subject,
      attemptNumber: a.attemptNumber,
      credits: a.credits,
      grade: a.grade,
      gradePoint: a.gradePoint,
      createdAt: a.createdAt,
      updatedAt: a.updatedAt,
    );
  }
}

