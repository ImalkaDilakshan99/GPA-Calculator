import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/subject_dao.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';
import 'package:gpa_calculator/domain/repositories/i_subject_repository.dart';

class SubjectRepositoryImpl implements ISubjectRepository {
  final SubjectDao _subjectDao;

  SubjectRepositoryImpl(this._subjectDao);

  @override
  Future<List<SubjectEntity>> getAllSubjects() async {
    final rows = await _subjectDao.getAllSubjects();
    return rows.map(_mapSubject).toList();
  }

  @override
  Future<SubjectEntity?> getSubjectById(int id) async {
    final row = await _subjectDao.getSubjectById(id);
    return row != null ? _mapSubject(row) : null;
  }

  @override
  Future<int> createSubject(SubjectEntity subject) {
    final companion = SubjectsCompanion.insert(
      subjectName: subject.subjectName,
      subjectCode: Value(subject.subjectCode),
    );
    return _subjectDao.createSubject(companion);
  }

  @override
  Future<void> updateSubject(SubjectEntity subject) async {
    final companion = SubjectsCompanion(
      id: Value(subject.id),
      subjectName: Value(subject.subjectName),
      subjectCode: Value(subject.subjectCode),
      updatedAt: Value(DateTime.now()),
    );
    await _subjectDao.updateSubject(companion);
  }

  @override
  Future<void> deleteSubject(int id) async {
    await _subjectDao.deleteSubject(id);
  }

  @override
  Future<int> addSubjectAttempt(SemesterSubjectEntity attempt) async {
    final nextAttempt = await _subjectDao.getNextAttemptNumber(attempt.subjectId);
    final companion = SemesterSubjectsCompanion.insert(
      semesterId: attempt.semesterId,
      subjectId: attempt.subjectId,
      attemptNumber: Value(attempt.attemptNumber > 0 ? attempt.attemptNumber : nextAttempt),
      credits: attempt.credits,
      grade: Value(attempt.grade),
      gradePoint: Value(attempt.gradePoint),
    );
    return _subjectDao.addSubjectToSemester(companion);
  }

  @override
  Future<void> updateSubjectAttempt(SemesterSubjectEntity attempt) async {
    final companion = SemesterSubjectsCompanion(
      id: Value(attempt.id),
      semesterId: Value(attempt.semesterId),
      subjectId: Value(attempt.subjectId),
      attemptNumber: Value(attempt.attemptNumber),
      credits: Value(attempt.credits),
      grade: Value(attempt.grade),
      gradePoint: Value(attempt.gradePoint),
      updatedAt: Value(DateTime.now()),
    );
    await _subjectDao.updateSubjectAttempt(companion);
  }

  @override
  Future<void> deleteSubjectAttempt(int id) async {
    await _subjectDao.deleteSubjectAttempt(id);
  }

  @override
  Future<List<SemesterSubjectEntity>> getAttemptsForSubject(int subjectId) async {
    final rows = await _subjectDao.getAttemptsForSubject(subjectId);
    final subjectData = await _subjectDao.getSubjectById(subjectId);
    final subjectEntity = subjectData != null ? _mapSubject(subjectData) : null;
    return rows.map((r) => _mapAttempt(r, subjectEntity)).toList();
  }

  @override
  Future<int> getNextAttemptNumber(int subjectId) {
    return _subjectDao.getNextAttemptNumber(subjectId);
  }

  SubjectEntity _mapSubject(Subject s) {
    return SubjectEntity(
      id: s.id,
      subjectName: s.subjectName,
      subjectCode: s.subjectCode,
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

