import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/entities/subject_entity.dart';

abstract interface class ISubjectRepository {
  Future<List<SubjectEntity>> getAllSubjects();
  Future<SubjectEntity?> getSubjectById(int id);
  Future<int> createSubject(SubjectEntity subject);
  Future<void> updateSubject(SubjectEntity subject);
  Future<void> deleteSubject(int id);
  Future<int> addSubjectAttempt(SemesterSubjectEntity attempt);
  Future<void> updateSubjectAttempt(SemesterSubjectEntity attempt);
  Future<void> deleteSubjectAttempt(int id);
  Future<List<SemesterSubjectEntity>> getAttemptsForSubject(int subjectId);
  Future<int> getNextAttemptNumber(int subjectId);
}

