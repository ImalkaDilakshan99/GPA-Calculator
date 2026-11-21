/// Domain entity for individual grade-to-grade-point mappings.
class GradingScaleEntryEntity {
  final int id;
  final int gradingScaleId;
  final String grade;
  final double gradePoint;
  final double? minimumPercentage;
  final double? maximumPercentage;
  final bool isPassing;
  final int displayOrder;

  const GradingScaleEntryEntity({
    required this.id,
    required this.gradingScaleId,
    required this.grade,
    required this.gradePoint,
    this.minimumPercentage,
    this.maximumPercentage,
    this.isPassing = true,
    this.displayOrder = 0,
  });

  GradingScaleEntryEntity copyWith({
    int? id,
    int? gradingScaleId,
    String? grade,
    double? gradePoint,
    double? minimumPercentage,
    double? maximumPercentage,
    bool? isPassing,
    int? displayOrder,
  }) {
    return GradingScaleEntryEntity(
      id: id ?? this.id,
      gradingScaleId: gradingScaleId ?? this.gradingScaleId,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
      minimumPercentage: minimumPercentage ?? this.minimumPercentage,
      maximumPercentage: maximumPercentage ?? this.maximumPercentage,
      isPassing: isPassing ?? this.isPassing,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradingScaleEntryEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          gradingScaleId == other.gradingScaleId &&
          grade == other.grade &&
          gradePoint == other.gradePoint &&
          minimumPercentage == other.minimumPercentage &&
          maximumPercentage == other.maximumPercentage &&
          isPassing == other.isPassing &&
          displayOrder == other.displayOrder;

  @override
  int get hashCode => Object.hash(
        id,
        gradingScaleId,
        grade,
        gradePoint,
        minimumPercentage,
        maximumPercentage,
        isPassing,
        displayOrder,
      );
}
