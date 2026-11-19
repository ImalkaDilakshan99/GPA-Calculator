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
  final SubjectDao _subjectDao;

  SemesterRepositoryImpl(this._semesterDao, this._subjectDao);

  @override
  Future<List<SemesterEntity>> getAllSemesters() async {
    final rows = await _semesterDao.getAllSemesters();
    final result = <SemesterEntity>[];
    for (final s in rows) {
      final subjects = await getSemesterSubjects(s.id);
      result.add(_mapSemester(s, subjects));
    }
    return result;
  }

  @override
  Stream<List<SemesterEntity>> watchAllSemesters() {
    return _semesterDao.watchSemesters().asyncMap((rows) async {
      final result = <SemesterEntity>[];
      for (final s in rows) {
        final subjects = await getSemesterSubjects(s.id);
        result.add(_mapSemester(s, subjects));
      }
      return result;
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
    final attempts = await _semesterDao.getSemesterSubjects(semesterId);
    final result = <SemesterSubjectEntity>[];
    for (final a in attempts) {
      final subjectData = await _subjectDao.getSubjectById(a.subjectId);
      final subjectEntity = subjectData != null
          ? SubjectEntity(
              id: subjectData.id,
              subjectName: subjectData.subjectName,
              subjectCode: subjectData.subjectCode,
              createdAt: subjectData.createdAt,
              updatedAt: subjectData.updatedAt,
            )
          : null;
      result.add(_mapAttempt(a, subjectEntity));
    }
    return result;
  }

  @override
  Stream<List<SemesterSubjectEntity>> watchSemesterSubjects(int semesterId) {
    return _semesterDao.watchSemesterSubjects(semesterId).asyncMap((attempts) async {
      final result = <SemesterSubjectEntity>[];
      for (final a in attempts) {
        final subjectData = await _subjectDao.getSubjectById(a.subjectId);
        final subjectEntity = subjectData != null
            ? SubjectEntity(
                id: subjectData.id,
                subjectName: subjectData.subjectName,
                subjectCode: subjectData.subjectCode,
                createdAt: subjectData.createdAt,
                updatedAt: subjectData.updatedAt,
              )
            : null;
        result.add(_mapAttempt(a, subjectEntity));
      }
      return result;
    });
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

