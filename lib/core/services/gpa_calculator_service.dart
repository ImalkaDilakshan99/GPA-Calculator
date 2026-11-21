import 'dart:math' as math;
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/enums/repeat_subject_policy.dart';

/// Result object holding calculated GPA and related academic statistics.
class GpaCalculationResult {
  final double gpa;
  final double totalCredits;
  final double qualityPoints;
  final int completedSubjectsCount;
  final int incompleteSubjectsCount;
  final int failedSubjectsCount;

  const GpaCalculationResult({
    required this.gpa,
    required this.totalCredits,
    required this.qualityPoints,
    required this.completedSubjectsCount,
    required this.incompleteSubjectsCount,
    required this.failedSubjectsCount,
  });

  static const GpaCalculationResult empty = GpaCalculationResult(
    gpa: 0.0,
    totalCredits: 0.0,
    qualityPoints: 0.0,
    completedSubjectsCount: 0,
    incompleteSubjectsCount: 0,
    failedSubjectsCount: 0,
  );
}

/// Service dedicated to all GPA and CGPA mathematical calculations,
/// adhering strictly to academic policies, grading scales, and repeated-course handling.
class GpaCalculatorService {
  final RepeatSubjectPolicy defaultRepeatPolicy;

  const GpaCalculatorService({
    this.defaultRepeatPolicy = RepeatSubjectPolicy.latestAttempt,
  });

  /// Calculates semester GPA: SUM(credits × gradePoint) / SUM(credits).
  ///
  /// Incomplete subjects (where gradePoint is null) are excluded from the calculation.
  /// Failed subjects are included and contribute to the credit denominator.
  GpaCalculationResult calculateSemesterGpa(
    List<SemesterSubjectEntity> subjects, {
    GradingScaleEntity? scale,
    int? decimalPlaces,
  }) {
    if (subjects.isEmpty) return GpaCalculationResult.empty;

    final places = decimalPlaces ?? scale?.decimalPlaces ?? 2;
    double totalPoints = 0.0;
    double totalCredits = 0.0;
    int completedCount = 0;
    int incompleteCount = 0;
    int failedCount = 0;

    for (final s in subjects) {
      if (s.credits <= 0) continue;

      if (!s.isCompleted) {
        incompleteCount++;
        continue;
      }

      completedCount++;
      final points = s.gradePoint!;

      bool isFailed;
      if (scale != null) {
        if (scale.isHigherBetter) {
          isFailed = points < scale.passingValue || points == scale.worstValue;
        } else {
          isFailed = points > scale.passingValue || points == scale.worstValue;
        }
      } else {
        isFailed = points == 0.0;
      }

      if (isFailed) {
        failedCount++;
      }

      totalPoints += s.credits * points;
      totalCredits += s.credits;
    }

    final rawGpa = totalCredits > 0 ? (totalPoints / totalCredits) : 0.0;
    final roundedGpa = _round(rawGpa, places);

    return GpaCalculationResult(
      gpa: roundedGpa,
      totalCredits: totalCredits,
      qualityPoints: totalPoints,
      completedSubjectsCount: completedCount,
      incompleteSubjectsCount: incompleteCount,
      failedSubjectsCount: failedCount,
    );
  }

  /// Calculates cumulative GPA across all semesters, applying the specified [RepeatSubjectPolicy]
  /// and scale properties.
  GpaCalculationResult calculateCumulativeGpa(
    List<SemesterEntity> semesters, {
    GradingScaleEntity? scale,
    RepeatSubjectPolicy? policy,
    int? decimalPlaces,
  }) {
    final activePolicy = policy ?? defaultRepeatPolicy;

    // Collect all subject attempts from all semesters
    final allAttempts = <SemesterSubjectEntity>[];
    for (final sem in semesters) {
      allAttempts.addAll(sem.subjects);
    }

    return calculateCumulativeGpaFromAttempts(
      allAttempts,
      scale: scale,
      policy: activePolicy,
      decimalPlaces: decimalPlaces,
    );
  }

  /// Calculates cumulative GPA directly from a list of attempts.
  GpaCalculationResult calculateCumulativeGpaFromAttempts(
    List<SemesterSubjectEntity> attempts, {
    GradingScaleEntity? scale,
    RepeatSubjectPolicy? policy,
    int? decimalPlaces,
  }) {
    final activePolicy = policy ?? defaultRepeatPolicy;
    if (attempts.isEmpty) return GpaCalculationResult.empty;

    // Apply repeat subject policy
    final effectiveAttempts = _filterAttemptsByPolicy(attempts, activePolicy, scale);

    return calculateSemesterGpa(
      effectiveAttempts,
      scale: scale,
      decimalPlaces: decimalPlaces,
    );
  }

  /// Filters attempts according to the specified policy.
  List<SemesterSubjectEntity> _filterAttemptsByPolicy(
    List<SemesterSubjectEntity> attempts,
    RepeatSubjectPolicy policy, [
    GradingScaleEntity? scale,
  ]) {
    if (policy == RepeatSubjectPolicy.allAttempts) {
      return attempts;
    }

    // Group attempts by subjectId
    final grouped = <int, List<SemesterSubjectEntity>>{};
    for (final a in attempts) {
      grouped.putIfAbsent(a.subjectId, () => []).add(a);
    }

    final result = <SemesterSubjectEntity>[];

    for (final entry in grouped.entries) {
      final list = entry.value;
      if (list.length == 1) {
        result.add(list.first);
        continue;
      }

      switch (policy) {
        case RepeatSubjectPolicy.latestAttempt:
          // Pick the one with the highest attemptNumber
          list.sort((a, b) => b.attemptNumber.compareTo(a.attemptNumber));
          result.add(list.first);
        case RepeatSubjectPolicy.bestAttempt:
          // Pick the completed attempt with best gradePoint; if inverted scale, lowest is best
          final completed = list.where((a) => a.isCompleted).toList();
          if (completed.isNotEmpty) {
            final isHigherBetter = scale?.isHigherBetter ?? true;
            if (isHigherBetter) {
              completed.sort((a, b) => b.gradePoint!.compareTo(a.gradePoint!));
            } else {
              completed.sort((a, b) => a.gradePoint!.compareTo(b.gradePoint!));
            }
            result.add(completed.first);
          } else {
            result.add(list.first);
          }
        case RepeatSubjectPolicy.allAttempts:
          result.addAll(list);
      }
    }

    return result;
  }

  double _round(double val, int places) {
    final mod = math.pow(10, places).toDouble();
    return (val * mod).round() / mod;
  }
}
