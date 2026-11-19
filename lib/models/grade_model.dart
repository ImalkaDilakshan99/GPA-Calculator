class GradeModel {
  final String grade;
  final int colorValue;
  final double gradePoint;

  const GradeModel({
    required this.grade,
    required this.colorValue,
    required this.gradePoint,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeModel &&
          runtimeType == other.runtimeType &&
          grade == other.grade;

  @override
  int get hashCode => grade.hashCode;
}