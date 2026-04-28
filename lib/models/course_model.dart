class Course {
  final String id;
  final String name;
  final double credits;
  String grade;

  Course({
    required this.id,
    this.name = '',
    this.credits = 3.0,
    this.grade = 'A',
  });
}
