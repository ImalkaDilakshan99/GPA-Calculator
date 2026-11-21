import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/tables/grading_scale_entries.dart';
import 'package:gpa_calculator/core/database/tables/grading_scales.dart';
import 'package:gpa_calculator/core/database/tables/student_profiles.dart';

part 'grading_scale_dao.g.dart';

@DriftAccessor(tables: [GradingScales, GradingScaleEntries, StudentProfiles])
class GradingScaleDao extends DatabaseAccessor<AppDatabase>
    with _$GradingScaleDaoMixin {
  GradingScaleDao(super.db);

  /// Inserts a grading scale and its associated entries transactionally.
  Future<int> insertGradingScale(
    GradingScalesCompanion scale,
    List<GradingScaleEntriesCompanion> entries,
  ) {
    return transaction(() async {
      // Validate entry grade points do not exceed maximumGpa for higher-is-better scales
      final maxGpa = scale.maximumGpa.value;
      final isHigherBetter = scale.isHigherBetter.present ? scale.isHigherBetter.value : true;
      if (isHigherBetter) {
        for (final entry in entries) {
          if (entry.gradePoint.value > maxGpa) {
            throw ArgumentError(
              'Grade point (${entry.gradePoint.value}) exceeds maximum scale GPA ($maxGpa)',
            );
          }
        }
      }

      final scaleId = await into(gradingScales).insert(scale);
      for (int i = 0; i < entries.length; i++) {
        final entry = entries[i];
        final order = entry.displayOrder.present ? entry.displayOrder.value : i;
        await into(gradingScaleEntries).insert(
          entry.copyWith(
            gradingScaleId: Value(scaleId),
            displayOrder: Value(order),
          ),
        );
      }
      return scaleId;
    });
  }

  /// Retrieves all grading scales.
  Future<List<GradingScale>> getAllGradingScales() {
    return (select(gradingScales)
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.id),
          ]))
        .get();
  }

  /// Observes all grading scales.
  Stream<List<GradingScale>> watchGradingScales() {
    return (select(gradingScales)
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.id),
          ]))
        .watch();
  }

  /// Retrieves a specific grading scale by ID.
  Future<GradingScale?> getGradingScaleById(int id) {
    return (select(gradingScales)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  /// Retrieves the default grading scale.
  Future<GradingScale?> getDefaultGradingScale() {
    return (select(gradingScales)
          ..where((tbl) => tbl.isDefault.equals(true))
          ..limit(1))
        .getSingleOrNull();
  }

  /// Sets a specific grading scale as default and unsets all others transactionally.
  Future<void> setDefaultGradingScale(int id) {
    return transaction(() async {
      await update(gradingScales).write(
        const GradingScalesCompanion(isDefault: Value(false)),
      );
      await (update(gradingScales)..where((tbl) => tbl.id.equals(id))).write(
        const GradingScalesCompanion(isDefault: Value(true)),
      );
    });
  }

  /// Retrieves all grade-to-point entries for a given scale in order.
  Future<List<GradingScaleEntry>> getEntriesForScale(int scaleId) {
    return (select(gradingScaleEntries)
          ..where((tbl) => tbl.gradingScaleId.equals(scaleId))
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.displayOrder),
            (tbl) => OrderingTerm.desc(tbl.gradePoint),
            (tbl) => OrderingTerm.asc(tbl.id),
          ]))
        .get();
  }

  /// Observes entries for a given scale in order.
  Stream<List<GradingScaleEntry>> watchEntriesForScale(int scaleId) {
    return (select(gradingScaleEntries)
          ..where((tbl) => tbl.gradingScaleId.equals(scaleId))
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.displayOrder),
            (tbl) => OrderingTerm.desc(tbl.gradePoint),
            (tbl) => OrderingTerm.asc(tbl.id),
          ]))
        .watch();
  }

  /// Updates an editable (custom) grading scale and optionally replaces its entries.
  Future<void> updateGradingScale(
    int id,
    GradingScalesCompanion scale,
    List<GradingScaleEntriesCompanion>? entries,
  ) {
    return transaction(() async {
      final existing = await getGradingScaleById(id);
      if (existing == null) {
        throw StateError('Grading scale with id $id not found.');
      }
      if (existing.scaleType == 'predefined') {
        throw StateError('Predefined grading scales cannot be modified.');
      }

      await (update(gradingScales)..where((tbl) => tbl.id.equals(id))).write(
        scale.copyWith(updatedAt: Value(DateTime.now())),
      );

      if (entries != null) {
        // Delete old entries and re-insert new ones
        await (delete(gradingScaleEntries)
              ..where((tbl) => tbl.gradingScaleId.equals(id)))
            .go();
        for (int i = 0; i < entries.length; i++) {
          final entry = entries[i];
          final order = entry.displayOrder.present ? entry.displayOrder.value : i;
          await into(gradingScaleEntries).insert(
            entry.copyWith(
              gradingScaleId: Value(id),
              displayOrder: Value(order),
            ),
          );
        }
      }
    });
  }

  /// Deletes a custom grading scale, ensuring it is not currently assigned to the student.
  Future<void> deleteGradingScale(int id) {
    return transaction(() async {
      final existing = await getGradingScaleById(id);
      if (existing == null) {
        throw StateError('Grading scale with id $id not found.');
      }
      if (existing.scaleType == 'predefined') {
        throw StateError('Predefined grading scales cannot be deleted.');
      }

      // Check if student profile currently references this grading scale
      final profile = await (select(studentProfiles)
            ..where((tbl) => tbl.gradingScaleId.equals(id)))
          .getSingleOrNull();
      if (profile != null) {
        throw StateError(
          'Cannot delete grading scale currently assigned to the student profile.',
        );
      }

      await (delete(gradingScales)..where((tbl) => tbl.id.equals(id))).go();
    });
  }
}
