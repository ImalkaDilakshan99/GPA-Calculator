class SemesterModel {
  final String id;
  final String name;
  final String year;
  final double gpa;

  const SemesterModel({
    required this.id,
    required this.name,
    required this.year,
    this.gpa = 0,
  });

  SemesterModel copyWith({
    String? id,
    String? name,
    String? year,
    double? gpa,
  }) {
    return SemesterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      year: year ?? this.year,
      gpa: gpa ?? this.gpa,
    );
  }
}
