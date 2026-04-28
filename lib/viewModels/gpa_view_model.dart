import 'package:flutter_riverpod/legacy.dart';
import 'package:gpa_calculator/models/course_model.dart';

// The state notifier for the GPA calculation
class GPANotifier extends StateNotifier<List<Course>> {
  GPANotifier() : super([]);

  // add a course
  void addCourse() {
    state = [...state, Course(id: DateTime.now().toString())];
  }

  // update a course
  void updateCourse(String id, double credits, String grade){
    state = [
      for (final course in state)

        if (course.id == id)
          Course(
            id: course.id,
            name: course.name,
            credits: credits,
            grade: grade,
          )
        else
          course
    ];
  }

  // remove a course
  void removeCourse(String id){
    state = state.where((course) => course.id != id).toList();
  }

  //Calculate GPA
  double calculateGPA(){

    if (state.isEmpty) return 0.0;

    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in state){
      totalPoints += (course.credits * _gradeToPoint(course.grade));
      totalCredits += course.credits;
    }
    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  double _gradeToPoint(String grade) {
    switch (grade.trim().toUpperCase()) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }
}

//The provider That the UI will listen to
final gpaProvider = StateNotifierProvider<GPANotifier, List<Course>>((ref){
  return GPANotifier();
});