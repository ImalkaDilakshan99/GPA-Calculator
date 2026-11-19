import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';

/// Domain entity representing a GPA grading scale.
class GradingScaleEntity {
  final int id;
  final String name;
  final double maximumGpa;
  final ScaleType scaleType;
  final bool isDefault;
  final List<GradingScaleEntryEntity> entries;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GradingScaleEntity({
    required this.id,
    required this.name,
    required this.maximumGpa,
    required this.scaleType,
    this.isDefault = false,
    this.entries = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isPredefined => scaleType == ScaleType.predefined;
  bool get isCustom => scaleType == ScaleType.custom;

  GradingScaleEntity copyWith({
    int? id,
    String? name,
    double? maximumGpa,
    ScaleType? scaleType,
    bool? isDefault,
    List<GradingScaleEntryEntity>? entries,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GradingScaleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      maximumGpa: maximumGpa ?? this.maximumGpa,
      scaleType: scaleType ?? this.scaleType,
      isDefault: isDefault ?? this.isDefault,
      entries: entries ?? this.entries,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

