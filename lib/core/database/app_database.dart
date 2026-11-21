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
  int get schemaVersion => 2;

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
          if (from < 2) {
            await m.addColumn(gradingScales, gradingScales.country);
            await m.addColumn(gradingScales, gradingScales.university);
            await m.addColumn(gradingScales, gradingScales.description);
            await m.addColumn(gradingScales, gradingScales.category);
            await m.addColumn(gradingScales, gradingScales.calculationType);
            await m.addColumn(gradingScales, gradingScales.minimumValue);
            await m.addColumn(gradingScales, gradingScales.bestValue);
            await m.addColumn(gradingScales, gradingScales.worstValue);
            await m.addColumn(gradingScales, gradingScales.passingValue);
            await m.addColumn(gradingScales, gradingScales.isHigherBetter);
            await m.addColumn(gradingScales, gradingScales.decimalPlaces);

            await m.addColumn(gradingScaleEntries, gradingScaleEntries.minimumPercentage);
            await m.addColumn(gradingScaleEntries, gradingScaleEntries.maximumPercentage);
            await m.addColumn(gradingScaleEntries, gradingScaleEntries.isPassing);
            await m.addColumn(gradingScaleEntries, gradingScaleEntries.displayOrder);

            await _seedPredefinedGradingScales();
          }
        },
      );

  /// Seeds default predefined GPA scales during database creation or migration.
  /// Fully idempotent: checks existing scales by name to prevent duplicate entries.
  Future<void> _seedPredefinedGradingScales() async {
    final existingScales = await select(gradingScales).get();
    final existingNames = existingScales.map((s) => s.name).toSet();

    Future<void> insertScaleIfMissing({
      required String name,
      required String country,
      String? university,
      required String description,
      required double maximumGpa,
      required String category,
      String calculationType = 'gpa',
      double minimumValue = 0.0,
      double bestValue = 4.0,
      double worstValue = 0.0,
      double passingValue = 2.0,
      bool isHigherBetter = true,
      int decimalPlaces = 2,
      bool isDefault = false,
      required List<_ScaleEntryData> entries,
    }) async {
      if (existingNames.contains(name)) return;

      final scaleId = await into(gradingScales).insert(
        GradingScalesCompanion.insert(
          name: name,
          country: Value(country),
          university: Value(university),
          description: Value(description),
          scaleType: 'predefined',
          category: Value(category),
          calculationType: Value(calculationType),
          minimumValue: Value(minimumValue),
          maximumGpa: maximumGpa,
          bestValue: Value(bestValue),
          worstValue: Value(worstValue),
          passingValue: Value(passingValue),
          isHigherBetter: Value(isHigherBetter),
          decimalPlaces: Value(decimalPlaces),
          isDefault: Value(isDefault && existingScales.isEmpty),
        ),
      );

      for (int i = 0; i < entries.length; i++) {
        final e = entries[i];
        await into(gradingScaleEntries).insert(
          GradingScaleEntriesCompanion.insert(
            gradingScaleId: scaleId,
            grade: e.grade,
            gradePoint: e.gradePoint,
            minimumPercentage: Value(e.minPercentage),
            maximumPercentage: Value(e.maxPercentage),
            isPassing: Value(e.isPassing),
            displayOrder: Value(i),
          ),
        );
      }
    }

    // 1. United States — Standard 4.0 Scale (Default / Recommended)
    await insertScaleIfMissing(
      name: 'United States — Standard 4.0 Scale',
      country: 'United States',
      description: 'Standard 4.0 letter grade GPA system widely used across North America.',
      maximumGpa: 4.0,
      category: 'recommended',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 4.0,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      isDefault: true,
      entries: const [
        _ScaleEntryData('A+', 4.0),
        _ScaleEntryData('A', 4.0),
        _ScaleEntryData('A-', 3.7),
        _ScaleEntryData('B+', 3.3),
        _ScaleEntryData('B', 3.0),
        _ScaleEntryData('B-', 2.7),
        _ScaleEntryData('C+', 2.3),
        _ScaleEntryData('C', 2.0),
        _ScaleEntryData('C-', 1.7),
        _ScaleEntryData('D', 1.0),
        _ScaleEntryData('F', 0.0, isPassing: false),
      ],
    );

    // 2. United States — 4.3 Scale with Honours (A+ = 4.3)
    await insertScaleIfMissing(
      name: 'United States — 4.3 Scale (with A+)',
      country: 'United States',
      description: 'American 4.3 scale recognizing A+ with 4.3 grade points.',
      maximumGpa: 4.3,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 4.3,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A+', 4.3),
        _ScaleEntryData('A', 4.0),
        _ScaleEntryData('A-', 3.7),
        _ScaleEntryData('B+', 3.3),
        _ScaleEntryData('B', 3.0),
        _ScaleEntryData('B-', 2.7),
        _ScaleEntryData('C+', 2.3),
        _ScaleEntryData('C', 2.0),
        _ScaleEntryData('C-', 1.7),
        _ScaleEntryData('D+', 1.3),
        _ScaleEntryData('D', 1.0),
        _ScaleEntryData('F', 0.0, isPassing: false),
      ],
    );

    // 3. India — 10-Point CGPA (UGC / AICTE)
    await insertScaleIfMissing(
      name: 'India — 10-Point CGPA',
      country: 'India',
      description: 'Standard 10-point scale recommended by UGC/AICTE for Indian colleges and universities.',
      maximumGpa: 10.0,
      category: 'recommended',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 10.0,
      worstValue: 0.0,
      passingValue: 4.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('O', 10.0, minPercentage: 90, maxPercentage: 100),
        _ScaleEntryData('A+', 9.0, minPercentage: 80, maxPercentage: 89),
        _ScaleEntryData('A', 8.0, minPercentage: 70, maxPercentage: 79),
        _ScaleEntryData('B+', 7.0, minPercentage: 60, maxPercentage: 69),
        _ScaleEntryData('B', 6.0, minPercentage: 55, maxPercentage: 59),
        _ScaleEntryData('C', 5.0, minPercentage: 50, maxPercentage: 54),
        _ScaleEntryData('P', 4.0, minPercentage: 40, maxPercentage: 49),
        _ScaleEntryData('F', 0.0, minPercentage: 0, maxPercentage: 39, isPassing: false),
      ],
    );

    // 4. Australia — 7-Point GPA
    await insertScaleIfMissing(
      name: 'Australia — 7-Point GPA',
      country: 'Australia',
      description: 'Standard 7-point scale used across most Australian universities.',
      maximumGpa: 7.0,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 7.0,
      worstValue: 0.0,
      passingValue: 4.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('HD', 7.0, minPercentage: 85, maxPercentage: 100),
        _ScaleEntryData('D', 6.0, minPercentage: 75, maxPercentage: 84),
        _ScaleEntryData('C', 5.0, minPercentage: 65, maxPercentage: 74),
        _ScaleEntryData('P', 4.0, minPercentage: 50, maxPercentage: 64),
        _ScaleEntryData('F', 0.0, minPercentage: 0, maxPercentage: 49, isPassing: false),
      ],
    );

    // 5. Japan — 4.3 Scale
    await insertScaleIfMissing(
      name: 'Japan — 4.3 Scale',
      country: 'Japan',
      description: 'Common 4.3 grading scale used across Japanese higher education institutions.',
      maximumGpa: 4.3,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 4.3,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A+', 4.3, minPercentage: 90, maxPercentage: 100),
        _ScaleEntryData('A', 4.0, minPercentage: 80, maxPercentage: 89),
        _ScaleEntryData('B', 3.0, minPercentage: 70, maxPercentage: 79),
        _ScaleEntryData('C', 2.0, minPercentage: 60, maxPercentage: 69),
        _ScaleEntryData('C-', 1.0, minPercentage: 50, maxPercentage: 59),
        _ScaleEntryData('F', 0.0, minPercentage: 0, maxPercentage: 49, isPassing: false),
      ],
    );

    // 6. Germany — Inverted 1.0–5.0 Scale (Lower is Better)
    await insertScaleIfMissing(
      name: 'Germany — Inverted 1.0–5.0 Scale',
      country: 'Germany',
      description: 'German academic scale where 1.0 is the best possible grade and 5.0 is fail (lower is better).',
      maximumGpa: 5.0,
      category: 'country',
      calculationType: 'inverted',
      minimumValue: 1.0,
      bestValue: 1.0,
      worstValue: 5.0,
      passingValue: 4.0,
      isHigherBetter: false,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('1.0', 1.0),
        _ScaleEntryData('1.3', 1.3),
        _ScaleEntryData('1.7', 1.7),
        _ScaleEntryData('2.0', 2.0),
        _ScaleEntryData('2.3', 2.3),
        _ScaleEntryData('2.7', 2.7),
        _ScaleEntryData('3.0', 3.0),
        _ScaleEntryData('3.3', 3.3),
        _ScaleEntryData('3.7', 3.7),
        _ScaleEntryData('4.0', 4.0),
        _ScaleEntryData('5.0', 5.0, isPassing: false),
      ],
    );

    // 7. France — 0–20 Scale
    await insertScaleIfMissing(
      name: 'France — 0–20 Scale',
      country: 'France',
      description: 'French 20-point numerical system where 10 is the passing threshold.',
      maximumGpa: 20.0,
      category: 'country',
      calculationType: 'numerical',
      minimumValue: 0.0,
      bestValue: 20.0,
      worstValue: 0.0,
      passingValue: 10.0,
      isHigherBetter: true,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('Très Bien', 18.0, minPercentage: 16, maxPercentage: 20),
        _ScaleEntryData('Bien', 15.0, minPercentage: 14, maxPercentage: 15.9),
        _ScaleEntryData('Assez Bien', 13.0, minPercentage: 12, maxPercentage: 13.9),
        _ScaleEntryData('Passable', 11.0, minPercentage: 10, maxPercentage: 11.9),
        _ScaleEntryData('Ajourné', 5.0, minPercentage: 0, maxPercentage: 9.9, isPassing: false),
      ],
    );

    // 8. Netherlands — 1–10 Scale
    await insertScaleIfMissing(
      name: 'Netherlands — 1–10 Scale',
      country: 'Netherlands',
      description: 'Dutch university 10-point scale where 5.5 / 6.0 is the pass threshold.',
      maximumGpa: 10.0,
      category: 'country',
      calculationType: 'numerical',
      minimumValue: 1.0,
      bestValue: 10.0,
      worstValue: 1.0,
      passingValue: 6.0,
      isHigherBetter: true,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('10', 10.0),
        _ScaleEntryData('9', 9.0),
        _ScaleEntryData('8', 8.0),
        _ScaleEntryData('7', 7.0),
        _ScaleEntryData('6', 6.0),
        _ScaleEntryData('5', 5.0, isPassing: false),
        _ScaleEntryData('4', 4.0, isPassing: false),
        _ScaleEntryData('1-3', 2.0, isPassing: false),
      ],
    );

    // 9. Canada — 4.0 Scale (OMSAS / Standard)
    await insertScaleIfMissing(
      name: 'Canada — 4.0 Scale',
      country: 'Canada',
      description: 'Common Canadian 4.0 conversion scale (e.g., OMSAS format).',
      maximumGpa: 4.0,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 4.0,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A+', 4.0, minPercentage: 90, maxPercentage: 100),
        _ScaleEntryData('A', 3.9, minPercentage: 85, maxPercentage: 89),
        _ScaleEntryData('A-', 3.7, minPercentage: 80, maxPercentage: 84),
        _ScaleEntryData('B+', 3.3, minPercentage: 77, maxPercentage: 79),
        _ScaleEntryData('B', 3.0, minPercentage: 73, maxPercentage: 76),
        _ScaleEntryData('B-', 2.7, minPercentage: 70, maxPercentage: 72),
        _ScaleEntryData('C+', 2.3, minPercentage: 67, maxPercentage: 69),
        _ScaleEntryData('C', 2.0, minPercentage: 63, maxPercentage: 66),
        _ScaleEntryData('C-', 1.7, minPercentage: 60, maxPercentage: 62),
        _ScaleEntryData('D', 1.0, minPercentage: 50, maxPercentage: 59),
        _ScaleEntryData('F', 0.0, minPercentage: 0, maxPercentage: 49, isPassing: false),
      ],
    );

    // 10. Canada — 4.3 Scale
    await insertScaleIfMissing(
      name: 'Canada — 4.3 Scale',
      country: 'Canada',
      description: 'Canadian 4.3 GPA scale used by universities awarding 4.3 for A+.',
      maximumGpa: 4.3,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 4.3,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A+', 4.3),
        _ScaleEntryData('A', 4.0),
        _ScaleEntryData('A-', 3.7),
        _ScaleEntryData('B+', 3.3),
        _ScaleEntryData('B', 3.0),
        _ScaleEntryData('B-', 2.7),
        _ScaleEntryData('C+', 2.3),
        _ScaleEntryData('C', 2.0),
        _ScaleEntryData('C-', 1.7),
        _ScaleEntryData('D', 1.0),
        _ScaleEntryData('F', 0.0, isPassing: false),
      ],
    );

    // 11. New Zealand — 9-Point Scale
    await insertScaleIfMissing(
      name: 'New Zealand — 9-Point Scale',
      country: 'New Zealand',
      description: 'New Zealand 9-point university grade point average scale.',
      maximumGpa: 9.0,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 9.0,
      worstValue: 0.0,
      passingValue: 2.0,
      isHigherBetter: true,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('A+', 9.0),
        _ScaleEntryData('A', 8.0),
        _ScaleEntryData('A-', 7.0),
        _ScaleEntryData('B+', 6.0),
        _ScaleEntryData('B', 5.0),
        _ScaleEntryData('B-', 4.0),
        _ScaleEntryData('C+', 3.0),
        _ScaleEntryData('C', 2.0),
        _ScaleEntryData('C-', 1.0, isPassing: false),
        _ScaleEntryData('D', 0.0, isPassing: false),
      ],
    );

    // 12. Philippines — 1.0–5.0 Inverted Scale (Lower is Better)
    await insertScaleIfMissing(
      name: 'Philippines — 1.0–5.0 Inverted Scale',
      country: 'Philippines',
      description: 'Philippine higher education 5-point grading system where 1.0 is highest and 3.0 is passing.',
      maximumGpa: 5.0,
      category: 'country',
      calculationType: 'inverted',
      minimumValue: 1.0,
      bestValue: 1.0,
      worstValue: 5.0,
      passingValue: 3.0,
      isHigherBetter: false,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('1.00', 1.0),
        _ScaleEntryData('1.25', 1.25),
        _ScaleEntryData('1.50', 1.5),
        _ScaleEntryData('1.75', 1.75),
        _ScaleEntryData('2.00', 2.0),
        _ScaleEntryData('2.25', 2.25),
        _ScaleEntryData('2.50', 2.5),
        _ScaleEntryData('2.75', 2.75),
        _ScaleEntryData('3.00', 3.0),
        _ScaleEntryData('4.00', 4.0, isPassing: false),
        _ScaleEntryData('5.00', 5.0, isPassing: false),
      ],
    );

    // 13. Nigeria / Ghana — 5.0 Scale
    await insertScaleIfMissing(
      name: 'Nigeria / Ghana — 5.0 Scale',
      country: 'Nigeria',
      description: 'West African standard 5.0 CGPA classification system.',
      maximumGpa: 5.0,
      category: 'country',
      calculationType: 'gpa',
      minimumValue: 0.0,
      bestValue: 5.0,
      worstValue: 0.0,
      passingValue: 1.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A', 5.0, minPercentage: 70, maxPercentage: 100),
        _ScaleEntryData('B', 4.0, minPercentage: 60, maxPercentage: 69),
        _ScaleEntryData('C', 3.0, minPercentage: 50, maxPercentage: 59),
        _ScaleEntryData('D', 2.0, minPercentage: 45, maxPercentage: 49),
        _ScaleEntryData('E', 1.0, minPercentage: 40, maxPercentage: 44),
        _ScaleEntryData('F', 0.0, minPercentage: 0, maxPercentage: 39, isPassing: false),
      ],
    );

    // 14. Brazil — 0–10 Scale
    await insertScaleIfMissing(
      name: 'Brazil — 0–10 Scale',
      country: 'Brazil',
      description: 'Brazilian academic grading scale with letter and numerical equivalents.',
      maximumGpa: 10.0,
      category: 'country',
      calculationType: 'numerical',
      minimumValue: 0.0,
      bestValue: 10.0,
      worstValue: 0.0,
      passingValue: 5.0,
      isHigherBetter: true,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('SS', 9.5, minPercentage: 9.0, maxPercentage: 10.0),
        _ScaleEntryData('MS', 8.0, minPercentage: 7.0, maxPercentage: 8.9),
        _ScaleEntryData('MM', 6.0, minPercentage: 5.0, maxPercentage: 6.9),
        _ScaleEntryData('MI', 4.0, minPercentage: 3.0, maxPercentage: 4.9, isPassing: false),
        _ScaleEntryData('II', 2.0, minPercentage: 0.1, maxPercentage: 2.9, isPassing: false),
        _ScaleEntryData('SR', 0.0, minPercentage: 0.0, maxPercentage: 0.0, isPassing: false),
      ],
    );

    // 15. United Kingdom — Honours / Percentage Classification
    await insertScaleIfMissing(
      name: 'United Kingdom — Honours Classification',
      country: 'United Kingdom',
      description: 'UK degree classification boundaries based on percentage marks.',
      maximumGpa: 100.0,
      category: 'international',
      calculationType: 'percentage',
      minimumValue: 0.0,
      bestValue: 100.0,
      worstValue: 0.0,
      passingValue: 40.0,
      isHigherBetter: true,
      decimalPlaces: 1,
      entries: const [
        _ScaleEntryData('First Class (1st)', 75.0, minPercentage: 70, maxPercentage: 100),
        _ScaleEntryData('Upper Second (2:1)', 65.0, minPercentage: 60, maxPercentage: 69),
        _ScaleEntryData('Lower Second (2:2)', 55.0, minPercentage: 50, maxPercentage: 59),
        _ScaleEntryData('Third Class (3rd)', 45.0, minPercentage: 40, maxPercentage: 49),
        _ScaleEntryData('Fail', 25.0, minPercentage: 0, maxPercentage: 39, isPassing: false),
      ],
    );

    // 16. ECTS — European Credit Transfer System
    await insertScaleIfMissing(
      name: 'ECTS — European Credit Transfer System',
      country: 'European Union',
      description: 'European Credit Transfer and Accumulation System relative grading template.',
      maximumGpa: 4.0,
      category: 'international',
      calculationType: 'letter',
      minimumValue: 0.0,
      bestValue: 4.0,
      worstValue: 0.0,
      passingValue: 2.0,
      isHigherBetter: true,
      decimalPlaces: 2,
      entries: const [
        _ScaleEntryData('A', 4.0),
        _ScaleEntryData('B', 3.5),
        _ScaleEntryData('C', 3.0),
        _ScaleEntryData('D', 2.5),
        _ScaleEntryData('E', 2.0),
        _ScaleEntryData('FX', 0.0, isPassing: false),
        _ScaleEntryData('F', 0.0, isPassing: false),
      ],
    );
  }
}

class _ScaleEntryData {
  final String grade;
  final double gradePoint;
  final double? minPercentage;
  final double? maxPercentage;
  final bool isPassing;

  const _ScaleEntryData(
    this.grade,
    this.gradePoint, {
    this.minPercentage,
    this.maxPercentage,
    this.isPassing = true,
  });
}
