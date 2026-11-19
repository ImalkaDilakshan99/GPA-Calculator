/// Policy defining how repeated subjects are handled in cumulative GPA calculations.
enum RepeatSubjectPolicy {
  /// Only the most recent attempt of a subject contributes to the cumulative GPA.
  latestAttempt,

  /// The attempt with the highest grade-point value contributes to the cumulative GPA.
  bestAttempt,

  /// Every attempt of a subject is included in the cumulative GPA calculation.
  allAttempts,
}

