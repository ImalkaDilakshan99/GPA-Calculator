import 'package:gpa_calculator/domain/entities/student_profile_entity.dart';

abstract interface class IStudentRepository {
  Future<StudentProfileEntity?> getProfile();
  Stream<StudentProfileEntity?> watchProfile();
  Future<void> saveProfile(StudentProfileEntity profile);
  Future<void> deleteProfile();
}

