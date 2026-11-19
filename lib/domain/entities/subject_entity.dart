/// Domain entity representing a reusable subject.
class SubjectEntity {
  final int id;
  final String subjectName;
  final String? subjectCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubjectEntity({
    required this.id,
    required this.subjectName,
    this.subjectCode,
    required this.createdAt,
    required this.updatedAt,
  });

  SubjectEntity copyWith({
    int? id,
    String? subjectName,
    String? subjectCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubjectEntity(
      id: id ?? this.id,
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

