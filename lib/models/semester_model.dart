class SemesterModel {
  final String id;
  final String name;
  final String year;
  final double gpa;
  final int subjects;

  const SemesterModel({
    required this.id,
    required this.name,
    required this.year,
    this.gpa = 0,
    this.subjects = 0,
  });

  SemesterModel copyWith({
    String? id,
    String? name,
    String? year,
    double? gpa,
    int? subjects,
  }) {
    return SemesterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      year: year ?? this.year,
      gpa: gpa ?? this.gpa,
      subjects: subjects ?? this.subjects,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
