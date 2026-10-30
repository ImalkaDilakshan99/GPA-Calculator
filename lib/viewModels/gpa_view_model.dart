import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpa_calculator/models/course_model.dart';
import 'package:gpa_calculator/models/grade_model.dart';
import 'package:gpa_calculator/models/semester_model.dart';

// ── Grade definitions ──────────────────────────────────────────────
// Single source of truth for the grading scale used across the app.

const List<GradeModel> gradeDefinitions = [
  GradeModel(grade: 'A+', colorValue: 0xFF4CAF50, gradePoint: 4.0),
  GradeModel(grade: 'A',  colorValue: 0xFF4CAF50, gradePoint: 4.0),
  GradeModel(grade: 'A-', colorValue: 0xFF66BB6A, gradePoint: 3.7),
  GradeModel(grade: 'B+', colorValue: 0xFF2196F3, gradePoint: 3.3),
  GradeModel(grade: 'B',  colorValue: 0xFF2196F3, gradePoint: 3.0),
  GradeModel(grade: 'B-', colorValue: 0xFF42A5F5, gradePoint: 2.7),
  GradeModel(grade: 'C+', colorValue: 0xFFFF9800, gradePoint: 2.3),
  GradeModel(grade: 'C',  colorValue: 0xFFFF9800, gradePoint: 2.0),
  GradeModel(grade: 'C-', colorValue: 0xFFFFA726, gradePoint: 1.7),
  GradeModel(grade: 'D',  colorValue: 0xFFF44336, gradePoint: 1.0),
  GradeModel(grade: 'F',  colorValue: 0xFF212121, gradePoint: 0.0),
];

/// Lookup map built once from [gradeDefinitions].
final Map<String, double> _gradePointMap = {
  for (final g in gradeDefinitions) g.grade: g.gradePoint,
};

// ── Course state (per-semester) ────────────────────────────────────

class GPANotifier extends Notifier<List<Course>> {
  static int _idCounter = 0;

  @override
  List<Course> build() => [];

  /// Adds an empty course with a unique ID.
  void addCourse() {
    _idCounter++;
    state = [...state, Course(id: '${DateTime.now().microsecondsSinceEpoch}_$_idCounter')];
  }

  /// Replaces the course identified by [id] with updated values.
  void updateCourse(String id, {String? name, double? credits, String? grade}) {
    state = [
      for (final course in state)
        if (course.id == id)
          course.copyWith(name: name, credits: credits, grade: grade)
        else
          course,
    ];
  }

  /// Removes the course with the given [id].
  void removeCourse(String id) {
    state = state.where((course) => course.id != id).toList();
  }

  /// Calculates semester GPA: Σ(credits × gradePoint) / Σ(credits).
  double calculateGPA() {
    if (state.isEmpty) return 0.0;

    double totalPoints = 0;
    double totalCredits = 0;

    for (final course in state) {
      final point = gradeToPoint(course.grade);
      totalPoints += course.credits * point;
      totalCredits += course.credits;
    }

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  /// Returns the total credit hours of all courses.
  double totalCredits() {
    double total = 0;
    for (final course in state) {
      total += course.credits;
    }
    return total;
  }

  /// Converts a grade string to its grade-point value.
  /// Returns 0.0 for unrecognised grades.
  static double gradeToPoint(String grade) {
    return _gradePointMap[grade.trim()] ?? 0.0;
  }
}

// ── Semester state ─────────────────────────────────────────────────

class SemesterNotifier extends Notifier<List<SemesterModel>> {
  @override
  List<SemesterModel> build() => [];

  /// Adds a new semester.
  void addSemester(SemesterModel semester) {
    state = [...state, semester];
  }

  /// Updates an existing semester by [id].
  void updateSemester(String id, {String? name, String? year, double? gpa}) {
    state = [
      for (final s in state)
        if (s.id == id)
          s.copyWith(name: name, year: year, gpa: gpa)
        else
          s,
    ];
  }

  /// Removes the semester with the given [id].
  void removeSemester(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  /// Calculates cumulative GPA across all semesters (simple average).
  double calculateCumulativeGPA() {
    if (state.isEmpty) return 0.0;
    final total = state.fold<double>(0.0, (sum, s) => sum + s.gpa);
    return total / state.length;
  }
}

// ── Providers ──────────────────────────────────────────────────────

/// Provider for managing courses within the current semester view.
final gpaProvider = NotifierProvider<GPANotifier, List<Course>>(
  GPANotifier.new,
);

/// Provider for managing all semesters.
final semesterProvider = NotifierProvider<SemesterNotifier, List<SemesterModel>>(
  SemesterNotifier.new,
);