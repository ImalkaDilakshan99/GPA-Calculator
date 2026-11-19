import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';

/// Domain entity representing the single student profile.
class StudentProfileEntity {
  final int id;
  final String name;
  final String degreeName;
  final String universityName;
  final String? profilePhotoPath;
  final int gradingScaleId;
  final GradingScaleEntity? gradingScale;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudentProfileEntity({
    this.id = 1,
    required this.name,
    required this.degreeName,
    required this.universityName,
    this.profilePhotoPath,
    required this.gradingScaleId,
    this.gradingScale,
    required this.createdAt,
    required this.updatedAt,
  });

  StudentProfileEntity copyWith({
    int? id,
    String? name,
    String? degreeName,
    String? universityName,
    String? profilePhotoPath,
    int? gradingScaleId,
    GradingScaleEntity? gradingScale,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      degreeName: degreeName ?? this.degreeName,
      universityName: universityName ?? this.universityName,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      gradingScaleId: gradingScaleId ?? this.gradingScaleId,
      gradingScale: gradingScale ?? this.gradingScale,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

