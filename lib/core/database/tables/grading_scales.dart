import 'package:drift/drift.dart';

/// Table representing predefined and custom GPA grading scales.
class GradingScales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get maximumGpa => real()();
  TextColumn get scaleType => text()(); // 'predefined' or 'custom'
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

