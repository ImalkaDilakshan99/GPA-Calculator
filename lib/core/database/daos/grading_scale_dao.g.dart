// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grading_scale_dao.dart';

// ignore_for_file: type=lint
mixin _$GradingScaleDaoMixin on DatabaseAccessor<AppDatabase> {
  $GradingScalesTable get gradingScales => attachedDatabase.gradingScales;
  $GradingScaleEntriesTable get gradingScaleEntries =>
      attachedDatabase.gradingScaleEntries;
  $StudentProfilesTable get studentProfiles => attachedDatabase.studentProfiles;
  GradingScaleDaoManager get managers => GradingScaleDaoManager(this);
}

class GradingScaleDaoManager {
  final _$GradingScaleDaoMixin _db;
  GradingScaleDaoManager(this._db);
  $$GradingScalesTableTableManager get gradingScales =>
      $$GradingScalesTableTableManager(_db.attachedDatabase, _db.gradingScales);
  $$GradingScaleEntriesTableTableManager get gradingScaleEntries =>
      $$GradingScaleEntriesTableTableManager(
        _db.attachedDatabase,
        _db.gradingScaleEntries,
      );
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(
        _db.attachedDatabase,
        _db.studentProfiles,
      );
}
