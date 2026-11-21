import 'package:drift/drift.dart' show OpeningDetails;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/database_providers.dart';
import 'package:gpa_calculator/core/services/gpa_calculator_service.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/entities/semester_subject_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/view/pages/custom_scale_editor_view.dart';
import 'package:gpa_calculator/view/pages/grading_scale_management_view.dart';
import 'package:gpa_calculator/viewModels/grading_scale_view_model.dart';

void main() {
  group('GPA Calculator Service - Scale Aware & Worldwide Scales', () {
    const service = GpaCalculatorService();

    test('Standard 4.0 Scale: calculates credit-weighted GPA accurately', () {
      final now = DateTime.now();
      final usScale = GradingScaleEntity(
        id: 1,
        name: 'US 4.0',
        maximumGpa: 4.0,
        scaleType: ScaleType.predefined,
        minimumValue: 0.0,
        bestValue: 4.0,
        worstValue: 0.0,
        passingValue: 1.0,
        isHigherBetter: true,
        decimalPlaces: 2,
        createdAt: now,
        updatedAt: now,
      );

      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 1,
          credits: 3.0,
          grade: 'A',
          gradePoint: 4.0,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 2,
          credits: 4.0,
          grade: 'B',
          gradePoint: 3.0,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 3,
          semesterId: 1,
          subjectId: 3,
          credits: 2.0,
          grade: 'A-',
          gradePoint: 3.7,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      // GPA = (3*4.0 + 4*3.0 + 2*3.7) / (3 + 4 + 2) = (12 + 12 + 7.4) / 9 = 31.4 / 9 = 3.49
      final result = service.calculateSemesterGpa(subjects, scale: usScale);
      expect(result.gpa, 3.49);
      expect(result.totalCredits, 9.0);
      expect(result.completedSubjectsCount, 3);
      expect(result.failedSubjectsCount, 0);
    });

    test('India 10-Point CGPA Scale: calculates weighted CGPA on 10.0 scale', () {
      final now = DateTime.now();
      final indiaScale = GradingScaleEntity(
        id: 2,
        name: 'India 10-Point',
        maximumGpa: 10.0,
        scaleType: ScaleType.predefined,
        minimumValue: 0.0,
        bestValue: 10.0,
        worstValue: 0.0,
        passingValue: 4.0,
        isHigherBetter: true,
        decimalPlaces: 2,
        createdAt: now,
        updatedAt: now,
      );

      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 1,
          credits: 4.0,
          grade: 'O',
          gradePoint: 10.0,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 2,
          credits: 4.0,
          grade: 'A+',
          gradePoint: 9.0,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 3,
          semesterId: 1,
          subjectId: 3,
          credits: 2.0,
          grade: 'F',
          gradePoint: 0.0,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      // GPA = (4*10 + 4*9 + 2*0) / 10 = (40 + 36 + 0) / 10 = 7.60
      final result = service.calculateSemesterGpa(subjects, scale: indiaScale);
      expect(result.gpa, 7.60);
      expect(result.totalCredits, 10.0);
      expect(result.completedSubjectsCount, 3);
      expect(result.failedSubjectsCount, 1);
    });

    test('Germany Inverted Scale: handles lower-is-better calculation and failures', () {
      final now = DateTime.now();
      final germanyScale = GradingScaleEntity(
        id: 3,
        name: 'Germany Inverted',
        maximumGpa: 5.0,
        scaleType: ScaleType.predefined,
        minimumValue: 1.0,
        bestValue: 1.0,
        worstValue: 5.0,
        passingValue: 4.0,
        isHigherBetter: false,
        decimalPlaces: 1,
        createdAt: now,
        updatedAt: now,
      );

      final subjects = [
        SemesterSubjectEntity(
          id: 1,
          semesterId: 1,
          subjectId: 1,
          credits: 6.0,
          grade: '1.3',
          gradePoint: 1.3,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 2,
          semesterId: 1,
          subjectId: 2,
          credits: 4.0,
          grade: '2.0',
          gradePoint: 2.0,
          createdAt: now,
          updatedAt: now,
        ),
        SemesterSubjectEntity(
          id: 3,
          semesterId: 1,
          subjectId: 3,
          credits: 5.0,
          grade: '5.0',
          gradePoint: 5.0, // Fail in Germany (> 4.0)
          createdAt: now,
          updatedAt: now,
        ),
      ];

      // Weighted German average = (6*1.3 + 4*2.0 + 5*5.0) / 15 = (7.8 + 8.0 + 25.0) / 15 = 40.8 / 15 = 2.72 -> 2.7
      final result = service.calculateSemesterGpa(subjects, scale: germanyScale);
      expect(result.gpa, 2.7);
      expect(result.totalCredits, 15.0);
      expect(result.failedSubjectsCount, 1);
    });

    test('Empty subjects and zero credits return safe empty result', () {
      final emptyResult = service.calculateSemesterGpa([]);
      expect(emptyResult.gpa, 0.0);
      expect(emptyResult.totalCredits, 0.0);
    });
  });

  group('Database & Repository - Grading Scales Management', () {
    late AppDatabase db;
    late ProviderContainer container;

    setUp(() async {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      await db.customSelect('SELECT 1').get();

      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    test('Predefined scales catalog seeds all 16 worldwide scales without duplication', () async {
      final repo = container.read(gradingScaleRepositoryProvider);
      final scales = await repo.getAllScales();

      expect(scales.length, 16);

      // Verify international presence
      final countries = scales.map((s) => s.country).toSet();
      expect(countries, contains('United States'));
      expect(countries, contains('India'));
      expect(countries, contains('Australia'));
      expect(countries, contains('Germany'));
      expect(countries, contains('Japan'));
      expect(countries, contains('France'));
      expect(countries, contains('Netherlands'));
      expect(countries, contains('Canada'));
      expect(countries, contains('United Kingdom'));

      // Check idempotent re-seeding (does not duplicate)
      await db.migration.beforeOpen!(const OpeningDetails(2, 2));
      final rechecked = await repo.getAllScales();
      expect(rechecked.length, 16);
    });

    test('Custom scale CRUD operations persist and delete cleanly', () async {
      final repo = container.read(gradingScaleRepositoryProvider);
      final now = DateTime.now();

      // Create Custom Scale
      final customScale = GradingScaleEntity(
        id: 0,
        name: 'Stanford CS 4.0 Scale',
        country: 'United States',
        university: 'Stanford University',
        description: 'Department of Computer Science custom grading scale',
        maximumGpa: 4.0,
        scaleType: ScaleType.custom,
        category: 'university',
        calculationType: 'gpa',
        minimumValue: 0.0,
        bestValue: 4.0,
        worstValue: 0.0,
        passingValue: 1.0,
        isHigherBetter: true,
        decimalPlaces: 2,
        entries: [
          GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'A+', gradePoint: 4.0, isPassing: true, displayOrder: 0),
          GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'A', gradePoint: 4.0, isPassing: true, displayOrder: 1),
          GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'B', gradePoint: 3.0, isPassing: true, displayOrder: 2),
          GradingScaleEntryEntity(id: 0, gradingScaleId: 0, grade: 'NP', gradePoint: 0.0, isPassing: false, displayOrder: 3),
        ],
        createdAt: now,
        updatedAt: now,
      );

      final newScaleId = await repo.createScale(customScale);
      expect(newScaleId, greaterThan(0));

      final retrieved = await repo.getScaleById(newScaleId);
      expect(retrieved, isNotNull);
      expect(retrieved!.name, 'Stanford CS 4.0 Scale');
      expect(retrieved.university, 'Stanford University');
      expect(retrieved.entries.length, 4);

      // Update Custom Scale
      final updatedScale = retrieved.copyWith(
        name: 'Stanford CS 4.0 Scale (Updated)',
        description: 'Updated description',
      );
      await repo.updateScale(updatedScale);

      final afterUpdate = await repo.getScaleById(newScaleId);
      expect(afterUpdate!.name, 'Stanford CS 4.0 Scale (Updated)');
      expect(afterUpdate.description, 'Updated description');

      // Delete Custom Scale
      await repo.deleteScale(newScaleId);
      final afterDelete = await repo.getScaleById(newScaleId);
      expect(afterDelete, isNull);
    });

    test('setActiveGradingScale marks default scale and updates student profile', () async {
      final repo = container.read(gradingScaleRepositoryProvider);
      final allScales = await repo.getAllScales();
      final indiaScale = allScales.firstWhere((s) => s.country == 'India');

      await repo.setActiveGradingScale(indiaScale.id, recalculateExisting: false);

      final defaultScale = await repo.getDefaultScale();
      expect(defaultScale, isNotNull);
      expect(defaultScale!.id, indiaScale.id);
      expect(defaultScale.country, 'India');
    });
  });

  group('UI & Widget Tests - Grading Scale Screens', () {
    late AppDatabase db;
    late ProviderContainer container;

    setUp(() async {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      await db.customSelect('SELECT 1').get();

      container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await db.close();
    });

    testWidgets('GradingScaleManagementView displays active banner, categories, and scales', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: GradingScaleManagementView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header Elements
      expect(find.text('GPA Grading Scales'), findsOneWidget);
      expect(find.text('CURRENT ACTIVE SCALE'), findsOneWidget);
      expect(find.text('Create Custom Scale'), findsOneWidget);

      // Verify Category Filter Pills
      expect(find.text('All Scales'), findsOneWidget);
      expect(find.text('Recommended'), findsOneWidget);
      expect(find.text('International'), findsOneWidget);
      expect(find.text('Country-Based'), findsOneWidget);

      // Verify Search TextField
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('Searching scales filters results correctly', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: GradingScaleManagementView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter "Germany" in search field
      await tester.enterText(find.byType(TextField), 'Germany');
      await tester.pumpAndSettle();

      // Should find German scale
      expect(find.text('Germany — Inverted 1.0–5.0 Scale'), findsOneWidget);
      // Other countries should not be visible
      expect(find.text('Australia — 7-Point GPA'), findsNothing);
    });

    testWidgets('Tapping an unselected scale opens confirmation dialog with future and recalculate options', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: GradingScaleManagementView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Search for Australia to bring it immediately into view
      await tester.enterText(find.byType(TextField), 'Australia');
      await tester.pumpAndSettle();

      // Find Australia scale card and tap it
      final australiaCard = find.text('Australia — 7-Point GPA');
      expect(australiaCard, findsOneWidget);
      await tester.tap(australiaCard);
      await tester.pumpAndSettle();

      // Verify Dialog Content
      expect(find.text('Select "Australia — 7-Point GPA"?'), findsOneWidget);
      expect(find.text('• Apply to Future Subjects (Recommended)'), findsOneWidget);
      expect(find.text('• Recalculate Existing Subjects'), findsOneWidget);
      expect(find.text('Future Only'), findsOneWidget);
      expect(find.text('Recalculate All'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);

      // Tap Future Only
      await tester.tap(find.text('Future Only'));
      await tester.pumpAndSettle();

      // Verify dialog dismissed and Australia is now active
      final activeScale = container.read(activeGradingScaleProvider);
      expect(activeScale.name, 'Australia — 7-Point GPA');
    });

    testWidgets('CustomScaleEditorView renders and validates form inputs', (tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: CustomScaleEditorView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Create Custom Scale'), findsOneWidget);
      expect(find.text('Basic Information'), findsOneWidget);
      expect(find.text('Scale Configuration'), findsOneWidget);
      expect(find.text('Grade Mapping Table'), findsOneWidget);

      // Verify preloaded template entries
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
      expect(find.text('F'), findsOneWidget);

      // Save with valid inputs
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Scale Name * (e.g. Harvard 4.0, Mumbai Univ 10)'),
        'My University Scale',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify scale was created in DB
      final repo = container.read(gradingScaleRepositoryProvider);
      final allScales = await repo.getAllScales();
      expect(allScales.any((s) => s.name == 'My University Scale'), isTrue);
    });
  });
}
