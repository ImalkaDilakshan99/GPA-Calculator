import 'package:gpa_calculator/domain/entities/grading_scale_entry_entity.dart';
import 'package:gpa_calculator/domain/enums/scale_type.dart';

/// Domain entity representing a GPA grading scale.
class GradingScaleEntity {
  final int id;
  final String name;
  final String? country;
  final String? university;
  final String? description;
  final double maximumGpa;
  final ScaleType scaleType;
  final String category; // 'recommended', 'international', 'country', 'university', 'custom'
  final String calculationType; // 'gpa', 'percentage', 'numerical', 'inverted', 'letter', 'custom'
  final double minimumValue;
  final double bestValue;
  final double worstValue;
  final double passingValue;
  final bool isHigherBetter;
  final int decimalPlaces;
  final bool isDefault;
  final List<GradingScaleEntryEntity> entries;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GradingScaleEntity({
    required this.id,
    required this.name,
    this.country,
    this.university,
    this.description,
    required this.maximumGpa,
    required this.scaleType,
    this.category = 'general',
    this.calculationType = 'gpa',
    this.minimumValue = 0.0,
    this.bestValue = 4.0,
    this.worstValue = 0.0,
    this.passingValue = 2.0,
    this.isHigherBetter = true,
    this.decimalPlaces = 2,
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
    String? country,
    String? university,
    String? description,
    double? maximumGpa,
    ScaleType? scaleType,
    String? category,
    String? calculationType,
    double? minimumValue,
    double? bestValue,
    double? worstValue,
    double? passingValue,
    bool? isHigherBetter,
    int? decimalPlaces,
    bool? isDefault,
    List<GradingScaleEntryEntity>? entries,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GradingScaleEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      university: university ?? this.university,
      description: description ?? this.description,
      maximumGpa: maximumGpa ?? this.maximumGpa,
      scaleType: scaleType ?? this.scaleType,
      category: category ?? this.category,
      calculationType: calculationType ?? this.calculationType,
      minimumValue: minimumValue ?? this.minimumValue,
      bestValue: bestValue ?? this.bestValue,
      worstValue: worstValue ?? this.worstValue,
      passingValue: passingValue ?? this.passingValue,
      isHigherBetter: isHigherBetter ?? this.isHigherBetter,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isDefault: isDefault ?? this.isDefault,
      entries: entries ?? this.entries,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GradingScaleEntity || runtimeType != other.runtimeType) return false;
    return id == other.id &&
        name == other.name &&
        country == other.country &&
        university == other.university &&
        maximumGpa == other.maximumGpa &&
        scaleType == other.scaleType &&
        category == other.category &&
        calculationType == other.calculationType &&
        isHigherBetter == other.isHigherBetter &&
        isDefault == other.isDefault;
  }

  @override
  int get hashCode => Object.hash(
        id,
        name,
        country,
        maximumGpa,
        scaleType,
        category,
        isHigherBetter,
        isDefault,
      );
}
