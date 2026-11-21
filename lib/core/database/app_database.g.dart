// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GradingScalesTable extends GradingScales
    with TableInfo<$GradingScalesTable, GradingScale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradingScalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _universityMeta = const VerificationMeta(
    'university',
  );
  @override
  late final GeneratedColumn<String> university = GeneratedColumn<String>(
    'university',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scaleTypeMeta = const VerificationMeta(
    'scaleType',
  );
  @override
  late final GeneratedColumn<String> scaleType = GeneratedColumn<String>(
    'scale_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('general'),
  );
  static const VerificationMeta _calculationTypeMeta = const VerificationMeta(
    'calculationType',
  );
  @override
  late final GeneratedColumn<String> calculationType = GeneratedColumn<String>(
    'calculation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('gpa'),
  );
  static const VerificationMeta _minimumValueMeta = const VerificationMeta(
    'minimumValue',
  );
  @override
  late final GeneratedColumn<double> minimumValue = GeneratedColumn<double>(
    'minimum_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _maximumGpaMeta = const VerificationMeta(
    'maximumGpa',
  );
  @override
  late final GeneratedColumn<double> maximumGpa = GeneratedColumn<double>(
    'maximum_gpa',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bestValueMeta = const VerificationMeta(
    'bestValue',
  );
  @override
  late final GeneratedColumn<double> bestValue = GeneratedColumn<double>(
    'best_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(4.0),
  );
  static const VerificationMeta _worstValueMeta = const VerificationMeta(
    'worstValue',
  );
  @override
  late final GeneratedColumn<double> worstValue = GeneratedColumn<double>(
    'worst_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _passingValueMeta = const VerificationMeta(
    'passingValue',
  );
  @override
  late final GeneratedColumn<double> passingValue = GeneratedColumn<double>(
    'passing_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.0),
  );
  static const VerificationMeta _isHigherBetterMeta = const VerificationMeta(
    'isHigherBetter',
  );
  @override
  late final GeneratedColumn<bool> isHigherBetter = GeneratedColumn<bool>(
    'is_higher_better',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_higher_better" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _decimalPlacesMeta = const VerificationMeta(
    'decimalPlaces',
  );
  @override
  late final GeneratedColumn<int> decimalPlaces = GeneratedColumn<int>(
    'decimal_places',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    country,
    university,
    description,
    scaleType,
    category,
    calculationType,
    minimumValue,
    maximumGpa,
    bestValue,
    worstValue,
    passingValue,
    isHigherBetter,
    decimalPlaces,
    isDefault,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grading_scales';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradingScale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('university')) {
      context.handle(
        _universityMeta,
        university.isAcceptableOrUnknown(data['university']!, _universityMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('scale_type')) {
      context.handle(
        _scaleTypeMeta,
        scaleType.isAcceptableOrUnknown(data['scale_type']!, _scaleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_scaleTypeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('calculation_type')) {
      context.handle(
        _calculationTypeMeta,
        calculationType.isAcceptableOrUnknown(
          data['calculation_type']!,
          _calculationTypeMeta,
        ),
      );
    }
    if (data.containsKey('minimum_value')) {
      context.handle(
        _minimumValueMeta,
        minimumValue.isAcceptableOrUnknown(
          data['minimum_value']!,
          _minimumValueMeta,
        ),
      );
    }
    if (data.containsKey('maximum_gpa')) {
      context.handle(
        _maximumGpaMeta,
        maximumGpa.isAcceptableOrUnknown(data['maximum_gpa']!, _maximumGpaMeta),
      );
    } else if (isInserting) {
      context.missing(_maximumGpaMeta);
    }
    if (data.containsKey('best_value')) {
      context.handle(
        _bestValueMeta,
        bestValue.isAcceptableOrUnknown(data['best_value']!, _bestValueMeta),
      );
    }
    if (data.containsKey('worst_value')) {
      context.handle(
        _worstValueMeta,
        worstValue.isAcceptableOrUnknown(data['worst_value']!, _worstValueMeta),
      );
    }
    if (data.containsKey('passing_value')) {
      context.handle(
        _passingValueMeta,
        passingValue.isAcceptableOrUnknown(
          data['passing_value']!,
          _passingValueMeta,
        ),
      );
    }
    if (data.containsKey('is_higher_better')) {
      context.handle(
        _isHigherBetterMeta,
        isHigherBetter.isAcceptableOrUnknown(
          data['is_higher_better']!,
          _isHigherBetterMeta,
        ),
      );
    }
    if (data.containsKey('decimal_places')) {
      context.handle(
        _decimalPlacesMeta,
        decimalPlaces.isAcceptableOrUnknown(
          data['decimal_places']!,
          _decimalPlacesMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GradingScale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradingScale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      university: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      scaleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scale_type'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      calculationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calculation_type'],
      )!,
      minimumValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum_value'],
      )!,
      maximumGpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}maximum_gpa'],
      )!,
      bestValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}best_value'],
      )!,
      worstValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}worst_value'],
      )!,
      passingValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}passing_value'],
      )!,
      isHigherBetter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_higher_better'],
      )!,
      decimalPlaces: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}decimal_places'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GradingScalesTable createAlias(String alias) {
    return $GradingScalesTable(attachedDatabase, alias);
  }
}

class GradingScale extends DataClass implements Insertable<GradingScale> {
  final int id;
  final String name;
  final String? country;
  final String? university;
  final String? description;
  final String scaleType;
  final String category;
  final String calculationType;
  final double minimumValue;
  final double maximumGpa;
  final double bestValue;
  final double worstValue;
  final double passingValue;
  final bool isHigherBetter;
  final int decimalPlaces;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GradingScale({
    required this.id,
    required this.name,
    this.country,
    this.university,
    this.description,
    required this.scaleType,
    required this.category,
    required this.calculationType,
    required this.minimumValue,
    required this.maximumGpa,
    required this.bestValue,
    required this.worstValue,
    required this.passingValue,
    required this.isHigherBetter,
    required this.decimalPlaces,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || university != null) {
      map['university'] = Variable<String>(university);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['scale_type'] = Variable<String>(scaleType);
    map['category'] = Variable<String>(category);
    map['calculation_type'] = Variable<String>(calculationType);
    map['minimum_value'] = Variable<double>(minimumValue);
    map['maximum_gpa'] = Variable<double>(maximumGpa);
    map['best_value'] = Variable<double>(bestValue);
    map['worst_value'] = Variable<double>(worstValue);
    map['passing_value'] = Variable<double>(passingValue);
    map['is_higher_better'] = Variable<bool>(isHigherBetter);
    map['decimal_places'] = Variable<int>(decimalPlaces);
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GradingScalesCompanion toCompanion(bool nullToAbsent) {
    return GradingScalesCompanion(
      id: Value(id),
      name: Value(name),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      university: university == null && nullToAbsent
          ? const Value.absent()
          : Value(university),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      scaleType: Value(scaleType),
      category: Value(category),
      calculationType: Value(calculationType),
      minimumValue: Value(minimumValue),
      maximumGpa: Value(maximumGpa),
      bestValue: Value(bestValue),
      worstValue: Value(worstValue),
      passingValue: Value(passingValue),
      isHigherBetter: Value(isHigherBetter),
      decimalPlaces: Value(decimalPlaces),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GradingScale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradingScale(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      country: serializer.fromJson<String?>(json['country']),
      university: serializer.fromJson<String?>(json['university']),
      description: serializer.fromJson<String?>(json['description']),
      scaleType: serializer.fromJson<String>(json['scaleType']),
      category: serializer.fromJson<String>(json['category']),
      calculationType: serializer.fromJson<String>(json['calculationType']),
      minimumValue: serializer.fromJson<double>(json['minimumValue']),
      maximumGpa: serializer.fromJson<double>(json['maximumGpa']),
      bestValue: serializer.fromJson<double>(json['bestValue']),
      worstValue: serializer.fromJson<double>(json['worstValue']),
      passingValue: serializer.fromJson<double>(json['passingValue']),
      isHigherBetter: serializer.fromJson<bool>(json['isHigherBetter']),
      decimalPlaces: serializer.fromJson<int>(json['decimalPlaces']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'country': serializer.toJson<String?>(country),
      'university': serializer.toJson<String?>(university),
      'description': serializer.toJson<String?>(description),
      'scaleType': serializer.toJson<String>(scaleType),
      'category': serializer.toJson<String>(category),
      'calculationType': serializer.toJson<String>(calculationType),
      'minimumValue': serializer.toJson<double>(minimumValue),
      'maximumGpa': serializer.toJson<double>(maximumGpa),
      'bestValue': serializer.toJson<double>(bestValue),
      'worstValue': serializer.toJson<double>(worstValue),
      'passingValue': serializer.toJson<double>(passingValue),
      'isHigherBetter': serializer.toJson<bool>(isHigherBetter),
      'decimalPlaces': serializer.toJson<int>(decimalPlaces),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GradingScale copyWith({
    int? id,
    String? name,
    Value<String?> country = const Value.absent(),
    Value<String?> university = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? scaleType,
    String? category,
    String? calculationType,
    double? minimumValue,
    double? maximumGpa,
    double? bestValue,
    double? worstValue,
    double? passingValue,
    bool? isHigherBetter,
    int? decimalPlaces,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GradingScale(
    id: id ?? this.id,
    name: name ?? this.name,
    country: country.present ? country.value : this.country,
    university: university.present ? university.value : this.university,
    description: description.present ? description.value : this.description,
    scaleType: scaleType ?? this.scaleType,
    category: category ?? this.category,
    calculationType: calculationType ?? this.calculationType,
    minimumValue: minimumValue ?? this.minimumValue,
    maximumGpa: maximumGpa ?? this.maximumGpa,
    bestValue: bestValue ?? this.bestValue,
    worstValue: worstValue ?? this.worstValue,
    passingValue: passingValue ?? this.passingValue,
    isHigherBetter: isHigherBetter ?? this.isHigherBetter,
    decimalPlaces: decimalPlaces ?? this.decimalPlaces,
    isDefault: isDefault ?? this.isDefault,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GradingScale copyWithCompanion(GradingScalesCompanion data) {
    return GradingScale(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      country: data.country.present ? data.country.value : this.country,
      university: data.university.present
          ? data.university.value
          : this.university,
      description: data.description.present
          ? data.description.value
          : this.description,
      scaleType: data.scaleType.present ? data.scaleType.value : this.scaleType,
      category: data.category.present ? data.category.value : this.category,
      calculationType: data.calculationType.present
          ? data.calculationType.value
          : this.calculationType,
      minimumValue: data.minimumValue.present
          ? data.minimumValue.value
          : this.minimumValue,
      maximumGpa: data.maximumGpa.present
          ? data.maximumGpa.value
          : this.maximumGpa,
      bestValue: data.bestValue.present ? data.bestValue.value : this.bestValue,
      worstValue: data.worstValue.present
          ? data.worstValue.value
          : this.worstValue,
      passingValue: data.passingValue.present
          ? data.passingValue.value
          : this.passingValue,
      isHigherBetter: data.isHigherBetter.present
          ? data.isHigherBetter.value
          : this.isHigherBetter,
      decimalPlaces: data.decimalPlaces.present
          ? data.decimalPlaces.value
          : this.decimalPlaces,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradingScale(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('university: $university, ')
          ..write('description: $description, ')
          ..write('scaleType: $scaleType, ')
          ..write('category: $category, ')
          ..write('calculationType: $calculationType, ')
          ..write('minimumValue: $minimumValue, ')
          ..write('maximumGpa: $maximumGpa, ')
          ..write('bestValue: $bestValue, ')
          ..write('worstValue: $worstValue, ')
          ..write('passingValue: $passingValue, ')
          ..write('isHigherBetter: $isHigherBetter, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    country,
    university,
    description,
    scaleType,
    category,
    calculationType,
    minimumValue,
    maximumGpa,
    bestValue,
    worstValue,
    passingValue,
    isHigherBetter,
    decimalPlaces,
    isDefault,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradingScale &&
          other.id == this.id &&
          other.name == this.name &&
          other.country == this.country &&
          other.university == this.university &&
          other.description == this.description &&
          other.scaleType == this.scaleType &&
          other.category == this.category &&
          other.calculationType == this.calculationType &&
          other.minimumValue == this.minimumValue &&
          other.maximumGpa == this.maximumGpa &&
          other.bestValue == this.bestValue &&
          other.worstValue == this.worstValue &&
          other.passingValue == this.passingValue &&
          other.isHigherBetter == this.isHigherBetter &&
          other.decimalPlaces == this.decimalPlaces &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GradingScalesCompanion extends UpdateCompanion<GradingScale> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> country;
  final Value<String?> university;
  final Value<String?> description;
  final Value<String> scaleType;
  final Value<String> category;
  final Value<String> calculationType;
  final Value<double> minimumValue;
  final Value<double> maximumGpa;
  final Value<double> bestValue;
  final Value<double> worstValue;
  final Value<double> passingValue;
  final Value<bool> isHigherBetter;
  final Value<int> decimalPlaces;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GradingScalesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.country = const Value.absent(),
    this.university = const Value.absent(),
    this.description = const Value.absent(),
    this.scaleType = const Value.absent(),
    this.category = const Value.absent(),
    this.calculationType = const Value.absent(),
    this.minimumValue = const Value.absent(),
    this.maximumGpa = const Value.absent(),
    this.bestValue = const Value.absent(),
    this.worstValue = const Value.absent(),
    this.passingValue = const Value.absent(),
    this.isHigherBetter = const Value.absent(),
    this.decimalPlaces = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GradingScalesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.country = const Value.absent(),
    this.university = const Value.absent(),
    this.description = const Value.absent(),
    required String scaleType,
    this.category = const Value.absent(),
    this.calculationType = const Value.absent(),
    this.minimumValue = const Value.absent(),
    required double maximumGpa,
    this.bestValue = const Value.absent(),
    this.worstValue = const Value.absent(),
    this.passingValue = const Value.absent(),
    this.isHigherBetter = const Value.absent(),
    this.decimalPlaces = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       scaleType = Value(scaleType),
       maximumGpa = Value(maximumGpa);
  static Insertable<GradingScale> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? country,
    Expression<String>? university,
    Expression<String>? description,
    Expression<String>? scaleType,
    Expression<String>? category,
    Expression<String>? calculationType,
    Expression<double>? minimumValue,
    Expression<double>? maximumGpa,
    Expression<double>? bestValue,
    Expression<double>? worstValue,
    Expression<double>? passingValue,
    Expression<bool>? isHigherBetter,
    Expression<int>? decimalPlaces,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (country != null) 'country': country,
      if (university != null) 'university': university,
      if (description != null) 'description': description,
      if (scaleType != null) 'scale_type': scaleType,
      if (category != null) 'category': category,
      if (calculationType != null) 'calculation_type': calculationType,
      if (minimumValue != null) 'minimum_value': minimumValue,
      if (maximumGpa != null) 'maximum_gpa': maximumGpa,
      if (bestValue != null) 'best_value': bestValue,
      if (worstValue != null) 'worst_value': worstValue,
      if (passingValue != null) 'passing_value': passingValue,
      if (isHigherBetter != null) 'is_higher_better': isHigherBetter,
      if (decimalPlaces != null) 'decimal_places': decimalPlaces,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GradingScalesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? country,
    Value<String?>? university,
    Value<String?>? description,
    Value<String>? scaleType,
    Value<String>? category,
    Value<String>? calculationType,
    Value<double>? minimumValue,
    Value<double>? maximumGpa,
    Value<double>? bestValue,
    Value<double>? worstValue,
    Value<double>? passingValue,
    Value<bool>? isHigherBetter,
    Value<int>? decimalPlaces,
    Value<bool>? isDefault,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return GradingScalesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      university: university ?? this.university,
      description: description ?? this.description,
      scaleType: scaleType ?? this.scaleType,
      category: category ?? this.category,
      calculationType: calculationType ?? this.calculationType,
      minimumValue: minimumValue ?? this.minimumValue,
      maximumGpa: maximumGpa ?? this.maximumGpa,
      bestValue: bestValue ?? this.bestValue,
      worstValue: worstValue ?? this.worstValue,
      passingValue: passingValue ?? this.passingValue,
      isHigherBetter: isHigherBetter ?? this.isHigherBetter,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (university.present) {
      map['university'] = Variable<String>(university.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (scaleType.present) {
      map['scale_type'] = Variable<String>(scaleType.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (calculationType.present) {
      map['calculation_type'] = Variable<String>(calculationType.value);
    }
    if (minimumValue.present) {
      map['minimum_value'] = Variable<double>(minimumValue.value);
    }
    if (maximumGpa.present) {
      map['maximum_gpa'] = Variable<double>(maximumGpa.value);
    }
    if (bestValue.present) {
      map['best_value'] = Variable<double>(bestValue.value);
    }
    if (worstValue.present) {
      map['worst_value'] = Variable<double>(worstValue.value);
    }
    if (passingValue.present) {
      map['passing_value'] = Variable<double>(passingValue.value);
    }
    if (isHigherBetter.present) {
      map['is_higher_better'] = Variable<bool>(isHigherBetter.value);
    }
    if (decimalPlaces.present) {
      map['decimal_places'] = Variable<int>(decimalPlaces.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradingScalesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('country: $country, ')
          ..write('university: $university, ')
          ..write('description: $description, ')
          ..write('scaleType: $scaleType, ')
          ..write('category: $category, ')
          ..write('calculationType: $calculationType, ')
          ..write('minimumValue: $minimumValue, ')
          ..write('maximumGpa: $maximumGpa, ')
          ..write('bestValue: $bestValue, ')
          ..write('worstValue: $worstValue, ')
          ..write('passingValue: $passingValue, ')
          ..write('isHigherBetter: $isHigherBetter, ')
          ..write('decimalPlaces: $decimalPlaces, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $StudentProfilesTable extends StudentProfiles
    with TableInfo<$StudentProfilesTable, StudentProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'NOT NULL CHECK (id = 1)',
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _degreeNameMeta = const VerificationMeta(
    'degreeName',
  );
  @override
  late final GeneratedColumn<String> degreeName = GeneratedColumn<String>(
    'degree_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _universityNameMeta = const VerificationMeta(
    'universityName',
  );
  @override
  late final GeneratedColumn<String> universityName = GeneratedColumn<String>(
    'university_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profilePhotoPathMeta = const VerificationMeta(
    'profilePhotoPath',
  );
  @override
  late final GeneratedColumn<String> profilePhotoPath = GeneratedColumn<String>(
    'profile_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradingScaleIdMeta = const VerificationMeta(
    'gradingScaleId',
  );
  @override
  late final GeneratedColumn<int> gradingScaleId = GeneratedColumn<int>(
    'grading_scale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_scales (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    degreeName,
    universityName,
    profilePhotoPath,
    gradingScaleId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudentProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('degree_name')) {
      context.handle(
        _degreeNameMeta,
        degreeName.isAcceptableOrUnknown(data['degree_name']!, _degreeNameMeta),
      );
    } else if (isInserting) {
      context.missing(_degreeNameMeta);
    }
    if (data.containsKey('university_name')) {
      context.handle(
        _universityNameMeta,
        universityName.isAcceptableOrUnknown(
          data['university_name']!,
          _universityNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_universityNameMeta);
    }
    if (data.containsKey('profile_photo_path')) {
      context.handle(
        _profilePhotoPathMeta,
        profilePhotoPath.isAcceptableOrUnknown(
          data['profile_photo_path']!,
          _profilePhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('grading_scale_id')) {
      context.handle(
        _gradingScaleIdMeta,
        gradingScaleId.isAcceptableOrUnknown(
          data['grading_scale_id']!,
          _gradingScaleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingScaleIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      degreeName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}degree_name'],
      )!,
      universityName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}university_name'],
      )!,
      profilePhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_photo_path'],
      ),
      gradingScaleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_scale_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfile extends DataClass implements Insertable<StudentProfile> {
  final int id;
  final String name;
  final String degreeName;
  final String universityName;
  final String? profilePhotoPath;
  final int gradingScaleId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudentProfile({
    required this.id,
    required this.name,
    required this.degreeName,
    required this.universityName,
    this.profilePhotoPath,
    required this.gradingScaleId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['degree_name'] = Variable<String>(degreeName);
    map['university_name'] = Variable<String>(universityName);
    if (!nullToAbsent || profilePhotoPath != null) {
      map['profile_photo_path'] = Variable<String>(profilePhotoPath);
    }
    map['grading_scale_id'] = Variable<int>(gradingScaleId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      name: Value(name),
      degreeName: Value(degreeName),
      universityName: Value(universityName),
      profilePhotoPath: profilePhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(profilePhotoPath),
      gradingScaleId: Value(gradingScaleId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      degreeName: serializer.fromJson<String>(json['degreeName']),
      universityName: serializer.fromJson<String>(json['universityName']),
      profilePhotoPath: serializer.fromJson<String?>(json['profilePhotoPath']),
      gradingScaleId: serializer.fromJson<int>(json['gradingScaleId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'degreeName': serializer.toJson<String>(degreeName),
      'universityName': serializer.toJson<String>(universityName),
      'profilePhotoPath': serializer.toJson<String?>(profilePhotoPath),
      'gradingScaleId': serializer.toJson<int>(gradingScaleId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentProfile copyWith({
    int? id,
    String? name,
    String? degreeName,
    String? universityName,
    Value<String?> profilePhotoPath = const Value.absent(),
    int? gradingScaleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudentProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    degreeName: degreeName ?? this.degreeName,
    universityName: universityName ?? this.universityName,
    profilePhotoPath: profilePhotoPath.present
        ? profilePhotoPath.value
        : this.profilePhotoPath,
    gradingScaleId: gradingScaleId ?? this.gradingScaleId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudentProfile copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      degreeName: data.degreeName.present
          ? data.degreeName.value
          : this.degreeName,
      universityName: data.universityName.present
          ? data.universityName.value
          : this.universityName,
      profilePhotoPath: data.profilePhotoPath.present
          ? data.profilePhotoPath.value
          : this.profilePhotoPath,
      gradingScaleId: data.gradingScaleId.present
          ? data.gradingScaleId.value
          : this.gradingScaleId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('degreeName: $degreeName, ')
          ..write('universityName: $universityName, ')
          ..write('profilePhotoPath: $profilePhotoPath, ')
          ..write('gradingScaleId: $gradingScaleId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    degreeName,
    universityName,
    profilePhotoPath,
    gradingScaleId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.degreeName == this.degreeName &&
          other.universityName == this.universityName &&
          other.profilePhotoPath == this.profilePhotoPath &&
          other.gradingScaleId == this.gradingScaleId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> degreeName;
  final Value<String> universityName;
  final Value<String?> profilePhotoPath;
  final Value<int> gradingScaleId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.degreeName = const Value.absent(),
    this.universityName = const Value.absent(),
    this.profilePhotoPath = const Value.absent(),
    this.gradingScaleId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String degreeName,
    required String universityName,
    this.profilePhotoPath = const Value.absent(),
    required int gradingScaleId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       degreeName = Value(degreeName),
       universityName = Value(universityName),
       gradingScaleId = Value(gradingScaleId);
  static Insertable<StudentProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? degreeName,
    Expression<String>? universityName,
    Expression<String>? profilePhotoPath,
    Expression<int>? gradingScaleId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (degreeName != null) 'degree_name': degreeName,
      if (universityName != null) 'university_name': universityName,
      if (profilePhotoPath != null) 'profile_photo_path': profilePhotoPath,
      if (gradingScaleId != null) 'grading_scale_id': gradingScaleId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudentProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? degreeName,
    Value<String>? universityName,
    Value<String?>? profilePhotoPath,
    Value<int>? gradingScaleId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return StudentProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      degreeName: degreeName ?? this.degreeName,
      universityName: universityName ?? this.universityName,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      gradingScaleId: gradingScaleId ?? this.gradingScaleId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (degreeName.present) {
      map['degree_name'] = Variable<String>(degreeName.value);
    }
    if (universityName.present) {
      map['university_name'] = Variable<String>(universityName.value);
    }
    if (profilePhotoPath.present) {
      map['profile_photo_path'] = Variable<String>(profilePhotoPath.value);
    }
    if (gradingScaleId.present) {
      map['grading_scale_id'] = Variable<int>(gradingScaleId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('degreeName: $degreeName, ')
          ..write('universityName: $universityName, ')
          ..write('profilePhotoPath: $profilePhotoPath, ')
          ..write('gradingScaleId: $gradingScaleId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GradingScaleEntriesTable extends GradingScaleEntries
    with TableInfo<$GradingScaleEntriesTable, GradingScaleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradingScaleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _gradingScaleIdMeta = const VerificationMeta(
    'gradingScaleId',
  );
  @override
  late final GeneratedColumn<int> gradingScaleId = GeneratedColumn<int>(
    'grading_scale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES grading_scales (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradePointMeta = const VerificationMeta(
    'gradePoint',
  );
  @override
  late final GeneratedColumn<double> gradePoint = GeneratedColumn<double>(
    'grade_point',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (grade_point >= 0.0)',
  );
  static const VerificationMeta _minimumPercentageMeta = const VerificationMeta(
    'minimumPercentage',
  );
  @override
  late final GeneratedColumn<double> minimumPercentage =
      GeneratedColumn<double>(
        'minimum_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _maximumPercentageMeta = const VerificationMeta(
    'maximumPercentage',
  );
  @override
  late final GeneratedColumn<double> maximumPercentage =
      GeneratedColumn<double>(
        'maximum_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isPassingMeta = const VerificationMeta(
    'isPassing',
  );
  @override
  late final GeneratedColumn<bool> isPassing = GeneratedColumn<bool>(
    'is_passing',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_passing" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gradingScaleId,
    grade,
    gradePoint,
    minimumPercentage,
    maximumPercentage,
    isPassing,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grading_scale_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradingScaleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('grading_scale_id')) {
      context.handle(
        _gradingScaleIdMeta,
        gradingScaleId.isAcceptableOrUnknown(
          data['grading_scale_id']!,
          _gradingScaleIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingScaleIdMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('grade_point')) {
      context.handle(
        _gradePointMeta,
        gradePoint.isAcceptableOrUnknown(data['grade_point']!, _gradePointMeta),
      );
    } else if (isInserting) {
      context.missing(_gradePointMeta);
    }
    if (data.containsKey('minimum_percentage')) {
      context.handle(
        _minimumPercentageMeta,
        minimumPercentage.isAcceptableOrUnknown(
          data['minimum_percentage']!,
          _minimumPercentageMeta,
        ),
      );
    }
    if (data.containsKey('maximum_percentage')) {
      context.handle(
        _maximumPercentageMeta,
        maximumPercentage.isAcceptableOrUnknown(
          data['maximum_percentage']!,
          _maximumPercentageMeta,
        ),
      );
    }
    if (data.containsKey('is_passing')) {
      context.handle(
        _isPassingMeta,
        isPassing.isAcceptableOrUnknown(data['is_passing']!, _isPassingMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {gradingScaleId, grade},
  ];
  @override
  GradingScaleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradingScaleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gradingScaleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grading_scale_id'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      gradePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grade_point'],
      )!,
      minimumPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum_percentage'],
      ),
      maximumPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}maximum_percentage'],
      ),
      isPassing: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_passing'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $GradingScaleEntriesTable createAlias(String alias) {
    return $GradingScaleEntriesTable(attachedDatabase, alias);
  }
}

class GradingScaleEntry extends DataClass
    implements Insertable<GradingScaleEntry> {
  final int id;
  final int gradingScaleId;
  final String grade;
  final double gradePoint;
  final double? minimumPercentage;
  final double? maximumPercentage;
  final bool isPassing;
  final int displayOrder;
  const GradingScaleEntry({
    required this.id,
    required this.gradingScaleId,
    required this.grade,
    required this.gradePoint,
    this.minimumPercentage,
    this.maximumPercentage,
    required this.isPassing,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['grading_scale_id'] = Variable<int>(gradingScaleId);
    map['grade'] = Variable<String>(grade);
    map['grade_point'] = Variable<double>(gradePoint);
    if (!nullToAbsent || minimumPercentage != null) {
      map['minimum_percentage'] = Variable<double>(minimumPercentage);
    }
    if (!nullToAbsent || maximumPercentage != null) {
      map['maximum_percentage'] = Variable<double>(maximumPercentage);
    }
    map['is_passing'] = Variable<bool>(isPassing);
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  GradingScaleEntriesCompanion toCompanion(bool nullToAbsent) {
    return GradingScaleEntriesCompanion(
      id: Value(id),
      gradingScaleId: Value(gradingScaleId),
      grade: Value(grade),
      gradePoint: Value(gradePoint),
      minimumPercentage: minimumPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumPercentage),
      maximumPercentage: maximumPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumPercentage),
      isPassing: Value(isPassing),
      displayOrder: Value(displayOrder),
    );
  }

  factory GradingScaleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradingScaleEntry(
      id: serializer.fromJson<int>(json['id']),
      gradingScaleId: serializer.fromJson<int>(json['gradingScaleId']),
      grade: serializer.fromJson<String>(json['grade']),
      gradePoint: serializer.fromJson<double>(json['gradePoint']),
      minimumPercentage: serializer.fromJson<double?>(
        json['minimumPercentage'],
      ),
      maximumPercentage: serializer.fromJson<double?>(
        json['maximumPercentage'],
      ),
      isPassing: serializer.fromJson<bool>(json['isPassing']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gradingScaleId': serializer.toJson<int>(gradingScaleId),
      'grade': serializer.toJson<String>(grade),
      'gradePoint': serializer.toJson<double>(gradePoint),
      'minimumPercentage': serializer.toJson<double?>(minimumPercentage),
      'maximumPercentage': serializer.toJson<double?>(maximumPercentage),
      'isPassing': serializer.toJson<bool>(isPassing),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  GradingScaleEntry copyWith({
    int? id,
    int? gradingScaleId,
    String? grade,
    double? gradePoint,
    Value<double?> minimumPercentage = const Value.absent(),
    Value<double?> maximumPercentage = const Value.absent(),
    bool? isPassing,
    int? displayOrder,
  }) => GradingScaleEntry(
    id: id ?? this.id,
    gradingScaleId: gradingScaleId ?? this.gradingScaleId,
    grade: grade ?? this.grade,
    gradePoint: gradePoint ?? this.gradePoint,
    minimumPercentage: minimumPercentage.present
        ? minimumPercentage.value
        : this.minimumPercentage,
    maximumPercentage: maximumPercentage.present
        ? maximumPercentage.value
        : this.maximumPercentage,
    isPassing: isPassing ?? this.isPassing,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  GradingScaleEntry copyWithCompanion(GradingScaleEntriesCompanion data) {
    return GradingScaleEntry(
      id: data.id.present ? data.id.value : this.id,
      gradingScaleId: data.gradingScaleId.present
          ? data.gradingScaleId.value
          : this.gradingScaleId,
      grade: data.grade.present ? data.grade.value : this.grade,
      gradePoint: data.gradePoint.present
          ? data.gradePoint.value
          : this.gradePoint,
      minimumPercentage: data.minimumPercentage.present
          ? data.minimumPercentage.value
          : this.minimumPercentage,
      maximumPercentage: data.maximumPercentage.present
          ? data.maximumPercentage.value
          : this.maximumPercentage,
      isPassing: data.isPassing.present ? data.isPassing.value : this.isPassing,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradingScaleEntry(')
          ..write('id: $id, ')
          ..write('gradingScaleId: $gradingScaleId, ')
          ..write('grade: $grade, ')
          ..write('gradePoint: $gradePoint, ')
          ..write('minimumPercentage: $minimumPercentage, ')
          ..write('maximumPercentage: $maximumPercentage, ')
          ..write('isPassing: $isPassing, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gradingScaleId,
    grade,
    gradePoint,
    minimumPercentage,
    maximumPercentage,
    isPassing,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradingScaleEntry &&
          other.id == this.id &&
          other.gradingScaleId == this.gradingScaleId &&
          other.grade == this.grade &&
          other.gradePoint == this.gradePoint &&
          other.minimumPercentage == this.minimumPercentage &&
          other.maximumPercentage == this.maximumPercentage &&
          other.isPassing == this.isPassing &&
          other.displayOrder == this.displayOrder);
}

class GradingScaleEntriesCompanion extends UpdateCompanion<GradingScaleEntry> {
  final Value<int> id;
  final Value<int> gradingScaleId;
  final Value<String> grade;
  final Value<double> gradePoint;
  final Value<double?> minimumPercentage;
  final Value<double?> maximumPercentage;
  final Value<bool> isPassing;
  final Value<int> displayOrder;
  const GradingScaleEntriesCompanion({
    this.id = const Value.absent(),
    this.gradingScaleId = const Value.absent(),
    this.grade = const Value.absent(),
    this.gradePoint = const Value.absent(),
    this.minimumPercentage = const Value.absent(),
    this.maximumPercentage = const Value.absent(),
    this.isPassing = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  GradingScaleEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int gradingScaleId,
    required String grade,
    required double gradePoint,
    this.minimumPercentage = const Value.absent(),
    this.maximumPercentage = const Value.absent(),
    this.isPassing = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : gradingScaleId = Value(gradingScaleId),
       grade = Value(grade),
       gradePoint = Value(gradePoint);
  static Insertable<GradingScaleEntry> custom({
    Expression<int>? id,
    Expression<int>? gradingScaleId,
    Expression<String>? grade,
    Expression<double>? gradePoint,
    Expression<double>? minimumPercentage,
    Expression<double>? maximumPercentage,
    Expression<bool>? isPassing,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gradingScaleId != null) 'grading_scale_id': gradingScaleId,
      if (grade != null) 'grade': grade,
      if (gradePoint != null) 'grade_point': gradePoint,
      if (minimumPercentage != null) 'minimum_percentage': minimumPercentage,
      if (maximumPercentage != null) 'maximum_percentage': maximumPercentage,
      if (isPassing != null) 'is_passing': isPassing,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  GradingScaleEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? gradingScaleId,
    Value<String>? grade,
    Value<double>? gradePoint,
    Value<double?>? minimumPercentage,
    Value<double?>? maximumPercentage,
    Value<bool>? isPassing,
    Value<int>? displayOrder,
  }) {
    return GradingScaleEntriesCompanion(
      id: id ?? this.id,
      gradingScaleId: gradingScaleId ?? this.gradingScaleId,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
      minimumPercentage: minimumPercentage ?? this.minimumPercentage,
      maximumPercentage: maximumPercentage ?? this.maximumPercentage,
      isPassing: isPassing ?? this.isPassing,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gradingScaleId.present) {
      map['grading_scale_id'] = Variable<int>(gradingScaleId.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (gradePoint.present) {
      map['grade_point'] = Variable<double>(gradePoint.value);
    }
    if (minimumPercentage.present) {
      map['minimum_percentage'] = Variable<double>(minimumPercentage.value);
    }
    if (maximumPercentage.present) {
      map['maximum_percentage'] = Variable<double>(maximumPercentage.value);
    }
    if (isPassing.present) {
      map['is_passing'] = Variable<bool>(isPassing.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradingScaleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('gradingScaleId: $gradingScaleId, ')
          ..write('grade: $grade, ')
          ..write('gradePoint: $gradePoint, ')
          ..write('minimumPercentage: $minimumPercentage, ')
          ..write('maximumPercentage: $maximumPercentage, ')
          ..write('isPassing: $isPassing, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $SemestersTable extends Semesters
    with TableInfo<$SemestersTable, Semester> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemestersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _academicYearMeta = const VerificationMeta(
    'academicYear',
  );
  @override
  late final GeneratedColumn<int> academicYear = GeneratedColumn<int>(
    'academic_year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _semesterNumberMeta = const VerificationMeta(
    'semesterNumber',
  );
  @override
  late final GeneratedColumn<int> semesterNumber = GeneratedColumn<int>(
    'semester_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    academicYear,
    semesterNumber,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semesters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Semester> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('academic_year')) {
      context.handle(
        _academicYearMeta,
        academicYear.isAcceptableOrUnknown(
          data['academic_year']!,
          _academicYearMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_academicYearMeta);
    }
    if (data.containsKey('semester_number')) {
      context.handle(
        _semesterNumberMeta,
        semesterNumber.isAcceptableOrUnknown(
          data['semester_number']!,
          _semesterNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterNumberMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {academicYear, semesterNumber},
  ];
  @override
  Semester map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Semester(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      academicYear: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_year'],
      )!,
      semesterNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_number'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SemestersTable createAlias(String alias) {
    return $SemestersTable(attachedDatabase, alias);
  }
}

class Semester extends DataClass implements Insertable<Semester> {
  final int id;
  final String name;
  final int academicYear;
  final int semesterNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Semester({
    required this.id,
    required this.name,
    required this.academicYear,
    required this.semesterNumber,
    this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['academic_year'] = Variable<int>(academicYear);
    map['semester_number'] = Variable<int>(semesterNumber);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SemestersCompanion toCompanion(bool nullToAbsent) {
    return SemestersCompanion(
      id: Value(id),
      name: Value(name),
      academicYear: Value(academicYear),
      semesterNumber: Value(semesterNumber),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Semester.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Semester(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      academicYear: serializer.fromJson<int>(json['academicYear']),
      semesterNumber: serializer.fromJson<int>(json['semesterNumber']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'academicYear': serializer.toJson<int>(academicYear),
      'semesterNumber': serializer.toJson<int>(semesterNumber),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Semester copyWith({
    int? id,
    String? name,
    int? academicYear,
    int? semesterNumber,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Semester(
    id: id ?? this.id,
    name: name ?? this.name,
    academicYear: academicYear ?? this.academicYear,
    semesterNumber: semesterNumber ?? this.semesterNumber,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Semester copyWithCompanion(SemestersCompanion data) {
    return Semester(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      semesterNumber: data.semesterNumber.present
          ? data.semesterNumber.value
          : this.semesterNumber,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Semester(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('academicYear: $academicYear, ')
          ..write('semesterNumber: $semesterNumber, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    academicYear,
    semesterNumber,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Semester &&
          other.id == this.id &&
          other.name == this.name &&
          other.academicYear == this.academicYear &&
          other.semesterNumber == this.semesterNumber &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SemestersCompanion extends UpdateCompanion<Semester> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> academicYear;
  final Value<int> semesterNumber;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SemestersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.semesterNumber = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SemestersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int academicYear,
    required int semesterNumber,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       academicYear = Value(academicYear),
       semesterNumber = Value(semesterNumber);
  static Insertable<Semester> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? academicYear,
    Expression<int>? semesterNumber,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (academicYear != null) 'academic_year': academicYear,
      if (semesterNumber != null) 'semester_number': semesterNumber,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SemestersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? academicYear,
    Value<int>? semesterNumber,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SemestersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      academicYear: academicYear ?? this.academicYear,
      semesterNumber: semesterNumber ?? this.semesterNumber,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<int>(academicYear.value);
    }
    if (semesterNumber.present) {
      map['semester_number'] = Variable<int>(semesterNumber.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemestersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('academicYear: $academicYear, ')
          ..write('semesterNumber: $semesterNumber, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _subjectNameMeta = const VerificationMeta(
    'subjectName',
  );
  @override
  late final GeneratedColumn<String> subjectName = GeneratedColumn<String>(
    'subject_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectCodeMeta = const VerificationMeta(
    'subjectCode',
  );
  @override
  late final GeneratedColumn<String> subjectCode = GeneratedColumn<String>(
    'subject_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subjectName,
    subjectCode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subject_name')) {
      context.handle(
        _subjectNameMeta,
        subjectName.isAcceptableOrUnknown(
          data['subject_name']!,
          _subjectNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subjectNameMeta);
    }
    if (data.containsKey('subject_code')) {
      context.handle(
        _subjectCodeMeta,
        subjectCode.isAcceptableOrUnknown(
          data['subject_code']!,
          _subjectCodeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subjectName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_name'],
      )!,
      subjectCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject_code'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final String subjectName;
  final String? subjectCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Subject({
    required this.id,
    required this.subjectName,
    this.subjectCode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subject_name'] = Variable<String>(subjectName);
    if (!nullToAbsent || subjectCode != null) {
      map['subject_code'] = Variable<String>(subjectCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      subjectName: Value(subjectName),
      subjectCode: subjectCode == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Subject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      subjectName: serializer.fromJson<String>(json['subjectName']),
      subjectCode: serializer.fromJson<String?>(json['subjectCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subjectName': serializer.toJson<String>(subjectName),
      'subjectCode': serializer.toJson<String?>(subjectCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Subject copyWith({
    int? id,
    String? subjectName,
    Value<String?> subjectCode = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Subject(
    id: id ?? this.id,
    subjectName: subjectName ?? this.subjectName,
    subjectCode: subjectCode.present ? subjectCode.value : this.subjectCode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      subjectName: data.subjectName.present
          ? data.subjectName.value
          : this.subjectName,
      subjectCode: data.subjectCode.present
          ? data.subjectCode.value
          : this.subjectCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('subjectName: $subjectName, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, subjectName, subjectCode, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.subjectName == this.subjectName &&
          other.subjectCode == this.subjectCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<String> subjectName;
  final Value<String?> subjectCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.subjectName = const Value.absent(),
    this.subjectCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    required String subjectName,
    this.subjectCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : subjectName = Value(subjectName);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<String>? subjectName,
    Expression<String>? subjectCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectName != null) 'subject_name': subjectName,
      if (subjectCode != null) 'subject_code': subjectCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SubjectsCompanion copyWith({
    Value<int>? id,
    Value<String>? subjectName,
    Value<String?>? subjectCode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SubjectsCompanion(
      id: id ?? this.id,
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subjectName.present) {
      map['subject_name'] = Variable<String>(subjectName.value);
    }
    if (subjectCode.present) {
      map['subject_code'] = Variable<String>(subjectCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('subjectName: $subjectName, ')
          ..write('subjectCode: $subjectCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SemesterSubjectsTable extends SemesterSubjects
    with TableInfo<$SemesterSubjectsTable, SemesterSubject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemesterSubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _semesterIdMeta = const VerificationMeta(
    'semesterId',
  );
  @override
  late final GeneratedColumn<int> semesterId = GeneratedColumn<int>(
    'semester_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES semesters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _subjectIdMeta = const VerificationMeta(
    'subjectId',
  );
  @override
  late final GeneratedColumn<int> subjectId = GeneratedColumn<int>(
    'subject_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subjects (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _attemptNumberMeta = const VerificationMeta(
    'attemptNumber',
  );
  @override
  late final GeneratedColumn<int> attemptNumber = GeneratedColumn<int>(
    'attempt_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _creditsMeta = const VerificationMeta(
    'credits',
  );
  @override
  late final GeneratedColumn<double> credits = GeneratedColumn<double>(
    'credits',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (credits > 0.0)',
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradePointMeta = const VerificationMeta(
    'gradePoint',
  );
  @override
  late final GeneratedColumn<double> gradePoint = GeneratedColumn<double>(
    'grade_point',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    $customConstraints: 'CHECK (grade_point IS NULL OR grade_point >= 0.0)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    semesterId,
    subjectId,
    attemptNumber,
    credits,
    grade,
    gradePoint,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semester_subjects';
  @override
  VerificationContext validateIntegrity(
    Insertable<SemesterSubject> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('semester_id')) {
      context.handle(
        _semesterIdMeta,
        semesterId.isAcceptableOrUnknown(data['semester_id']!, _semesterIdMeta),
      );
    } else if (isInserting) {
      context.missing(_semesterIdMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(
        _subjectIdMeta,
        subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('attempt_number')) {
      context.handle(
        _attemptNumberMeta,
        attemptNumber.isAcceptableOrUnknown(
          data['attempt_number']!,
          _attemptNumberMeta,
        ),
      );
    }
    if (data.containsKey('credits')) {
      context.handle(
        _creditsMeta,
        credits.isAcceptableOrUnknown(data['credits']!, _creditsMeta),
      );
    } else if (isInserting) {
      context.missing(_creditsMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('grade_point')) {
      context.handle(
        _gradePointMeta,
        gradePoint.isAcceptableOrUnknown(data['grade_point']!, _gradePointMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subjectId, attemptNumber},
    {semesterId, subjectId},
  ];
  @override
  SemesterSubject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemesterSubject(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      semesterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}semester_id'],
      )!,
      subjectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subject_id'],
      )!,
      attemptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_number'],
      )!,
      credits: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credits'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      ),
      gradePoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grade_point'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SemesterSubjectsTable createAlias(String alias) {
    return $SemesterSubjectsTable(attachedDatabase, alias);
  }
}

class SemesterSubject extends DataClass implements Insertable<SemesterSubject> {
  final int id;
  final int semesterId;
  final int subjectId;
  final int attemptNumber;
  final double credits;
  final String? grade;
  final double? gradePoint;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SemesterSubject({
    required this.id,
    required this.semesterId,
    required this.subjectId,
    required this.attemptNumber,
    required this.credits,
    this.grade,
    this.gradePoint,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['semester_id'] = Variable<int>(semesterId);
    map['subject_id'] = Variable<int>(subjectId);
    map['attempt_number'] = Variable<int>(attemptNumber);
    map['credits'] = Variable<double>(credits);
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || gradePoint != null) {
      map['grade_point'] = Variable<double>(gradePoint);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SemesterSubjectsCompanion toCompanion(bool nullToAbsent) {
    return SemesterSubjectsCompanion(
      id: Value(id),
      semesterId: Value(semesterId),
      subjectId: Value(subjectId),
      attemptNumber: Value(attemptNumber),
      credits: Value(credits),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      gradePoint: gradePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(gradePoint),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SemesterSubject.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemesterSubject(
      id: serializer.fromJson<int>(json['id']),
      semesterId: serializer.fromJson<int>(json['semesterId']),
      subjectId: serializer.fromJson<int>(json['subjectId']),
      attemptNumber: serializer.fromJson<int>(json['attemptNumber']),
      credits: serializer.fromJson<double>(json['credits']),
      grade: serializer.fromJson<String?>(json['grade']),
      gradePoint: serializer.fromJson<double?>(json['gradePoint']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'semesterId': serializer.toJson<int>(semesterId),
      'subjectId': serializer.toJson<int>(subjectId),
      'attemptNumber': serializer.toJson<int>(attemptNumber),
      'credits': serializer.toJson<double>(credits),
      'grade': serializer.toJson<String?>(grade),
      'gradePoint': serializer.toJson<double?>(gradePoint),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SemesterSubject copyWith({
    int? id,
    int? semesterId,
    int? subjectId,
    int? attemptNumber,
    double? credits,
    Value<String?> grade = const Value.absent(),
    Value<double?> gradePoint = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SemesterSubject(
    id: id ?? this.id,
    semesterId: semesterId ?? this.semesterId,
    subjectId: subjectId ?? this.subjectId,
    attemptNumber: attemptNumber ?? this.attemptNumber,
    credits: credits ?? this.credits,
    grade: grade.present ? grade.value : this.grade,
    gradePoint: gradePoint.present ? gradePoint.value : this.gradePoint,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SemesterSubject copyWithCompanion(SemesterSubjectsCompanion data) {
    return SemesterSubject(
      id: data.id.present ? data.id.value : this.id,
      semesterId: data.semesterId.present
          ? data.semesterId.value
          : this.semesterId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      attemptNumber: data.attemptNumber.present
          ? data.attemptNumber.value
          : this.attemptNumber,
      credits: data.credits.present ? data.credits.value : this.credits,
      grade: data.grade.present ? data.grade.value : this.grade,
      gradePoint: data.gradePoint.present
          ? data.gradePoint.value
          : this.gradePoint,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemesterSubject(')
          ..write('id: $id, ')
          ..write('semesterId: $semesterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('credits: $credits, ')
          ..write('grade: $grade, ')
          ..write('gradePoint: $gradePoint, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    semesterId,
    subjectId,
    attemptNumber,
    credits,
    grade,
    gradePoint,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemesterSubject &&
          other.id == this.id &&
          other.semesterId == this.semesterId &&
          other.subjectId == this.subjectId &&
          other.attemptNumber == this.attemptNumber &&
          other.credits == this.credits &&
          other.grade == this.grade &&
          other.gradePoint == this.gradePoint &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SemesterSubjectsCompanion extends UpdateCompanion<SemesterSubject> {
  final Value<int> id;
  final Value<int> semesterId;
  final Value<int> subjectId;
  final Value<int> attemptNumber;
  final Value<double> credits;
  final Value<String?> grade;
  final Value<double?> gradePoint;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SemesterSubjectsCompanion({
    this.id = const Value.absent(),
    this.semesterId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.attemptNumber = const Value.absent(),
    this.credits = const Value.absent(),
    this.grade = const Value.absent(),
    this.gradePoint = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SemesterSubjectsCompanion.insert({
    this.id = const Value.absent(),
    required int semesterId,
    required int subjectId,
    this.attemptNumber = const Value.absent(),
    required double credits,
    this.grade = const Value.absent(),
    this.gradePoint = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : semesterId = Value(semesterId),
       subjectId = Value(subjectId),
       credits = Value(credits);
  static Insertable<SemesterSubject> custom({
    Expression<int>? id,
    Expression<int>? semesterId,
    Expression<int>? subjectId,
    Expression<int>? attemptNumber,
    Expression<double>? credits,
    Expression<String>? grade,
    Expression<double>? gradePoint,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (semesterId != null) 'semester_id': semesterId,
      if (subjectId != null) 'subject_id': subjectId,
      if (attemptNumber != null) 'attempt_number': attemptNumber,
      if (credits != null) 'credits': credits,
      if (grade != null) 'grade': grade,
      if (gradePoint != null) 'grade_point': gradePoint,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SemesterSubjectsCompanion copyWith({
    Value<int>? id,
    Value<int>? semesterId,
    Value<int>? subjectId,
    Value<int>? attemptNumber,
    Value<double>? credits,
    Value<String?>? grade,
    Value<double?>? gradePoint,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SemesterSubjectsCompanion(
      id: id ?? this.id,
      semesterId: semesterId ?? this.semesterId,
      subjectId: subjectId ?? this.subjectId,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      credits: credits ?? this.credits,
      grade: grade ?? this.grade,
      gradePoint: gradePoint ?? this.gradePoint,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (semesterId.present) {
      map['semester_id'] = Variable<int>(semesterId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<int>(subjectId.value);
    }
    if (attemptNumber.present) {
      map['attempt_number'] = Variable<int>(attemptNumber.value);
    }
    if (credits.present) {
      map['credits'] = Variable<double>(credits.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (gradePoint.present) {
      map['grade_point'] = Variable<double>(gradePoint.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterSubjectsCompanion(')
          ..write('id: $id, ')
          ..write('semesterId: $semesterId, ')
          ..write('subjectId: $subjectId, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('credits: $credits, ')
          ..write('grade: $grade, ')
          ..write('gradePoint: $gradePoint, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GradingScalesTable gradingScales = $GradingScalesTable(this);
  late final $StudentProfilesTable studentProfiles = $StudentProfilesTable(
    this,
  );
  late final $GradingScaleEntriesTable gradingScaleEntries =
      $GradingScaleEntriesTable(this);
  late final $SemestersTable semesters = $SemestersTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $SemesterSubjectsTable semesterSubjects = $SemesterSubjectsTable(
    this,
  );
  late final StudentDao studentDao = StudentDao(this as AppDatabase);
  late final GradingScaleDao gradingScaleDao = GradingScaleDao(
    this as AppDatabase,
  );
  late final SemesterDao semesterDao = SemesterDao(this as AppDatabase);
  late final SubjectDao subjectDao = SubjectDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    gradingScales,
    studentProfiles,
    gradingScaleEntries,
    semesters,
    subjects,
    semesterSubjects,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'grading_scales',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('grading_scale_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'semesters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('semester_subjects', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GradingScalesTableCreateCompanionBuilder =
    GradingScalesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> country,
      Value<String?> university,
      Value<String?> description,
      required String scaleType,
      Value<String> category,
      Value<String> calculationType,
      Value<double> minimumValue,
      required double maximumGpa,
      Value<double> bestValue,
      Value<double> worstValue,
      Value<double> passingValue,
      Value<bool> isHigherBetter,
      Value<int> decimalPlaces,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$GradingScalesTableUpdateCompanionBuilder =
    GradingScalesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> country,
      Value<String?> university,
      Value<String?> description,
      Value<String> scaleType,
      Value<String> category,
      Value<String> calculationType,
      Value<double> minimumValue,
      Value<double> maximumGpa,
      Value<double> bestValue,
      Value<double> worstValue,
      Value<double> passingValue,
      Value<bool> isHigherBetter,
      Value<int> decimalPlaces,
      Value<bool> isDefault,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$GradingScalesTableReferences
    extends BaseReferences<_$AppDatabase, $GradingScalesTable, GradingScale> {
  $$GradingScalesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$StudentProfilesTable, List<StudentProfile>>
  _studentProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.studentProfiles,
    aliasName: 'grading_scales__id__student_profiles__grading_scale_id',
  );

  $$StudentProfilesTableProcessedTableManager get studentProfilesRefs {
    final manager = $$StudentProfilesTableTableManager(
      $_db,
      $_db.studentProfiles,
    ).filter((f) => f.gradingScaleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _studentProfilesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GradingScaleEntriesTable, List<GradingScaleEntry>>
  _gradingScaleEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gradingScaleEntries,
        aliasName:
            'grading_scales__id__grading_scale_entries__grading_scale_id',
      );

  $$GradingScaleEntriesTableProcessedTableManager get gradingScaleEntriesRefs {
    final manager = $$GradingScaleEntriesTableTableManager(
      $_db,
      $_db.gradingScaleEntries,
    ).filter((f) => f.gradingScaleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gradingScaleEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GradingScalesTableFilterComposer
    extends Composer<_$AppDatabase, $GradingScalesTable> {
  $$GradingScalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get university => $composableBuilder(
    column: $table.university,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scaleType => $composableBuilder(
    column: $table.scaleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calculationType => $composableBuilder(
    column: $table.calculationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimumValue => $composableBuilder(
    column: $table.minimumValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maximumGpa => $composableBuilder(
    column: $table.maximumGpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bestValue => $composableBuilder(
    column: $table.bestValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get worstValue => $composableBuilder(
    column: $table.worstValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get passingValue => $composableBuilder(
    column: $table.passingValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHigherBetter => $composableBuilder(
    column: $table.isHigherBetter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studentProfilesRefs(
    Expression<bool> Function($$StudentProfilesTableFilterComposer f) f,
  ) {
    final $$StudentProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentProfiles,
      getReferencedColumn: (t) => t.gradingScaleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentProfilesTableFilterComposer(
            $db: $db,
            $table: $db.studentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gradingScaleEntriesRefs(
    Expression<bool> Function($$GradingScaleEntriesTableFilterComposer f) f,
  ) {
    final $$GradingScaleEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradingScaleEntries,
      getReferencedColumn: (t) => t.gradingScaleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScaleEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gradingScaleEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GradingScalesTableOrderingComposer
    extends Composer<_$AppDatabase, $GradingScalesTable> {
  $$GradingScalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get university => $composableBuilder(
    column: $table.university,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scaleType => $composableBuilder(
    column: $table.scaleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calculationType => $composableBuilder(
    column: $table.calculationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimumValue => $composableBuilder(
    column: $table.minimumValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maximumGpa => $composableBuilder(
    column: $table.maximumGpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bestValue => $composableBuilder(
    column: $table.bestValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get worstValue => $composableBuilder(
    column: $table.worstValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get passingValue => $composableBuilder(
    column: $table.passingValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHigherBetter => $composableBuilder(
    column: $table.isHigherBetter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GradingScalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradingScalesTable> {
  $$GradingScalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get university => $composableBuilder(
    column: $table.university,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scaleType =>
      $composableBuilder(column: $table.scaleType, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get calculationType => $composableBuilder(
    column: $table.calculationType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minimumValue => $composableBuilder(
    column: $table.minimumValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maximumGpa => $composableBuilder(
    column: $table.maximumGpa,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bestValue =>
      $composableBuilder(column: $table.bestValue, builder: (column) => column);

  GeneratedColumn<double> get worstValue => $composableBuilder(
    column: $table.worstValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get passingValue => $composableBuilder(
    column: $table.passingValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isHigherBetter => $composableBuilder(
    column: $table.isHigherBetter,
    builder: (column) => column,
  );

  GeneratedColumn<int> get decimalPlaces => $composableBuilder(
    column: $table.decimalPlaces,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> studentProfilesRefs<T extends Object>(
    Expression<T> Function($$StudentProfilesTableAnnotationComposer a) f,
  ) {
    final $$StudentProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.studentProfiles,
      getReferencedColumn: (t) => t.gradingScaleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.studentProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gradingScaleEntriesRefs<T extends Object>(
    Expression<T> Function($$GradingScaleEntriesTableAnnotationComposer a) f,
  ) {
    final $$GradingScaleEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gradingScaleEntries,
          getReferencedColumn: (t) => t.gradingScaleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GradingScaleEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.gradingScaleEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GradingScalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradingScalesTable,
          GradingScale,
          $$GradingScalesTableFilterComposer,
          $$GradingScalesTableOrderingComposer,
          $$GradingScalesTableAnnotationComposer,
          $$GradingScalesTableCreateCompanionBuilder,
          $$GradingScalesTableUpdateCompanionBuilder,
          (GradingScale, $$GradingScalesTableReferences),
          GradingScale,
          PrefetchHooks Function({
            bool studentProfilesRefs,
            bool gradingScaleEntriesRefs,
          })
        > {
  $$GradingScalesTableTableManager(_$AppDatabase db, $GradingScalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradingScalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradingScalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradingScalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> university = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> scaleType = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> calculationType = const Value.absent(),
                Value<double> minimumValue = const Value.absent(),
                Value<double> maximumGpa = const Value.absent(),
                Value<double> bestValue = const Value.absent(),
                Value<double> worstValue = const Value.absent(),
                Value<double> passingValue = const Value.absent(),
                Value<bool> isHigherBetter = const Value.absent(),
                Value<int> decimalPlaces = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GradingScalesCompanion(
                id: id,
                name: name,
                country: country,
                university: university,
                description: description,
                scaleType: scaleType,
                category: category,
                calculationType: calculationType,
                minimumValue: minimumValue,
                maximumGpa: maximumGpa,
                bestValue: bestValue,
                worstValue: worstValue,
                passingValue: passingValue,
                isHigherBetter: isHigherBetter,
                decimalPlaces: decimalPlaces,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> country = const Value.absent(),
                Value<String?> university = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String scaleType,
                Value<String> category = const Value.absent(),
                Value<String> calculationType = const Value.absent(),
                Value<double> minimumValue = const Value.absent(),
                required double maximumGpa,
                Value<double> bestValue = const Value.absent(),
                Value<double> worstValue = const Value.absent(),
                Value<double> passingValue = const Value.absent(),
                Value<bool> isHigherBetter = const Value.absent(),
                Value<int> decimalPlaces = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GradingScalesCompanion.insert(
                id: id,
                name: name,
                country: country,
                university: university,
                description: description,
                scaleType: scaleType,
                category: category,
                calculationType: calculationType,
                minimumValue: minimumValue,
                maximumGpa: maximumGpa,
                bestValue: bestValue,
                worstValue: worstValue,
                passingValue: passingValue,
                isHigherBetter: isHigherBetter,
                decimalPlaces: decimalPlaces,
                isDefault: isDefault,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GradingScalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({studentProfilesRefs = false, gradingScaleEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (studentProfilesRefs) db.studentProfiles,
                    if (gradingScaleEntriesRefs) db.gradingScaleEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (studentProfilesRefs)
                        await $_getPrefetchedData<
                          GradingScale,
                          $GradingScalesTable,
                          StudentProfile
                        >(
                          currentTable: table,
                          referencedTable: $$GradingScalesTableReferences
                              ._studentProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingScalesTableReferences(
                                db,
                                table,
                                p0,
                              ).studentProfilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gradingScaleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gradingScaleEntriesRefs)
                        await $_getPrefetchedData<
                          GradingScale,
                          $GradingScalesTable,
                          GradingScaleEntry
                        >(
                          currentTable: table,
                          referencedTable: $$GradingScalesTableReferences
                              ._gradingScaleEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GradingScalesTableReferences(
                                db,
                                table,
                                p0,
                              ).gradingScaleEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gradingScaleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GradingScalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradingScalesTable,
      GradingScale,
      $$GradingScalesTableFilterComposer,
      $$GradingScalesTableOrderingComposer,
      $$GradingScalesTableAnnotationComposer,
      $$GradingScalesTableCreateCompanionBuilder,
      $$GradingScalesTableUpdateCompanionBuilder,
      (GradingScale, $$GradingScalesTableReferences),
      GradingScale,
      PrefetchHooks Function({
        bool studentProfilesRefs,
        bool gradingScaleEntriesRefs,
      })
    >;
typedef $$StudentProfilesTableCreateCompanionBuilder =
    StudentProfilesCompanion Function({
      Value<int> id,
      required String name,
      required String degreeName,
      required String universityName,
      Value<String?> profilePhotoPath,
      required int gradingScaleId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$StudentProfilesTableUpdateCompanionBuilder =
    StudentProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> degreeName,
      Value<String> universityName,
      Value<String?> profilePhotoPath,
      Value<int> gradingScaleId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$StudentProfilesTableReferences
    extends
        BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfile> {
  $$StudentProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GradingScalesTable _gradingScaleIdTable(_$AppDatabase db) => db
      .gradingScales
      .createAlias('student_profiles__grading_scale_id__grading_scales__id');

  $$GradingScalesTableProcessedTableManager get gradingScaleId {
    final $_column = $_itemColumn<int>('grading_scale_id')!;

    final manager = $$GradingScalesTableTableManager(
      $_db,
      $_db.gradingScales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingScaleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get degreeName => $composableBuilder(
    column: $table.degreeName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profilePhotoPath => $composableBuilder(
    column: $table.profilePhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GradingScalesTableFilterComposer get gradingScaleId {
    final $$GradingScalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableFilterComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get degreeName => $composableBuilder(
    column: $table.degreeName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profilePhotoPath => $composableBuilder(
    column: $table.profilePhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GradingScalesTableOrderingComposer get gradingScaleId {
    final $$GradingScalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableOrderingComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get degreeName => $composableBuilder(
    column: $table.degreeName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get universityName => $composableBuilder(
    column: $table.universityName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get profilePhotoPath => $composableBuilder(
    column: $table.profilePhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GradingScalesTableAnnotationComposer get gradingScaleId {
    final $$GradingScalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudentProfilesTable,
          StudentProfile,
          $$StudentProfilesTableFilterComposer,
          $$StudentProfilesTableOrderingComposer,
          $$StudentProfilesTableAnnotationComposer,
          $$StudentProfilesTableCreateCompanionBuilder,
          $$StudentProfilesTableUpdateCompanionBuilder,
          (StudentProfile, $$StudentProfilesTableReferences),
          StudentProfile,
          PrefetchHooks Function({bool gradingScaleId})
        > {
  $$StudentProfilesTableTableManager(
    _$AppDatabase db,
    $StudentProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> degreeName = const Value.absent(),
                Value<String> universityName = const Value.absent(),
                Value<String?> profilePhotoPath = const Value.absent(),
                Value<int> gradingScaleId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentProfilesCompanion(
                id: id,
                name: name,
                degreeName: degreeName,
                universityName: universityName,
                profilePhotoPath: profilePhotoPath,
                gradingScaleId: gradingScaleId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String degreeName,
                required String universityName,
                Value<String?> profilePhotoPath = const Value.absent(),
                required int gradingScaleId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudentProfilesCompanion.insert(
                id: id,
                name: name,
                degreeName: degreeName,
                universityName: universityName,
                profilePhotoPath: profilePhotoPath,
                gradingScaleId: gradingScaleId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gradingScaleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gradingScaleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gradingScaleId,
                                referencedTable:
                                    $$StudentProfilesTableReferences
                                        ._gradingScaleIdTable(db),
                                referencedColumn:
                                    $$StudentProfilesTableReferences
                                        ._gradingScaleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$StudentProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudentProfilesTable,
      StudentProfile,
      $$StudentProfilesTableFilterComposer,
      $$StudentProfilesTableOrderingComposer,
      $$StudentProfilesTableAnnotationComposer,
      $$StudentProfilesTableCreateCompanionBuilder,
      $$StudentProfilesTableUpdateCompanionBuilder,
      (StudentProfile, $$StudentProfilesTableReferences),
      StudentProfile,
      PrefetchHooks Function({bool gradingScaleId})
    >;
typedef $$GradingScaleEntriesTableCreateCompanionBuilder =
    GradingScaleEntriesCompanion Function({
      Value<int> id,
      required int gradingScaleId,
      required String grade,
      required double gradePoint,
      Value<double?> minimumPercentage,
      Value<double?> maximumPercentage,
      Value<bool> isPassing,
      Value<int> displayOrder,
    });
typedef $$GradingScaleEntriesTableUpdateCompanionBuilder =
    GradingScaleEntriesCompanion Function({
      Value<int> id,
      Value<int> gradingScaleId,
      Value<String> grade,
      Value<double> gradePoint,
      Value<double?> minimumPercentage,
      Value<double?> maximumPercentage,
      Value<bool> isPassing,
      Value<int> displayOrder,
    });

final class $$GradingScaleEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GradingScaleEntriesTable,
          GradingScaleEntry
        > {
  $$GradingScaleEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GradingScalesTable _gradingScaleIdTable(_$AppDatabase db) =>
      db.gradingScales.createAlias(
        'grading_scale_entries__grading_scale_id__grading_scales__id',
      );

  $$GradingScalesTableProcessedTableManager get gradingScaleId {
    final $_column = $_itemColumn<int>('grading_scale_id')!;

    final manager = $$GradingScalesTableTableManager(
      $_db,
      $_db.gradingScales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gradingScaleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GradingScaleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GradingScaleEntriesTable> {
  $$GradingScaleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimumPercentage => $composableBuilder(
    column: $table.minimumPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maximumPercentage => $composableBuilder(
    column: $table.maximumPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPassing => $composableBuilder(
    column: $table.isPassing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$GradingScalesTableFilterComposer get gradingScaleId {
    final $$GradingScalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableFilterComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingScaleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GradingScaleEntriesTable> {
  $$GradingScaleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimumPercentage => $composableBuilder(
    column: $table.minimumPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maximumPercentage => $composableBuilder(
    column: $table.maximumPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPassing => $composableBuilder(
    column: $table.isPassing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$GradingScalesTableOrderingComposer get gradingScaleId {
    final $$GradingScalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableOrderingComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingScaleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradingScaleEntriesTable> {
  $$GradingScaleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minimumPercentage => $composableBuilder(
    column: $table.minimumPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maximumPercentage => $composableBuilder(
    column: $table.maximumPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPassing =>
      $composableBuilder(column: $table.isPassing, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$GradingScalesTableAnnotationComposer get gradingScaleId {
    final $$GradingScalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gradingScaleId,
      referencedTable: $db.gradingScales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradingScalesTableAnnotationComposer(
            $db: $db,
            $table: $db.gradingScales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradingScaleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradingScaleEntriesTable,
          GradingScaleEntry,
          $$GradingScaleEntriesTableFilterComposer,
          $$GradingScaleEntriesTableOrderingComposer,
          $$GradingScaleEntriesTableAnnotationComposer,
          $$GradingScaleEntriesTableCreateCompanionBuilder,
          $$GradingScaleEntriesTableUpdateCompanionBuilder,
          (GradingScaleEntry, $$GradingScaleEntriesTableReferences),
          GradingScaleEntry,
          PrefetchHooks Function({bool gradingScaleId})
        > {
  $$GradingScaleEntriesTableTableManager(
    _$AppDatabase db,
    $GradingScaleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradingScaleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradingScaleEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GradingScaleEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> gradingScaleId = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<double> gradePoint = const Value.absent(),
                Value<double?> minimumPercentage = const Value.absent(),
                Value<double?> maximumPercentage = const Value.absent(),
                Value<bool> isPassing = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => GradingScaleEntriesCompanion(
                id: id,
                gradingScaleId: gradingScaleId,
                grade: grade,
                gradePoint: gradePoint,
                minimumPercentage: minimumPercentage,
                maximumPercentage: maximumPercentage,
                isPassing: isPassing,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int gradingScaleId,
                required String grade,
                required double gradePoint,
                Value<double?> minimumPercentage = const Value.absent(),
                Value<double?> maximumPercentage = const Value.absent(),
                Value<bool> isPassing = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => GradingScaleEntriesCompanion.insert(
                id: id,
                gradingScaleId: gradingScaleId,
                grade: grade,
                gradePoint: gradePoint,
                minimumPercentage: minimumPercentage,
                maximumPercentage: maximumPercentage,
                isPassing: isPassing,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GradingScaleEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gradingScaleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gradingScaleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gradingScaleId,
                                referencedTable:
                                    $$GradingScaleEntriesTableReferences
                                        ._gradingScaleIdTable(db),
                                referencedColumn:
                                    $$GradingScaleEntriesTableReferences
                                        ._gradingScaleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GradingScaleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradingScaleEntriesTable,
      GradingScaleEntry,
      $$GradingScaleEntriesTableFilterComposer,
      $$GradingScaleEntriesTableOrderingComposer,
      $$GradingScaleEntriesTableAnnotationComposer,
      $$GradingScaleEntriesTableCreateCompanionBuilder,
      $$GradingScaleEntriesTableUpdateCompanionBuilder,
      (GradingScaleEntry, $$GradingScaleEntriesTableReferences),
      GradingScaleEntry,
      PrefetchHooks Function({bool gradingScaleId})
    >;
typedef $$SemestersTableCreateCompanionBuilder =
    SemestersCompanion Function({
      Value<int> id,
      required String name,
      required int academicYear,
      required int semesterNumber,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SemestersTableUpdateCompanionBuilder =
    SemestersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> academicYear,
      Value<int> semesterNumber,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SemestersTableReferences
    extends BaseReferences<_$AppDatabase, $SemestersTable, Semester> {
  $$SemestersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SemesterSubjectsTable, List<SemesterSubject>>
  _semesterSubjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.semesterSubjects,
    aliasName: 'semesters__id__semester_subjects__semester_id',
  );

  $$SemesterSubjectsTableProcessedTableManager get semesterSubjectsRefs {
    final manager = $$SemesterSubjectsTableTableManager(
      $_db,
      $_db.semesterSubjects,
    ).filter((f) => f.semesterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _semesterSubjectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SemestersTableFilterComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get semesterNumber => $composableBuilder(
    column: $table.semesterNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> semesterSubjectsRefs(
    Expression<bool> Function($$SemesterSubjectsTableFilterComposer f) f,
  ) {
    final $$SemesterSubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesterSubjects,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterSubjectsTableFilterComposer(
            $db: $db,
            $table: $db.semesterSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemestersTableOrderingComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get semesterNumber => $composableBuilder(
    column: $table.semesterNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SemestersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemestersTable> {
  $$SemestersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get academicYear => $composableBuilder(
    column: $table.academicYear,
    builder: (column) => column,
  );

  GeneratedColumn<int> get semesterNumber => $composableBuilder(
    column: $table.semesterNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> semesterSubjectsRefs<T extends Object>(
    Expression<T> Function($$SemesterSubjectsTableAnnotationComposer a) f,
  ) {
    final $$SemesterSubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesterSubjects,
      getReferencedColumn: (t) => t.semesterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterSubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.semesterSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SemestersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemestersTable,
          Semester,
          $$SemestersTableFilterComposer,
          $$SemestersTableOrderingComposer,
          $$SemestersTableAnnotationComposer,
          $$SemestersTableCreateCompanionBuilder,
          $$SemestersTableUpdateCompanionBuilder,
          (Semester, $$SemestersTableReferences),
          Semester,
          PrefetchHooks Function({bool semesterSubjectsRefs})
        > {
  $$SemestersTableTableManager(_$AppDatabase db, $SemestersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemestersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemestersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemestersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> academicYear = const Value.absent(),
                Value<int> semesterNumber = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemestersCompanion(
                id: id,
                name: name,
                academicYear: academicYear,
                semesterNumber: semesterNumber,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int academicYear,
                required int semesterNumber,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemestersCompanion.insert(
                id: id,
                name: name,
                academicYear: academicYear,
                semesterNumber: semesterNumber,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SemestersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({semesterSubjectsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (semesterSubjectsRefs) db.semesterSubjects,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (semesterSubjectsRefs)
                    await $_getPrefetchedData<
                      Semester,
                      $SemestersTable,
                      SemesterSubject
                    >(
                      currentTable: table,
                      referencedTable: $$SemestersTableReferences
                          ._semesterSubjectsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SemestersTableReferences(
                            db,
                            table,
                            p0,
                          ).semesterSubjectsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.semesterId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SemestersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemestersTable,
      Semester,
      $$SemestersTableFilterComposer,
      $$SemestersTableOrderingComposer,
      $$SemestersTableAnnotationComposer,
      $$SemestersTableCreateCompanionBuilder,
      $$SemestersTableUpdateCompanionBuilder,
      (Semester, $$SemestersTableReferences),
      Semester,
      PrefetchHooks Function({bool semesterSubjectsRefs})
    >;
typedef $$SubjectsTableCreateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      required String subjectName,
      Value<String?> subjectCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SubjectsTableUpdateCompanionBuilder =
    SubjectsCompanion Function({
      Value<int> id,
      Value<String> subjectName,
      Value<String?> subjectCode,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SemesterSubjectsTable, List<SemesterSubject>>
  _semesterSubjectsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.semesterSubjects,
    aliasName: 'subjects__id__semester_subjects__subject_id',
  );

  $$SemesterSubjectsTableProcessedTableManager get semesterSubjectsRefs {
    final manager = $$SemesterSubjectsTableTableManager(
      $_db,
      $_db.semesterSubjects,
    ).filter((f) => f.subjectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _semesterSubjectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subjectCode => $composableBuilder(
    column: $table.subjectCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> semesterSubjectsRefs(
    Expression<bool> Function($$SemesterSubjectsTableFilterComposer f) f,
  ) {
    final $$SemesterSubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesterSubjects,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterSubjectsTableFilterComposer(
            $db: $db,
            $table: $db.semesterSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subjectCode => $composableBuilder(
    column: $table.subjectCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subjectName => $composableBuilder(
    column: $table.subjectName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subjectCode => $composableBuilder(
    column: $table.subjectCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> semesterSubjectsRefs<T extends Object>(
    Expression<T> Function($$SemesterSubjectsTableAnnotationComposer a) f,
  ) {
    final $$SemesterSubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.semesterSubjects,
      getReferencedColumn: (t) => t.subjectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemesterSubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.semesterSubjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubjectsTable,
          Subject,
          $$SubjectsTableFilterComposer,
          $$SubjectsTableOrderingComposer,
          $$SubjectsTableAnnotationComposer,
          $$SubjectsTableCreateCompanionBuilder,
          $$SubjectsTableUpdateCompanionBuilder,
          (Subject, $$SubjectsTableReferences),
          Subject,
          PrefetchHooks Function({bool semesterSubjectsRefs})
        > {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> subjectName = const Value.absent(),
                Value<String?> subjectCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SubjectsCompanion(
                id: id,
                subjectName: subjectName,
                subjectCode: subjectCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String subjectName,
                Value<String?> subjectCode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SubjectsCompanion.insert(
                id: id,
                subjectName: subjectName,
                subjectCode: subjectCode,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({semesterSubjectsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (semesterSubjectsRefs) db.semesterSubjects,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (semesterSubjectsRefs)
                    await $_getPrefetchedData<
                      Subject,
                      $SubjectsTable,
                      SemesterSubject
                    >(
                      currentTable: table,
                      referencedTable: $$SubjectsTableReferences
                          ._semesterSubjectsRefsTable(db),
                      managerFromTypedResult: (p0) => $$SubjectsTableReferences(
                        db,
                        table,
                        p0,
                      ).semesterSubjectsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.subjectId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubjectsTable,
      Subject,
      $$SubjectsTableFilterComposer,
      $$SubjectsTableOrderingComposer,
      $$SubjectsTableAnnotationComposer,
      $$SubjectsTableCreateCompanionBuilder,
      $$SubjectsTableUpdateCompanionBuilder,
      (Subject, $$SubjectsTableReferences),
      Subject,
      PrefetchHooks Function({bool semesterSubjectsRefs})
    >;
typedef $$SemesterSubjectsTableCreateCompanionBuilder =
    SemesterSubjectsCompanion Function({
      Value<int> id,
      required int semesterId,
      required int subjectId,
      Value<int> attemptNumber,
      required double credits,
      Value<String?> grade,
      Value<double?> gradePoint,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SemesterSubjectsTableUpdateCompanionBuilder =
    SemesterSubjectsCompanion Function({
      Value<int> id,
      Value<int> semesterId,
      Value<int> subjectId,
      Value<int> attemptNumber,
      Value<double> credits,
      Value<String?> grade,
      Value<double?> gradePoint,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$SemesterSubjectsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SemesterSubjectsTable, SemesterSubject> {
  $$SemesterSubjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SemestersTable _semesterIdTable(_$AppDatabase db) =>
      db.semesters.createAlias('semester_subjects__semester_id__semesters__id');

  $$SemestersTableProcessedTableManager get semesterId {
    final $_column = $_itemColumn<int>('semester_id')!;

    final manager = $$SemestersTableTableManager(
      $_db,
      $_db.semesters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_semesterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('semester_subjects__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<int>('subject_id')!;

    final manager = $$SubjectsTableTableManager(
      $_db,
      $_db.subjects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SemesterSubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SemesterSubjectsTable> {
  $$SemesterSubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get credits => $composableBuilder(
    column: $table.credits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SemestersTableFilterComposer get semesterId {
    final $$SemestersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableFilterComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableFilterComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SemesterSubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SemesterSubjectsTable> {
  $$SemesterSubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get credits => $composableBuilder(
    column: $table.credits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SemestersTableOrderingComposer get semesterId {
    final $$SemestersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableOrderingComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableOrderingComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SemesterSubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemesterSubjectsTable> {
  $$SemesterSubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get credits =>
      $composableBuilder(column: $table.credits, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<double> get gradePoint => $composableBuilder(
    column: $table.gradePoint,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SemestersTableAnnotationComposer get semesterId {
    final $$SemestersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.semesterId,
      referencedTable: $db.semesters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SemestersTableAnnotationComposer(
            $db: $db,
            $table: $db.semesters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subjectId,
      referencedTable: $db.subjects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.subjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SemesterSubjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemesterSubjectsTable,
          SemesterSubject,
          $$SemesterSubjectsTableFilterComposer,
          $$SemesterSubjectsTableOrderingComposer,
          $$SemesterSubjectsTableAnnotationComposer,
          $$SemesterSubjectsTableCreateCompanionBuilder,
          $$SemesterSubjectsTableUpdateCompanionBuilder,
          (SemesterSubject, $$SemesterSubjectsTableReferences),
          SemesterSubject,
          PrefetchHooks Function({bool semesterId, bool subjectId})
        > {
  $$SemesterSubjectsTableTableManager(
    _$AppDatabase db,
    $SemesterSubjectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemesterSubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemesterSubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemesterSubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> semesterId = const Value.absent(),
                Value<int> subjectId = const Value.absent(),
                Value<int> attemptNumber = const Value.absent(),
                Value<double> credits = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<double?> gradePoint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemesterSubjectsCompanion(
                id: id,
                semesterId: semesterId,
                subjectId: subjectId,
                attemptNumber: attemptNumber,
                credits: credits,
                grade: grade,
                gradePoint: gradePoint,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int semesterId,
                required int subjectId,
                Value<int> attemptNumber = const Value.absent(),
                required double credits,
                Value<String?> grade = const Value.absent(),
                Value<double?> gradePoint = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemesterSubjectsCompanion.insert(
                id: id,
                semesterId: semesterId,
                subjectId: subjectId,
                attemptNumber: attemptNumber,
                credits: credits,
                grade: grade,
                gradePoint: gradePoint,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SemesterSubjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({semesterId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (semesterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.semesterId,
                                referencedTable:
                                    $$SemesterSubjectsTableReferences
                                        ._semesterIdTable(db),
                                referencedColumn:
                                    $$SemesterSubjectsTableReferences
                                        ._semesterIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (subjectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.subjectId,
                                referencedTable:
                                    $$SemesterSubjectsTableReferences
                                        ._subjectIdTable(db),
                                referencedColumn:
                                    $$SemesterSubjectsTableReferences
                                        ._subjectIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SemesterSubjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemesterSubjectsTable,
      SemesterSubject,
      $$SemesterSubjectsTableFilterComposer,
      $$SemesterSubjectsTableOrderingComposer,
      $$SemesterSubjectsTableAnnotationComposer,
      $$SemesterSubjectsTableCreateCompanionBuilder,
      $$SemesterSubjectsTableUpdateCompanionBuilder,
      (SemesterSubject, $$SemesterSubjectsTableReferences),
      SemesterSubject,
      PrefetchHooks Function({bool semesterId, bool subjectId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GradingScalesTableTableManager get gradingScales =>
      $$GradingScalesTableTableManager(_db, _db.gradingScales);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$GradingScaleEntriesTableTableManager get gradingScaleEntries =>
      $$GradingScaleEntriesTableTableManager(_db, _db.gradingScaleEntries);
  $$SemestersTableTableManager get semesters =>
      $$SemestersTableTableManager(_db, _db.semesters);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$SemesterSubjectsTableTableManager get semesterSubjects =>
      $$SemesterSubjectsTableTableManager(_db, _db.semesterSubjects);
}
