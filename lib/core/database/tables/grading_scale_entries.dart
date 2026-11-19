import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/tables/grading_scales.dart';

/// Table representing grade-to-grade-point mappings for a grading scale.
class GradingScaleEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gradingScaleId => integer().references(
        GradingScales,
        #id,
        onDelete: KeyAction.cascade,
      )();
  TextColumn get grade => text()();
  RealColumn get gradePoint =>
      real().customConstraint('NOT NULL CHECK (grade_point >= 0.0)')();

  @override
  List<Set<Column>> get uniqueKeys => [
        {gradingScaleId, grade},
      ];
}

