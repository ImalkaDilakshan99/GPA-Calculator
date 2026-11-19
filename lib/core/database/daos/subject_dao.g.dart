// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_dao.dart';

// ignore_for_file: type=lint
mixin _$SubjectDaoMixin on DatabaseAccessor<AppDatabase> {
  $SubjectsTable get subjects => attachedDatabase.subjects;
  $SemestersTable get semesters => attachedDatabase.semesters;
  $SemesterSubjectsTable get semesterSubjects =>
      attachedDatabase.semesterSubjects;
  SubjectDaoManager get managers => SubjectDaoManager(this);
}

class SubjectDaoManager {
  final _$SubjectDaoMixin _db;
  SubjectDaoManager(this._db);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db.attachedDatabase, _db.subjects);
  $$SemestersTableTableManager get semesters =>
      $$SemestersTableTableManager(_db.attachedDatabase, _db.semesters);
  $$SemesterSubjectsTableTableManager get semesterSubjects =>
      $$SemesterSubjectsTableTableManager(
        _db.attachedDatabase,
        _db.semesterSubjects,
      );
}
