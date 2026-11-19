import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';

/// Domain entity representing an academic semester.
class SemesterEntity {
  final int id;
  final String name;
  final int academicYear;
  final int semesterNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<SemesterSubjectEntity> subjects;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SemesterEntity({
    required this.id,
    required this.name,
    required this.academicYear,
    required this.semesterNumber,
    this.startDate,
    this.endDate,
    this.subjects = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  SemesterEntity copyWith({
    int? id,
    String? name,
    int? academicYear,
    int? semesterNumber,
    DateTime? startDate,
    DateTime? endDate,
    List<SemesterSubjectEntity>? subjects,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SemesterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      academicYear: academicYear ?? this.academicYear,
      semesterNumber: semesterNumber ?? this.semesterNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      subjects: subjects ?? this.subjects,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

