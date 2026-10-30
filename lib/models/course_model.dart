class Course {
  final String id;
  final String name;
  final double credits;
  final String grade;

  const Course({
    required this.id,
    this.name = '',
    this.credits = 3.0,
    this.grade = 'A',
  });

  Course copyWith({
    String? id,
    String? name,
    double? credits,
    String? grade,
  }) {
    return Course(
      id: id ?? this.id,
      name: name ?? this.name,
      credits: credits ?? this.credits,
      grade: grade ?? this.grade,
    );
  }
}
