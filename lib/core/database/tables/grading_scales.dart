import 'package:drift/drift.dart';

/// Table representing predefined and custom GPA grading scales worldwide.
class GradingScales extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get country => text().nullable()();
  TextColumn get university => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get scaleType => text()(); // 'predefined' or 'custom'
  TextColumn get category => text().withDefault(const Constant('general'))(); // 'recommended', 'international', 'country', 'university', 'custom'
  TextColumn get calculationType => text().withDefault(const Constant('gpa'))(); // 'gpa', 'percentage', 'numerical', 'inverted', 'letter', 'custom'
  RealColumn get minimumValue => real().withDefault(const Constant(0.0))();
  RealColumn get maximumGpa => real()();
  RealColumn get bestValue => real().withDefault(const Constant(4.0))();
  RealColumn get worstValue => real().withDefault(const Constant(0.0))();
  RealColumn get passingValue => real().withDefault(const Constant(2.0))();
  BoolColumn get isHigherBetter => boolean().withDefault(const Constant(true))();
  IntColumn get decimalPlaces => integer().withDefault(const Constant(2))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
