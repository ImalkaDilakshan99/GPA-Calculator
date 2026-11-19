import 'package:drift/drift.dart';

/// Table representing reusable academic subjects.
class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get subjectName => text()();
  TextColumn get subjectCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

