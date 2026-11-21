import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';

abstract interface class IGradingScaleRepository {
  Future<List<GradingScaleEntity>> getAllScales();
  Stream<List<GradingScaleEntity>> watchAllScales();
  Future<GradingScaleEntity?> getScaleById(int id);
  Future<GradingScaleEntity?> getDefaultScale();
  Future<void> setDefaultScale(int id);
  Future<List<GradingScaleEntryEntity>> getEntriesForScale(int scaleId);
  Future<int> createScale(GradingScaleEntity scale);
  Future<void> updateScale(GradingScaleEntity scale);
  Future<void> deleteScale(int id);
  Future<void> setActiveGradingScale(int scaleId, {bool recalculateExisting = false});
}
