import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/tables/grading_scales.dart';

/// Table representing the single student profile.
///
/// Enforces the single-profile requirement at the schema level using a CHECK (id = 1) constraint.
class StudentProfiles extends Table {
  IntColumn get id =>
      integer().named('id').customConstraint('NOT NULL CHECK (id = 1)')();
  TextColumn get name => text()();
  TextColumn get degreeName => text()();
  TextColumn get universityName => text()();
  TextColumn get profilePhotoPath => text().nullable()();
  IntColumn get gradingScaleId => integer().references(GradingScales, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

