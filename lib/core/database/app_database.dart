import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:gpa_calculator/core/database/daos/grading_scale_dao.dart';
import 'package:gpa_calculator/core/database/daos/semester_dao.dart';
import 'package:gpa_calculator/core/database/daos/student_dao.dart';
import 'package:gpa_calculator/core/database/daos/subject_dao.dart';
import 'package:gpa_calculator/core/database/tables/grading_scale_entries.dart';
import 'package:gpa_calculator/core/database/tables/grading_scales.dart';
import 'package:gpa_calculator/core/database/tables/semester_subjects.dart';
import 'package:gpa_calculator/core/database/tables/semesters.dart';
import 'package:gpa_calculator/core/database/tables/student_profiles.dart';
import 'package:gpa_calculator/core/database/tables/subjects.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    StudentProfiles,
    GradingScales,
    GradingScaleEntries,
    Semesters,
    Subjects,
    SemesterSubjects,
  ],
  daos: [
    StudentDao,
    GradingScaleDao,
    SemesterDao,
    SubjectDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  /// Named constructor for in-memory testing or custom connections.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'gpa_calculator_db');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          // Enable foreign keys constraint enforcement in SQLite
          await customStatement('PRAGMA foreign_keys = ON;');
        },
        onCreate: (m) async {
          await m.createAll();
          await _seedPredefinedGradingScales();
        },
        onUpgrade: (m, from, to) async {
          // Future database migration steps will be handled here incrementally
        },
      );

  /// Seeds default predefined GPA scales during database creation.
  Future<void> _seedPredefinedGradingScales() async {
    // 1. Standard 4.0 Scale (Default)
    final scale40Id = await into(gradingScales).insert(
      GradingScalesCompanion.insert(
        name: 'Standard 4.0 Scale',
        maximumGpa: 4.0,
        scaleType: 'predefined',
        isDefault: const Value(true),
      ),
    );

    const standard40Entries = [
      ('A+', 4.0),
      ('A', 4.0),
      ('A-', 3.7),
      ('B+', 3.3),
      ('B', 3.0),
      ('B-', 2.7),
      ('C+', 2.3),
      ('C', 2.0),
      ('C-', 1.7),
      ('D', 1.0),
      ('F', 0.0),
    ];

    for (final (grade, point) in standard40Entries) {
      await into(gradingScaleEntries).insert(
        GradingScaleEntriesCompanion.insert(
          gradingScaleId: scale40Id,
          grade: grade,
          gradePoint: point,
        ),
      );
    }

    // 2. Standard 4.3 Scale
    final scale43Id = await into(gradingScales).insert(
      GradingScalesCompanion.insert(
        name: 'Standard 4.3 Scale',
        maximumGpa: 4.3,
        scaleType: 'predefined',
        isDefault: const Value(false),
      ),
    );

    const standard43Entries = [
      ('A+', 4.3),
      ('A', 4.0),
      ('A-', 3.7),
      ('B+', 3.3),
      ('B', 3.0),
      ('B-', 2.7),
      ('C+', 2.3),
      ('C', 2.0),
      ('C-', 1.7),
      ('D+', 1.3),
      ('D', 1.0),
      ('F', 0.0),
    ];

    for (final (grade, point) in standard43Entries) {
      await into(gradingScaleEntries).insert(
        GradingScaleEntriesCompanion.insert(
          gradingScaleId: scale43Id,
          grade: grade,
          gradePoint: point,
        ),
      );
    }

    // 3. Standard 5.0 Scale
    final scale50Id = await into(gradingScales).insert(
      GradingScalesCompanion.insert(
        name: 'Standard 5.0 Scale',
        maximumGpa: 5.0,
        scaleType: 'predefined',
        isDefault: const Value(false),
      ),
    );

    const standard50Entries = [
      ('A+', 5.0),
      ('A', 4.5),
      ('B+', 4.0),
      ('B', 3.5),
      ('C+', 3.0),
      ('C', 2.5),
      ('D', 2.0),
      ('F', 0.0),
    ];

    for (final (grade, point) in standard50Entries) {
      await into(gradingScaleEntries).insert(
        GradingScaleEntriesCompanion.insert(
          gradingScaleId: scale50Id,
          grade: grade,
          gradePoint: point,
        ),
      );
    }
  }
}

