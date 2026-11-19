/// Denotes whether a grading scale is predefined by the system or custom created by the user.
enum ScaleType {
  predefined,
  custom;

  static ScaleType fromString(String value) {
    return value.toLowerCase() == 'custom' ? ScaleType.custom : ScaleType.predefined;
  }
}

