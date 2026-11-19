// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_dao.dart';

// ignore_for_file: type=lint
mixin _$StudentDaoMixin on DatabaseAccessor<AppDatabase> {
  $GradingScalesTable get gradingScales => attachedDatabase.gradingScales;
  $StudentProfilesTable get studentProfiles => attachedDatabase.studentProfiles;
  StudentDaoManager get managers => StudentDaoManager(this);
}

class StudentDaoManager {
  final _$StudentDaoMixin _db;
  StudentDaoManager(this._db);
  $$GradingScalesTableTableManager get gradingScales =>
      $$GradingScalesTableTableManager(_db.attachedDatabase, _db.gradingScales);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(
        _db.attachedDatabase,
        _db.studentProfiles,
      );
}
