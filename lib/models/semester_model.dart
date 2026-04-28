class SemesterModel {
  final String name;
  final String year;
  final double cgpa;
  SemesterModel({
    required this.name,
    required this.year,
    this.cgpa = 0,
  });

}
