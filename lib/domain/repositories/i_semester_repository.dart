import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';

abstract interface class ISemesterRepository {
  Future<List<SemesterEntity>> getAllSemesters();
  Stream<List<SemesterEntity>> watchAllSemesters();
  Future<SemesterEntity?> getSemesterById(int id);
  Future<int> createSemester(SemesterEntity semester);
  Future<void> updateSemester(SemesterEntity semester);
  Future<void> deleteSemester(int id);
  Future<List<SemesterSubjectEntity>> getSemesterSubjects(int semesterId);
  Stream<List<SemesterSubjectEntity>> watchSemesterSubjects(int semesterId);
}

