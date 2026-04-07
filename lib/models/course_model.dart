class Course {
  final String id;
  String name;
  double credits;
  String grade;

  Course({
    required this.id,
    this.name = '',
    this.credits = 3.0,
    this.grade = 'A',
  });
}
