import 'package:gpa_calculator/domain/entities/subject_entity.dart';

/// Domain entity representing a subject attempt associated with a semester.
class SemesterSubjectEntity {
  final int id;
  final int semesterId;
  final int subjectId;
  final SubjectEntity? subject;
  final int attemptNumber;
  final double credits;
  final String? grade;
  final double? gradePoint;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SemesterSubjectEntity({
    required this.id,
    required this.semesterId,
    required this.subjectId,
    this.subject,
    this.attemptNumber = 1,
    required this.credits,
    this.grade,
    this.gradePoint,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isCompleted => grade != null && gradePoint != null;

  SemesterSubjectEntity copyWith({
    int? id,
    int? semesterId,
    int? subjectId,
    SubjectEntity? subject,
    int? attemptNumber,
    double? credits,
    String? grade,
    double? gradePoint,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SemesterSubjectEntity(
      id: id ?? this.id,
      semesterId: semesterId ?? this.semesterId,
      subjectId: subjectId ?? this.subjectId,
      subject: subject ?? this.subject,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      credits: credits ?? this.credits,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterSubjectEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          semesterId == other.semesterId &&
          subjectId == other.subjectId &&
          attemptNumber == other.attemptNumber &&
          credits == other.credits &&
          grade == other.grade &&
          gradePoint == other.gradePoint &&
          subject?.subjectName == other.subject?.subjectName;

  @override
  int get hashCode => Object.hash(
        id,
        semesterId,
        subjectId,
        attemptNumber,
        credits,
        grade,
        gradePoint,
      );
}

