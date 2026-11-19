import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/grading_scale_dao.dart';
import 'package:gpa_calculator/core/database/daos/student_dao.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/entities/student_profile_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/domain/repositories/i_student_repository.dart';

class StudentRepositoryImpl implements IStudentRepository {
  final StudentDao _studentDao;
  final GradingScaleDao _gradingScaleDao;

  StudentRepositoryImpl(this._studentDao, this._gradingScaleDao);

  @override
  Future<StudentProfileEntity?> getProfile() async {
    final data = await _studentDao.getProfile();
    if (data == null) return null;
    return _mapToEntity(data);
  }

  @override
  Stream<StudentProfileEntity?> watchProfile() {
    return _studentDao.watchProfile().asyncMap((data) async {
      if (data == null) return null;
      return _mapToEntity(data);
    });
  }

  @override
  Future<void> saveProfile(StudentProfileEntity profile) async {
    final companion = StudentProfilesCompanion(
      id: const Value(1),
      name: Value(profile.name),
      degreeName: Value(profile.degreeName),
      universityName: Value(profile.universityName),
      profilePhotoPath: Value(profile.profilePhotoPath),
      gradingScaleId: Value(profile.gradingScaleId),
      updatedAt: Value(DateTime.now()),
    );
    await _studentDao.insertProfile(companion);
  }

  @override
  Future<void> deleteProfile() async {
    await _studentDao.deleteProfile();
  }

  Future<StudentProfileEntity> _mapToEntity(StudentProfile data) async {
    GradingScaleEntity? scaleEntity;
    final scaleData = await _gradingScaleDao.getGradingScaleById(data.gradingScaleId);
    if (scaleData != null) {
      final entriesData = await _gradingScaleDao.getEntriesForScale(scaleData.id);
      scaleEntity = GradingScaleEntity(
        id: scaleData.id,
        name: scaleData.name,
        maximumGpa: scaleData.maximumGpa,
        scaleType: ScaleType.fromString(scaleData.scaleType),
        isDefault: scaleData.isDefault,
        entries: entriesData
            .map((e) => GradingScaleEntryEntity(
                  id: e.id,
                  gradingScaleId: e.gradingScaleId,
                  grade: e.grade,
                  gradePoint: e.gradePoint,
                ))
            .toList(),
        createdAt: scaleData.createdAt,
        updatedAt: scaleData.updatedAt,
      );
    }

    return StudentProfileEntity(
      id: data.id,
      name: data.name,
      degreeName: data.degreeName,
      universityName: data.universityName,
      profilePhotoPath: data.profilePhotoPath,
      gradingScaleId: data.gradingScaleId,
      gradingScale: scaleEntity,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}

