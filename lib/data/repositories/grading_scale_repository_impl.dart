import 'package:drift/drift.dart';
import 'package:gpa_calculator/core/database/app_database.dart';
import 'package:gpa_calculator/core/database/daos/grading_scale_dao.dart';
import 'package:gpa_calculator/core/database/daos/student_dao.dart';
import 'package:gpa_calculator/core/database/daos/subject_dao.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entity.dart';
import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';
import 'package:gpa_calculator/domain/repositories/i_grading_scale_repository.dart';

class GradingScaleRepositoryImpl implements IGradingScaleRepository {
  final GradingScaleDao _dao;
  final StudentDao? _studentDao;
  final SubjectDao? _subjectDao;

  GradingScaleRepositoryImpl(
    this._dao, [
    this._studentDao,
    this._subjectDao,
  ]);

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
  Future<void> setDefaultScale(int id) {
    return _dao.setDefaultGradingScale(id);
  }

  @override
  Future<void> setActiveGradingScale(int scaleId, {bool recalculateExisting = false}) async {
    // 1. Mark scale as default
    await _dao.setDefaultGradingScale(scaleId);

    // 2. Update student profile if studentDao available
    if (_studentDao != null) {
      final profile = await _studentDao.getProfile();
      if (profile != null) {
        await _studentDao.updateProfile(
          StudentProfilesCompanion(
            gradingScaleId: Value(scaleId),
            updatedAt: Value(DateTime.now()),
          ),
        );
      } else {
        await _studentDao.insertProfile(
          StudentProfilesCompanion.insert(
            id: const Value(1),
            name: 'Student',
            degreeName: 'Undergraduate',
            universityName: '',
            gradingScaleId: scaleId,
          ),
        );
      }
    }

    // 3. If recalculateExisting is requested, remap existing subject attempt grade points
    if (recalculateExisting && _subjectDao != null) {
      final newEntries = await _dao.getEntriesForScale(scaleId);
      final gradeMap = <String, double>{};
      for (final e in newEntries) {
        gradeMap[e.grade.trim().toUpperCase()] = e.gradePoint;
      }

      final allAttempts = await _subjectDao.getAllSemesterSubjects();
      for (final attempt in allAttempts) {
        if (attempt.grade != null) {
          final normalized = attempt.grade!.trim().toUpperCase();
          if (gradeMap.containsKey(normalized)) {
            final newPoint = gradeMap[normalized]!;
            await _subjectDao.updateSemesterSubject(
              attempt.copyWith(
                gradePoint: Value(newPoint),
                updatedAt: DateTime.now(),
              ),
            );
          }
        }
      }
    }
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
      country: Value(scale.country),
      university: Value(scale.university),
      description: Value(scale.description),
      maximumGpa: scale.maximumGpa,
      scaleType: scale.scaleType.name,
      category: Value(scale.category),
      calculationType: Value(scale.calculationType),
      minimumValue: Value(scale.minimumValue),
      bestValue: Value(scale.bestValue),
      worstValue: Value(scale.worstValue),
      passingValue: Value(scale.passingValue),
      isHigherBetter: Value(scale.isHigherBetter),
      decimalPlaces: Value(scale.decimalPlaces),
      isDefault: Value(scale.isDefault),
    );

    final entriesCompanion = scale.entries
        .map((e) => GradingScaleEntriesCompanion.insert(
              gradingScaleId: 0, // Assigned by DAO in transaction
              grade: e.grade,
              gradePoint: e.gradePoint,
              minimumPercentage: Value(e.minimumPercentage),
              maximumPercentage: Value(e.maximumPercentage),
              isPassing: Value(e.isPassing),
              displayOrder: Value(e.displayOrder),
            ))
        .toList();

    return _dao.insertGradingScale(scaleCompanion, entriesCompanion);
  }

  @override
  Future<void> updateScale(GradingScaleEntity scale) {
    final scaleCompanion = GradingScalesCompanion(
      id: Value(scale.id),
      name: Value(scale.name),
      country: Value(scale.country),
      university: Value(scale.university),
      description: Value(scale.description),
      maximumGpa: Value(scale.maximumGpa),
      scaleType: Value(scale.scaleType.name),
      category: Value(scale.category),
      calculationType: Value(scale.calculationType),
      minimumValue: Value(scale.minimumValue),
      bestValue: Value(scale.bestValue),
      worstValue: Value(scale.worstValue),
      passingValue: Value(scale.passingValue),
      isHigherBetter: Value(scale.isHigherBetter),
      decimalPlaces: Value(scale.decimalPlaces),
      isDefault: Value(scale.isDefault),
      updatedAt: Value(DateTime.now()),
    );

    final entriesCompanion = scale.entries
        .map((e) => GradingScaleEntriesCompanion.insert(
              gradingScaleId: scale.id,
              grade: e.grade,
              gradePoint: e.gradePoint,
              minimumPercentage: Value(e.minimumPercentage),
              maximumPercentage: Value(e.maximumPercentage),
              isPassing: Value(e.isPassing),
              displayOrder: Value(e.displayOrder),
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
      country: scale.country,
      university: scale.university,
      description: scale.description,
      maximumGpa: scale.maximumGpa,
      scaleType: ScaleType.fromString(scale.scaleType),
      category: scale.category,
      calculationType: scale.calculationType,
      minimumValue: scale.minimumValue,
      bestValue: scale.bestValue,
      worstValue: scale.worstValue,
      passingValue: scale.passingValue,
      isHigherBetter: scale.isHigherBetter,
      decimalPlaces: scale.decimalPlaces,
      isDefault: scale.isDefault,
      entries: entries.map(_mapEntry).toList(),
      createdAt: scale.createdAt,
      updatedAt: scale.updatedAt,
    );
  }

  GradingScaleEntryEntity _mapEntry(GradingScaleEntry entry) {
    return GradingScaleEntryEntity(
      id: entry.id,
      gradingScaleId: entry.gradingScaleId,
      grade: entry.grade,
      gradePoint: entry.gradePoint,
      minimumPercentage: entry.minimumPercentage,
      maximumPercentage: entry.maximumPercentage,
      isPassing: entry.isPassing,
      displayOrder: entry.displayOrder,
    );
  }
}
