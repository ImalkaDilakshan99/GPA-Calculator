import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/tables/semesters.dart';
import 'package:gpa_calculator/core/database/tables/subjects.dart';

/// Table connecting subjects with semesters and storing individual attempts.
class SemesterSubjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get semesterId => integer().references(
        Semesters,
        #id,
        onDelete: KeyAction.cascade,
      )();
  IntColumn get subjectId => integer().references(
        Subjects,
        #id,
        onDelete: KeyAction.restrict,
      )();
  IntColumn get attemptNumber => integer().withDefault(const Constant(1))();
  RealColumn get credits =>
      real().customConstraint('NOT NULL CHECK (credits > 0.0)')();
  TextColumn get grade => text().nullable()();
  RealColumn get gradePoint => real()
      .nullable()
      .customConstraint('CHECK (grade_point IS NULL OR grade_point >= 0.0)')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        // Prevent duplicate attempt numbers for the same subject across history
        {subjectId, attemptNumber},
        // Prevent duplicate entries for the same subject within the same semester
        {semesterId, subjectId},
      ];
}

