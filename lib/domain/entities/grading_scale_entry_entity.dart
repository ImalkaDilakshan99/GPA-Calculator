/// Domain entity for individual grade-to-grade-point mappings.
class GradingScaleEntryEntity {
  final int id;
  final int gradingScaleId;
  final String grade;
  final double gradePoint;

  const GradingScaleEntryEntity({
    required this.id,
    required this.gradingScaleId,
    required this.grade,
    required this.gradePoint,
  });

  GradingScaleEntryEntity copyWith({
    int? id,
    int? gradingScaleId,
    String? grade,
    double? gradePoint,
  }) {
    return GradingScaleEntryEntity(
      id: id ?? this.id,
      gradingScaleId: gradingScaleId ?? this.gradingScaleId,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
    );
  }
}

