import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/grading_scale_dao.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/domain/repositories/i_grading_scale_repository.dart';

class GradingScaleRepositoryImpl implements IGradingScaleRepository {
  final GradingScaleDao _dao;

  GradingScaleRepositoryImpl(this._dao);

  @override
  Future<List<GradingScaleEntity>> getAllScales() async {
    final scales = await _dao.getAllGradingScales();
    final result = <GradingScaleEntity>[];
    for (final s in scales) {
      final entries = await _dao.getEntriesForScale(s.id);
      result.add(_mapScale(s, entries));
    }
    return result;
  }

  @override
  Stream<List<GradingScaleEntity>> watchAllScales() {
    return _dao.watchGradingScales().asyncMap((scales) async {
      final result = <GradingScaleEntity>[];
      for (final s in scales) {
        final entries = await _dao.getEntriesForScale(s.id);
        result.add(_mapScale(s, entries));
      }
      return result;
    });
  }

  @override
  Future<GradingScaleEntity?> getScaleById(int id) async {
    final scale = await _dao.getGradingScaleById(id);
    if (scale == null) return null;
    final entries = await _dao.getEntriesForScale(id);
    return _mapScale(scale, entries);
  }

  @override
  Future<GradingScaleEntity?> getDefaultScale() async {
    final scale = await _dao.getDefaultGradingScale();
    if (scale == null) return null;
    final entries = await _dao.getEntriesForScale(scale.id);
    return _mapScale(scale, entries);
  }

  @override
  Future<List<GradingScaleEntryEntity>> getEntriesForScale(int scaleId) async {
    final entries = await _dao.getEntriesForScale(scaleId);
    return entries.map(_mapEntry).toList();
  }

  @override
  Future<int> createScale(GradingScaleEntity scale) {
    final scaleCompanion = GradingScalesCompanion.insert(
      name: scale.name,
      maximumGpa: scale.maximumGpa,
      scaleType: scale.scaleType.name,
      isDefault: Value(scale.isDefault),
    );

    final entriesCompanion = scale.entries
        .map((e) => GradingScaleEntriesCompanion.insert(
              gradingScaleId: 0, // Assigned by DAO in transaction
              grade: e.grade,
              gradePoint: e.gradePoint,
            ))
        .toList();

    return _dao.insertGradingScale(scaleCompanion, entriesCompanion);
  }

  @override
  Future<void> updateScale(GradingScaleEntity scale) {
    final scaleCompanion = GradingScalesCompanion(
      id: Value(scale.id),
      name: Value(scale.name),
      maximumGpa: Value(scale.maximumGpa),
      scaleType: Value(scale.scaleType.name),
      isDefault: Value(scale.isDefault),
      updatedAt: Value(DateTime.now()),
    );

    final entriesCompanion = scale.entries
        .map((e) => GradingScaleEntriesCompanion.insert(
              gradingScaleId: scale.id,
              grade: e.grade,
              gradePoint: e.gradePoint,
            ))
        .toList();

    return _dao.updateGradingScale(scale.id, scaleCompanion, entriesCompanion);
  }

  @override
  Future<void> deleteScale(int id) {
    return _dao.deleteGradingScale(id);
  }

  GradingScaleEntity _mapScale(GradingScale scale, List<GradingScaleEntry> entries) {
    return GradingScaleEntity(
      id: scale.id,
      name: scale.name,
      maximumGpa: scale.maximumGpa,
      scaleType: ScaleType.fromString(scale.scaleType),
      isDefault: scale.isDefault,
      entries: entries.map(_mapEntry).toList(),
      createdAt: scale.createdAt,
      updatedAt: scale.updatedAt,
    );
  }

  GradingScaleEntryEntity _mapEntry(GradingScaleEntry e) {
    return GradingScaleEntryEntity(
      id: e.id,
      gradingScaleId: e.gradingScaleId,
      grade: e.grade,
      gradePoint: e.gradePoint,
    );
  }
}

