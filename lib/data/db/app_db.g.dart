// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
      'lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _elevationMeta =
      const VerificationMeta('elevation');
  @override
  late final GeneratedColumn<double> elevation = GeneratedColumn<double>(
      'elevation', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        countryCode,
        timezone,
        lat,
        lon,
        elevation,
        isDefault,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
          _lonMeta, lon.isAcceptableOrUnknown(data['lon']!, _lonMeta));
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('elevation')) {
      context.handle(_elevationMeta,
          elevation.isAcceptableOrUnknown(data['elevation']!, _elevationMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lon'])!,
      elevation: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}elevation']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String name;
  final String countryCode;
  final String timezone;
  final double lat;
  final double lon;
  final double? elevation;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Profile(
      {required this.id,
      required this.name,
      required this.countryCode,
      required this.timezone,
      required this.lat,
      required this.lon,
      this.elevation,
      required this.isDefault,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['country_code'] = Variable<String>(countryCode);
    map['timezone'] = Variable<String>(timezone);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    if (!nullToAbsent || elevation != null) {
      map['elevation'] = Variable<double>(elevation);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      name: Value(name),
      countryCode: Value(countryCode),
      timezone: Value(timezone),
      lat: Value(lat),
      lon: Value(lon),
      elevation: elevation == null && nullToAbsent
          ? const Value.absent()
          : Value(elevation),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      timezone: serializer.fromJson<String>(json['timezone']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      elevation: serializer.fromJson<double?>(json['elevation']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'countryCode': serializer.toJson<String>(countryCode),
      'timezone': serializer.toJson<String>(timezone),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'elevation': serializer.toJson<double?>(elevation),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Profile copyWith(
          {String? id,
          String? name,
          String? countryCode,
          String? timezone,
          double? lat,
          double? lon,
          Value<double?> elevation = const Value.absent(),
          bool? isDefault,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Profile(
        id: id ?? this.id,
        name: name ?? this.name,
        countryCode: countryCode ?? this.countryCode,
        timezone: timezone ?? this.timezone,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        elevation: elevation.present ? elevation.value : this.elevation,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      elevation: data.elevation.present ? data.elevation.value : this.elevation,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('timezone: $timezone, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('elevation: $elevation, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, countryCode, timezone, lat, lon,
      elevation, isDefault, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.name == this.name &&
          other.countryCode == this.countryCode &&
          other.timezone == this.timezone &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.elevation == this.elevation &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> countryCode;
  final Value<String> timezone;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double?> elevation;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.timezone = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.elevation = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String name,
    required String countryCode,
    required String timezone,
    required double lat,
    required double lon,
    this.elevation = const Value.absent(),
    this.isDefault = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        countryCode = Value(countryCode),
        timezone = Value(timezone),
        lat = Value(lat),
        lon = Value(lon),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? countryCode,
    Expression<String>? timezone,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? elevation,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (countryCode != null) 'country_code': countryCode,
      if (timezone != null) 'timezone': timezone,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (elevation != null) 'elevation': elevation,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? countryCode,
      Value<String>? timezone,
      Value<double>? lat,
      Value<double>? lon,
      Value<double?>? elevation,
      Value<bool>? isDefault,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      timezone: timezone ?? this.timezone,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      elevation: elevation ?? this.elevation,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (elevation.present) {
      map['elevation'] = Variable<double>(elevation.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('countryCode: $countryCode, ')
          ..write('timezone: $timezone, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('elevation: $elevation, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LayersTable extends Layers with TableInfo<$LayersTable, Layer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<LayerType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<LayerType>($LayersTable.$convertertype);
  static const VerificationMeta _variantMeta =
      const VerificationMeta('variant');
  @override
  late final GeneratedColumn<String> variant = GeneratedColumn<String>(
      'variant', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enabledByDefaultMeta =
      const VerificationMeta('enabledByDefault');
  @override
  late final GeneratedColumn<bool> enabledByDefault = GeneratedColumn<bool>(
      'enabled_by_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enabled_by_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, variant, displayName, color, enabledByDefault, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'layers';
  @override
  VerificationContext validateIntegrity(Insertable<Layer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('variant')) {
      context.handle(_variantMeta,
          variant.isAcceptableOrUnknown(data['variant']!, _variantMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('enabled_by_default')) {
      context.handle(
          _enabledByDefaultMeta,
          enabledByDefault.isAcceptableOrUnknown(
              data['enabled_by_default']!, _enabledByDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Layer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Layer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: $LayersTable.$convertertype.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      variant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
      enabledByDefault: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enabled_by_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LayersTable createAlias(String alias) {
    return $LayersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LayerType, int, int> $convertertype =
      const EnumIndexConverter<LayerType>(LayerType.values);
}

class Layer extends DataClass implements Insertable<Layer> {
  final String id;
  final LayerType type;
  final String variant;
  final String displayName;
  final int color;
  final bool enabledByDefault;
  final DateTime createdAt;
  const Layer(
      {required this.id,
      required this.type,
      required this.variant,
      required this.displayName,
      required this.color,
      required this.enabledByDefault,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<int>($LayersTable.$convertertype.toSql(type));
    }
    map['variant'] = Variable<String>(variant);
    map['display_name'] = Variable<String>(displayName);
    map['color'] = Variable<int>(color);
    map['enabled_by_default'] = Variable<bool>(enabledByDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LayersCompanion toCompanion(bool nullToAbsent) {
    return LayersCompanion(
      id: Value(id),
      type: Value(type),
      variant: Value(variant),
      displayName: Value(displayName),
      color: Value(color),
      enabledByDefault: Value(enabledByDefault),
      createdAt: Value(createdAt),
    );
  }

  factory Layer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Layer(
      id: serializer.fromJson<String>(json['id']),
      type: $LayersTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      variant: serializer.fromJson<String>(json['variant']),
      displayName: serializer.fromJson<String>(json['displayName']),
      color: serializer.fromJson<int>(json['color']),
      enabledByDefault: serializer.fromJson<bool>(json['enabledByDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<int>($LayersTable.$convertertype.toJson(type)),
      'variant': serializer.toJson<String>(variant),
      'displayName': serializer.toJson<String>(displayName),
      'color': serializer.toJson<int>(color),
      'enabledByDefault': serializer.toJson<bool>(enabledByDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Layer copyWith(
          {String? id,
          LayerType? type,
          String? variant,
          String? displayName,
          int? color,
          bool? enabledByDefault,
          DateTime? createdAt}) =>
      Layer(
        id: id ?? this.id,
        type: type ?? this.type,
        variant: variant ?? this.variant,
        displayName: displayName ?? this.displayName,
        color: color ?? this.color,
        enabledByDefault: enabledByDefault ?? this.enabledByDefault,
        createdAt: createdAt ?? this.createdAt,
      );
  Layer copyWithCompanion(LayersCompanion data) {
    return Layer(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      variant: data.variant.present ? data.variant.value : this.variant,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      color: data.color.present ? data.color.value : this.color,
      enabledByDefault: data.enabledByDefault.present
          ? data.enabledByDefault.value
          : this.enabledByDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Layer(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('variant: $variant, ')
          ..write('displayName: $displayName, ')
          ..write('color: $color, ')
          ..write('enabledByDefault: $enabledByDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, type, variant, displayName, color, enabledByDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Layer &&
          other.id == this.id &&
          other.type == this.type &&
          other.variant == this.variant &&
          other.displayName == this.displayName &&
          other.color == this.color &&
          other.enabledByDefault == this.enabledByDefault &&
          other.createdAt == this.createdAt);
}

class LayersCompanion extends UpdateCompanion<Layer> {
  final Value<String> id;
  final Value<LayerType> type;
  final Value<String> variant;
  final Value<String> displayName;
  final Value<int> color;
  final Value<bool> enabledByDefault;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LayersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.variant = const Value.absent(),
    this.displayName = const Value.absent(),
    this.color = const Value.absent(),
    this.enabledByDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LayersCompanion.insert({
    required String id,
    required LayerType type,
    this.variant = const Value.absent(),
    required String displayName,
    required int color,
    this.enabledByDefault = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        displayName = Value(displayName),
        color = Value(color),
        createdAt = Value(createdAt);
  static Insertable<Layer> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<String>? variant,
    Expression<String>? displayName,
    Expression<int>? color,
    Expression<bool>? enabledByDefault,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (variant != null) 'variant': variant,
      if (displayName != null) 'display_name': displayName,
      if (color != null) 'color': color,
      if (enabledByDefault != null) 'enabled_by_default': enabledByDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LayersCompanion copyWith(
      {Value<String>? id,
      Value<LayerType>? type,
      Value<String>? variant,
      Value<String>? displayName,
      Value<int>? color,
      Value<bool>? enabledByDefault,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LayersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      variant: variant ?? this.variant,
      displayName: displayName ?? this.displayName,
      color: color ?? this.color,
      enabledByDefault: enabledByDefault ?? this.enabledByDefault,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($LayersTable.$convertertype.toSql(type.value));
    }
    if (variant.present) {
      map['variant'] = Variable<String>(variant.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (enabledByDefault.present) {
      map['enabled_by_default'] = Variable<bool>(enabledByDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LayersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('variant: $variant, ')
          ..write('displayName: $displayName, ')
          ..write('color: $color, ')
          ..write('enabledByDefault: $enabledByDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileLayersTable extends ProfileLayers
    with TableInfo<$ProfileLayersTable, ProfileLayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileLayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _layerIdMeta =
      const VerificationMeta('layerId');
  @override
  late final GeneratedColumn<String> layerId = GeneratedColumn<String>(
      'layer_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _visibilityRuleJsonMeta =
      const VerificationMeta('visibilityRuleJson');
  @override
  late final GeneratedColumn<String> visibilityRuleJson =
      GeneratedColumn<String>('visibility_rule_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('{}'));
  static const VerificationMeta _notificationPolicyJsonMeta =
      const VerificationMeta('notificationPolicyJson');
  @override
  late final GeneratedColumn<String> notificationPolicyJson =
      GeneratedColumn<String>('notification_policy_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns => [
        profileId,
        layerId,
        isEnabled,
        visibilityRuleJson,
        notificationPolicyJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_layers';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileLayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('layer_id')) {
      context.handle(_layerIdMeta,
          layerId.isAcceptableOrUnknown(data['layer_id']!, _layerIdMeta));
    } else if (isInserting) {
      context.missing(_layerIdMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('visibility_rule_json')) {
      context.handle(
          _visibilityRuleJsonMeta,
          visibilityRuleJson.isAcceptableOrUnknown(
              data['visibility_rule_json']!, _visibilityRuleJsonMeta));
    }
    if (data.containsKey('notification_policy_json')) {
      context.handle(
          _notificationPolicyJsonMeta,
          notificationPolicyJson.isAcceptableOrUnknown(
              data['notification_policy_json']!, _notificationPolicyJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, layerId};
  @override
  ProfileLayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileLayer(
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      layerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}layer_id'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      visibilityRuleJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}visibility_rule_json'])!,
      notificationPolicyJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}notification_policy_json'])!,
    );
  }

  @override
  $ProfileLayersTable createAlias(String alias) {
    return $ProfileLayersTable(attachedDatabase, alias);
  }
}

class ProfileLayer extends DataClass implements Insertable<ProfileLayer> {
  final String profileId;
  final String layerId;
  final bool isEnabled;
  final String visibilityRuleJson;
  final String notificationPolicyJson;
  const ProfileLayer(
      {required this.profileId,
      required this.layerId,
      required this.isEnabled,
      required this.visibilityRuleJson,
      required this.notificationPolicyJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['layer_id'] = Variable<String>(layerId);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['visibility_rule_json'] = Variable<String>(visibilityRuleJson);
    map['notification_policy_json'] = Variable<String>(notificationPolicyJson);
    return map;
  }

  ProfileLayersCompanion toCompanion(bool nullToAbsent) {
    return ProfileLayersCompanion(
      profileId: Value(profileId),
      layerId: Value(layerId),
      isEnabled: Value(isEnabled),
      visibilityRuleJson: Value(visibilityRuleJson),
      notificationPolicyJson: Value(notificationPolicyJson),
    );
  }

  factory ProfileLayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileLayer(
      profileId: serializer.fromJson<String>(json['profileId']),
      layerId: serializer.fromJson<String>(json['layerId']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      visibilityRuleJson:
          serializer.fromJson<String>(json['visibilityRuleJson']),
      notificationPolicyJson:
          serializer.fromJson<String>(json['notificationPolicyJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'layerId': serializer.toJson<String>(layerId),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'visibilityRuleJson': serializer.toJson<String>(visibilityRuleJson),
      'notificationPolicyJson':
          serializer.toJson<String>(notificationPolicyJson),
    };
  }

  ProfileLayer copyWith(
          {String? profileId,
          String? layerId,
          bool? isEnabled,
          String? visibilityRuleJson,
          String? notificationPolicyJson}) =>
      ProfileLayer(
        profileId: profileId ?? this.profileId,
        layerId: layerId ?? this.layerId,
        isEnabled: isEnabled ?? this.isEnabled,
        visibilityRuleJson: visibilityRuleJson ?? this.visibilityRuleJson,
        notificationPolicyJson:
            notificationPolicyJson ?? this.notificationPolicyJson,
      );
  ProfileLayer copyWithCompanion(ProfileLayersCompanion data) {
    return ProfileLayer(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      layerId: data.layerId.present ? data.layerId.value : this.layerId,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      visibilityRuleJson: data.visibilityRuleJson.present
          ? data.visibilityRuleJson.value
          : this.visibilityRuleJson,
      notificationPolicyJson: data.notificationPolicyJson.present
          ? data.notificationPolicyJson.value
          : this.notificationPolicyJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLayer(')
          ..write('profileId: $profileId, ')
          ..write('layerId: $layerId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('visibilityRuleJson: $visibilityRuleJson, ')
          ..write('notificationPolicyJson: $notificationPolicyJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, layerId, isEnabled,
      visibilityRuleJson, notificationPolicyJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileLayer &&
          other.profileId == this.profileId &&
          other.layerId == this.layerId &&
          other.isEnabled == this.isEnabled &&
          other.visibilityRuleJson == this.visibilityRuleJson &&
          other.notificationPolicyJson == this.notificationPolicyJson);
}

class ProfileLayersCompanion extends UpdateCompanion<ProfileLayer> {
  final Value<String> profileId;
  final Value<String> layerId;
  final Value<bool> isEnabled;
  final Value<String> visibilityRuleJson;
  final Value<String> notificationPolicyJson;
  final Value<int> rowid;
  const ProfileLayersCompanion({
    this.profileId = const Value.absent(),
    this.layerId = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.visibilityRuleJson = const Value.absent(),
    this.notificationPolicyJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileLayersCompanion.insert({
    required String profileId,
    required String layerId,
    this.isEnabled = const Value.absent(),
    this.visibilityRuleJson = const Value.absent(),
    this.notificationPolicyJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : profileId = Value(profileId),
        layerId = Value(layerId);
  static Insertable<ProfileLayer> custom({
    Expression<String>? profileId,
    Expression<String>? layerId,
    Expression<bool>? isEnabled,
    Expression<String>? visibilityRuleJson,
    Expression<String>? notificationPolicyJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (layerId != null) 'layer_id': layerId,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (visibilityRuleJson != null)
        'visibility_rule_json': visibilityRuleJson,
      if (notificationPolicyJson != null)
        'notification_policy_json': notificationPolicyJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileLayersCompanion copyWith(
      {Value<String>? profileId,
      Value<String>? layerId,
      Value<bool>? isEnabled,
      Value<String>? visibilityRuleJson,
      Value<String>? notificationPolicyJson,
      Value<int>? rowid}) {
    return ProfileLayersCompanion(
      profileId: profileId ?? this.profileId,
      layerId: layerId ?? this.layerId,
      isEnabled: isEnabled ?? this.isEnabled,
      visibilityRuleJson: visibilityRuleJson ?? this.visibilityRuleJson,
      notificationPolicyJson:
          notificationPolicyJson ?? this.notificationPolicyJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (layerId.present) {
      map['layer_id'] = Variable<String>(layerId.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (visibilityRuleJson.present) {
      map['visibility_rule_json'] = Variable<String>(visibilityRuleJson.value);
    }
    if (notificationPolicyJson.present) {
      map['notification_policy_json'] =
          Variable<String>(notificationPolicyJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileLayersCompanion(')
          ..write('profileId: $profileId, ')
          ..write('layerId: $layerId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('visibilityRuleJson: $visibilityRuleJson, ')
          ..write('notificationPolicyJson: $notificationPolicyJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MethodsConfigTable extends MethodsConfig
    with TableInfo<$MethodsConfigTable, MethodsConfigData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MethodsConfigTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<JewishMethod, int> jewishMethod =
      GeneratedColumn<int>('jewish_method', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<JewishMethod>(
              $MethodsConfigTable.$converterjewishMethod);
  @override
  late final GeneratedColumnWithTypeConverter<IslamicMethod, int>
      islamicMethod = GeneratedColumn<int>('islamic_method', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<IslamicMethod>(
              $MethodsConfigTable.$converterislamicMethod);
  @override
  late final GeneratedColumnWithTypeConverter<AsrMethod, int> asrMethod =
      GeneratedColumn<int>('asr_method', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<AsrMethod>($MethodsConfigTable.$converterasrMethod);
  @override
  late final GeneratedColumnWithTypeConverter<HighLatRule, int> highLatRule =
      GeneratedColumn<int>('high_lat_rule', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<HighLatRule>(
              $MethodsConfigTable.$converterhighLatRule);
  static const VerificationMeta _customParamsJsonMeta =
      const VerificationMeta('customParamsJson');
  @override
  late final GeneratedColumn<String> customParamsJson = GeneratedColumn<String>(
      'custom_params_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns => [
        profileId,
        jewishMethod,
        islamicMethod,
        asrMethod,
        highLatRule,
        customParamsJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'methods_config';
  @override
  VerificationContext validateIntegrity(Insertable<MethodsConfigData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('custom_params_json')) {
      context.handle(
          _customParamsJsonMeta,
          customParamsJson.isAcceptableOrUnknown(
              data['custom_params_json']!, _customParamsJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId};
  @override
  MethodsConfigData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MethodsConfigData(
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      jewishMethod: $MethodsConfigTable.$converterjewishMethod.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}jewish_method'])!),
      islamicMethod: $MethodsConfigTable.$converterislamicMethod.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}islamic_method'])!),
      asrMethod: $MethodsConfigTable.$converterasrMethod.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}asr_method'])!),
      highLatRule: $MethodsConfigTable.$converterhighLatRule.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}high_lat_rule'])!),
      customParamsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}custom_params_json'])!,
    );
  }

  @override
  $MethodsConfigTable createAlias(String alias) {
    return $MethodsConfigTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<JewishMethod, int, int> $converterjewishMethod =
      const EnumIndexConverter<JewishMethod>(JewishMethod.values);
  static JsonTypeConverter2<IslamicMethod, int, int> $converterislamicMethod =
      const EnumIndexConverter<IslamicMethod>(IslamicMethod.values);
  static JsonTypeConverter2<AsrMethod, int, int> $converterasrMethod =
      const EnumIndexConverter<AsrMethod>(AsrMethod.values);
  static JsonTypeConverter2<HighLatRule, int, int> $converterhighLatRule =
      const EnumIndexConverter<HighLatRule>(HighLatRule.values);
}

class MethodsConfigData extends DataClass
    implements Insertable<MethodsConfigData> {
  final String profileId;
  final JewishMethod jewishMethod;
  final IslamicMethod islamicMethod;
  final AsrMethod asrMethod;
  final HighLatRule highLatRule;
  final String customParamsJson;
  const MethodsConfigData(
      {required this.profileId,
      required this.jewishMethod,
      required this.islamicMethod,
      required this.asrMethod,
      required this.highLatRule,
      required this.customParamsJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    {
      map['jewish_method'] = Variable<int>(
          $MethodsConfigTable.$converterjewishMethod.toSql(jewishMethod));
    }
    {
      map['islamic_method'] = Variable<int>(
          $MethodsConfigTable.$converterislamicMethod.toSql(islamicMethod));
    }
    {
      map['asr_method'] = Variable<int>(
          $MethodsConfigTable.$converterasrMethod.toSql(asrMethod));
    }
    {
      map['high_lat_rule'] = Variable<int>(
          $MethodsConfigTable.$converterhighLatRule.toSql(highLatRule));
    }
    map['custom_params_json'] = Variable<String>(customParamsJson);
    return map;
  }

  MethodsConfigCompanion toCompanion(bool nullToAbsent) {
    return MethodsConfigCompanion(
      profileId: Value(profileId),
      jewishMethod: Value(jewishMethod),
      islamicMethod: Value(islamicMethod),
      asrMethod: Value(asrMethod),
      highLatRule: Value(highLatRule),
      customParamsJson: Value(customParamsJson),
    );
  }

  factory MethodsConfigData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MethodsConfigData(
      profileId: serializer.fromJson<String>(json['profileId']),
      jewishMethod: $MethodsConfigTable.$converterjewishMethod
          .fromJson(serializer.fromJson<int>(json['jewishMethod'])),
      islamicMethod: $MethodsConfigTable.$converterislamicMethod
          .fromJson(serializer.fromJson<int>(json['islamicMethod'])),
      asrMethod: $MethodsConfigTable.$converterasrMethod
          .fromJson(serializer.fromJson<int>(json['asrMethod'])),
      highLatRule: $MethodsConfigTable.$converterhighLatRule
          .fromJson(serializer.fromJson<int>(json['highLatRule'])),
      customParamsJson: serializer.fromJson<String>(json['customParamsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'jewishMethod': serializer.toJson<int>(
          $MethodsConfigTable.$converterjewishMethod.toJson(jewishMethod)),
      'islamicMethod': serializer.toJson<int>(
          $MethodsConfigTable.$converterislamicMethod.toJson(islamicMethod)),
      'asrMethod': serializer.toJson<int>(
          $MethodsConfigTable.$converterasrMethod.toJson(asrMethod)),
      'highLatRule': serializer.toJson<int>(
          $MethodsConfigTable.$converterhighLatRule.toJson(highLatRule)),
      'customParamsJson': serializer.toJson<String>(customParamsJson),
    };
  }

  MethodsConfigData copyWith(
          {String? profileId,
          JewishMethod? jewishMethod,
          IslamicMethod? islamicMethod,
          AsrMethod? asrMethod,
          HighLatRule? highLatRule,
          String? customParamsJson}) =>
      MethodsConfigData(
        profileId: profileId ?? this.profileId,
        jewishMethod: jewishMethod ?? this.jewishMethod,
        islamicMethod: islamicMethod ?? this.islamicMethod,
        asrMethod: asrMethod ?? this.asrMethod,
        highLatRule: highLatRule ?? this.highLatRule,
        customParamsJson: customParamsJson ?? this.customParamsJson,
      );
  MethodsConfigData copyWithCompanion(MethodsConfigCompanion data) {
    return MethodsConfigData(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      jewishMethod: data.jewishMethod.present
          ? data.jewishMethod.value
          : this.jewishMethod,
      islamicMethod: data.islamicMethod.present
          ? data.islamicMethod.value
          : this.islamicMethod,
      asrMethod: data.asrMethod.present ? data.asrMethod.value : this.asrMethod,
      highLatRule:
          data.highLatRule.present ? data.highLatRule.value : this.highLatRule,
      customParamsJson: data.customParamsJson.present
          ? data.customParamsJson.value
          : this.customParamsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MethodsConfigData(')
          ..write('profileId: $profileId, ')
          ..write('jewishMethod: $jewishMethod, ')
          ..write('islamicMethod: $islamicMethod, ')
          ..write('asrMethod: $asrMethod, ')
          ..write('highLatRule: $highLatRule, ')
          ..write('customParamsJson: $customParamsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, jewishMethod, islamicMethod,
      asrMethod, highLatRule, customParamsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MethodsConfigData &&
          other.profileId == this.profileId &&
          other.jewishMethod == this.jewishMethod &&
          other.islamicMethod == this.islamicMethod &&
          other.asrMethod == this.asrMethod &&
          other.highLatRule == this.highLatRule &&
          other.customParamsJson == this.customParamsJson);
}

class MethodsConfigCompanion extends UpdateCompanion<MethodsConfigData> {
  final Value<String> profileId;
  final Value<JewishMethod> jewishMethod;
  final Value<IslamicMethod> islamicMethod;
  final Value<AsrMethod> asrMethod;
  final Value<HighLatRule> highLatRule;
  final Value<String> customParamsJson;
  final Value<int> rowid;
  const MethodsConfigCompanion({
    this.profileId = const Value.absent(),
    this.jewishMethod = const Value.absent(),
    this.islamicMethod = const Value.absent(),
    this.asrMethod = const Value.absent(),
    this.highLatRule = const Value.absent(),
    this.customParamsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MethodsConfigCompanion.insert({
    required String profileId,
    this.jewishMethod = const Value.absent(),
    this.islamicMethod = const Value.absent(),
    this.asrMethod = const Value.absent(),
    this.highLatRule = const Value.absent(),
    this.customParamsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : profileId = Value(profileId);
  static Insertable<MethodsConfigData> custom({
    Expression<String>? profileId,
    Expression<int>? jewishMethod,
    Expression<int>? islamicMethod,
    Expression<int>? asrMethod,
    Expression<int>? highLatRule,
    Expression<String>? customParamsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (jewishMethod != null) 'jewish_method': jewishMethod,
      if (islamicMethod != null) 'islamic_method': islamicMethod,
      if (asrMethod != null) 'asr_method': asrMethod,
      if (highLatRule != null) 'high_lat_rule': highLatRule,
      if (customParamsJson != null) 'custom_params_json': customParamsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MethodsConfigCompanion copyWith(
      {Value<String>? profileId,
      Value<JewishMethod>? jewishMethod,
      Value<IslamicMethod>? islamicMethod,
      Value<AsrMethod>? asrMethod,
      Value<HighLatRule>? highLatRule,
      Value<String>? customParamsJson,
      Value<int>? rowid}) {
    return MethodsConfigCompanion(
      profileId: profileId ?? this.profileId,
      jewishMethod: jewishMethod ?? this.jewishMethod,
      islamicMethod: islamicMethod ?? this.islamicMethod,
      asrMethod: asrMethod ?? this.asrMethod,
      highLatRule: highLatRule ?? this.highLatRule,
      customParamsJson: customParamsJson ?? this.customParamsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (jewishMethod.present) {
      map['jewish_method'] = Variable<int>(
          $MethodsConfigTable.$converterjewishMethod.toSql(jewishMethod.value));
    }
    if (islamicMethod.present) {
      map['islamic_method'] = Variable<int>($MethodsConfigTable
          .$converterislamicMethod
          .toSql(islamicMethod.value));
    }
    if (asrMethod.present) {
      map['asr_method'] = Variable<int>(
          $MethodsConfigTable.$converterasrMethod.toSql(asrMethod.value));
    }
    if (highLatRule.present) {
      map['high_lat_rule'] = Variable<int>(
          $MethodsConfigTable.$converterhighLatRule.toSql(highLatRule.value));
    }
    if (customParamsJson.present) {
      map['custom_params_json'] = Variable<String>(customParamsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MethodsConfigCompanion(')
          ..write('profileId: $profileId, ')
          ..write('jewishMethod: $jewishMethod, ')
          ..write('islamicMethod: $islamicMethod, ')
          ..write('asrMethod: $asrMethod, ')
          ..write('highLatRule: $highLatRule, ')
          ..write('customParamsJson: $customParamsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CitiesTable extends Cities with TableInfo<$CitiesTable, City> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameLocalMeta =
      const VerificationMeta('nameLocal');
  @override
  late final GeneratedColumn<String> nameLocal = GeneratedColumn<String>(
      'name_local', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
      'lon', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<CitySource, int> source =
      GeneratedColumn<int>('source', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CitySource>($CitiesTable.$convertersource);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, countryCode, name, nameLocal, lat, lon, timezone, source, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cities';
  @override
  VerificationContext validateIntegrity(Insertable<City> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_local')) {
      context.handle(_nameLocalMeta,
          nameLocal.isAcceptableOrUnknown(data['name_local']!, _nameLocalMeta));
    }
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
          _lonMeta, lon.isAcceptableOrUnknown(data['lon']!, _lonMeta));
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  City map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return City(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      nameLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_local']),
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      lon: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lon'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      source: $CitiesTable.$convertersource.fromSql(attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}source'])!),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CitiesTable createAlias(String alias) {
    return $CitiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CitySource, int, int> $convertersource =
      const EnumIndexConverter<CitySource>(CitySource.values);
}

class City extends DataClass implements Insertable<City> {
  final String id;
  final String countryCode;
  final String name;
  final String? nameLocal;
  final double lat;
  final double lon;
  final String timezone;
  final CitySource source;
  final DateTime updatedAt;
  const City(
      {required this.id,
      required this.countryCode,
      required this.name,
      this.nameLocal,
      required this.lat,
      required this.lon,
      required this.timezone,
      required this.source,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['country_code'] = Variable<String>(countryCode);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameLocal != null) {
      map['name_local'] = Variable<String>(nameLocal);
    }
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['timezone'] = Variable<String>(timezone);
    {
      map['source'] =
          Variable<int>($CitiesTable.$convertersource.toSql(source));
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CitiesCompanion toCompanion(bool nullToAbsent) {
    return CitiesCompanion(
      id: Value(id),
      countryCode: Value(countryCode),
      name: Value(name),
      nameLocal: nameLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(nameLocal),
      lat: Value(lat),
      lon: Value(lon),
      timezone: Value(timezone),
      source: Value(source),
      updatedAt: Value(updatedAt),
    );
  }

  factory City.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return City(
      id: serializer.fromJson<String>(json['id']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      name: serializer.fromJson<String>(json['name']),
      nameLocal: serializer.fromJson<String?>(json['nameLocal']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      timezone: serializer.fromJson<String>(json['timezone']),
      source: $CitiesTable.$convertersource
          .fromJson(serializer.fromJson<int>(json['source'])),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'countryCode': serializer.toJson<String>(countryCode),
      'name': serializer.toJson<String>(name),
      'nameLocal': serializer.toJson<String?>(nameLocal),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'timezone': serializer.toJson<String>(timezone),
      'source':
          serializer.toJson<int>($CitiesTable.$convertersource.toJson(source)),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  City copyWith(
          {String? id,
          String? countryCode,
          String? name,
          Value<String?> nameLocal = const Value.absent(),
          double? lat,
          double? lon,
          String? timezone,
          CitySource? source,
          DateTime? updatedAt}) =>
      City(
        id: id ?? this.id,
        countryCode: countryCode ?? this.countryCode,
        name: name ?? this.name,
        nameLocal: nameLocal.present ? nameLocal.value : this.nameLocal,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
        timezone: timezone ?? this.timezone,
        source: source ?? this.source,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  City copyWithCompanion(CitiesCompanion data) {
    return City(
      id: data.id.present ? data.id.value : this.id,
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      name: data.name.present ? data.name.value : this.name,
      nameLocal: data.nameLocal.present ? data.nameLocal.value : this.nameLocal,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      source: data.source.present ? data.source.value : this.source,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('City(')
          ..write('id: $id, ')
          ..write('countryCode: $countryCode, ')
          ..write('name: $name, ')
          ..write('nameLocal: $nameLocal, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('timezone: $timezone, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, countryCode, name, nameLocal, lat, lon, timezone, source, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is City &&
          other.id == this.id &&
          other.countryCode == this.countryCode &&
          other.name == this.name &&
          other.nameLocal == this.nameLocal &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.timezone == this.timezone &&
          other.source == this.source &&
          other.updatedAt == this.updatedAt);
}

class CitiesCompanion extends UpdateCompanion<City> {
  final Value<String> id;
  final Value<String> countryCode;
  final Value<String> name;
  final Value<String?> nameLocal;
  final Value<double> lat;
  final Value<double> lon;
  final Value<String> timezone;
  final Value<CitySource> source;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CitiesCompanion({
    this.id = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.name = const Value.absent(),
    this.nameLocal = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.timezone = const Value.absent(),
    this.source = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CitiesCompanion.insert({
    required String id,
    required String countryCode,
    required String name,
    this.nameLocal = const Value.absent(),
    required double lat,
    required double lon,
    required String timezone,
    required CitySource source,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        countryCode = Value(countryCode),
        name = Value(name),
        lat = Value(lat),
        lon = Value(lon),
        timezone = Value(timezone),
        source = Value(source),
        updatedAt = Value(updatedAt);
  static Insertable<City> custom({
    Expression<String>? id,
    Expression<String>? countryCode,
    Expression<String>? name,
    Expression<String>? nameLocal,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? timezone,
    Expression<int>? source,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countryCode != null) 'country_code': countryCode,
      if (name != null) 'name': name,
      if (nameLocal != null) 'name_local': nameLocal,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (timezone != null) 'timezone': timezone,
      if (source != null) 'source': source,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CitiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? countryCode,
      Value<String>? name,
      Value<String?>? nameLocal,
      Value<double>? lat,
      Value<double>? lon,
      Value<String>? timezone,
      Value<CitySource>? source,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CitiesCompanion(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      name: name ?? this.name,
      nameLocal: nameLocal ?? this.nameLocal,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezone: timezone ?? this.timezone,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameLocal.present) {
      map['name_local'] = Variable<String>(nameLocal.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (source.present) {
      map['source'] =
          Variable<int>($CitiesTable.$convertersource.toSql(source.value));
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CitiesCompanion(')
          ..write('id: $id, ')
          ..write('countryCode: $countryCode, ')
          ..write('name: $name, ')
          ..write('nameLocal: $nameLocal, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('timezone: $timezone, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileCityTable extends ProfileCity
    with TableInfo<$ProfileCityTable, ProfileCityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileCityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  @override
  late final GeneratedColumn<String> cityId = GeneratedColumn<String>(
      'city_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPrimaryMeta =
      const VerificationMeta('isPrimary');
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
      'is_primary', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_primary" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _overridesJsonMeta =
      const VerificationMeta('overridesJson');
  @override
  late final GeneratedColumn<String> overridesJson = GeneratedColumn<String>(
      'overrides_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  @override
  List<GeneratedColumn> get $columns =>
      [profileId, cityId, isPrimary, overridesJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_city';
  @override
  VerificationContext validateIntegrity(Insertable<ProfileCityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('city_id')) {
      context.handle(_cityIdMeta,
          cityId.isAcceptableOrUnknown(data['city_id']!, _cityIdMeta));
    } else if (isInserting) {
      context.missing(_cityIdMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(_isPrimaryMeta,
          isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta));
    }
    if (data.containsKey('overrides_json')) {
      context.handle(
          _overridesJsonMeta,
          overridesJson.isAcceptableOrUnknown(
              data['overrides_json']!, _overridesJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, cityId};
  @override
  ProfileCityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileCityData(
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      cityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city_id'])!,
      isPrimary: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_primary'])!,
      overridesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overrides_json'])!,
    );
  }

  @override
  $ProfileCityTable createAlias(String alias) {
    return $ProfileCityTable(attachedDatabase, alias);
  }
}

class ProfileCityData extends DataClass implements Insertable<ProfileCityData> {
  final String profileId;
  final String cityId;
  final bool isPrimary;
  final String overridesJson;
  const ProfileCityData(
      {required this.profileId,
      required this.cityId,
      required this.isPrimary,
      required this.overridesJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['city_id'] = Variable<String>(cityId);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['overrides_json'] = Variable<String>(overridesJson);
    return map;
  }

  ProfileCityCompanion toCompanion(bool nullToAbsent) {
    return ProfileCityCompanion(
      profileId: Value(profileId),
      cityId: Value(cityId),
      isPrimary: Value(isPrimary),
      overridesJson: Value(overridesJson),
    );
  }

  factory ProfileCityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileCityData(
      profileId: serializer.fromJson<String>(json['profileId']),
      cityId: serializer.fromJson<String>(json['cityId']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      overridesJson: serializer.fromJson<String>(json['overridesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'cityId': serializer.toJson<String>(cityId),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'overridesJson': serializer.toJson<String>(overridesJson),
    };
  }

  ProfileCityData copyWith(
          {String? profileId,
          String? cityId,
          bool? isPrimary,
          String? overridesJson}) =>
      ProfileCityData(
        profileId: profileId ?? this.profileId,
        cityId: cityId ?? this.cityId,
        isPrimary: isPrimary ?? this.isPrimary,
        overridesJson: overridesJson ?? this.overridesJson,
      );
  ProfileCityData copyWithCompanion(ProfileCityCompanion data) {
    return ProfileCityData(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      cityId: data.cityId.present ? data.cityId.value : this.cityId,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      overridesJson: data.overridesJson.present
          ? data.overridesJson.value
          : this.overridesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileCityData(')
          ..write('profileId: $profileId, ')
          ..write('cityId: $cityId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('overridesJson: $overridesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, cityId, isPrimary, overridesJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileCityData &&
          other.profileId == this.profileId &&
          other.cityId == this.cityId &&
          other.isPrimary == this.isPrimary &&
          other.overridesJson == this.overridesJson);
}

class ProfileCityCompanion extends UpdateCompanion<ProfileCityData> {
  final Value<String> profileId;
  final Value<String> cityId;
  final Value<bool> isPrimary;
  final Value<String> overridesJson;
  final Value<int> rowid;
  const ProfileCityCompanion({
    this.profileId = const Value.absent(),
    this.cityId = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.overridesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfileCityCompanion.insert({
    required String profileId,
    required String cityId,
    this.isPrimary = const Value.absent(),
    this.overridesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : profileId = Value(profileId),
        cityId = Value(cityId);
  static Insertable<ProfileCityData> custom({
    Expression<String>? profileId,
    Expression<String>? cityId,
    Expression<bool>? isPrimary,
    Expression<String>? overridesJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (cityId != null) 'city_id': cityId,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (overridesJson != null) 'overrides_json': overridesJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfileCityCompanion copyWith(
      {Value<String>? profileId,
      Value<String>? cityId,
      Value<bool>? isPrimary,
      Value<String>? overridesJson,
      Value<int>? rowid}) {
    return ProfileCityCompanion(
      profileId: profileId ?? this.profileId,
      cityId: cityId ?? this.cityId,
      isPrimary: isPrimary ?? this.isPrimary,
      overridesJson: overridesJson ?? this.overridesJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (cityId.present) {
      map['city_id'] = Variable<String>(cityId.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (overridesJson.present) {
      map['overrides_json'] = Variable<String>(overridesJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileCityCompanion(')
          ..write('profileId: $profileId, ')
          ..write('cityId: $cityId, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('overridesJson: $overridesJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedEventsTable extends CachedEvents
    with TableInfo<$CachedEventsTable, CachedEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _layerIdMeta =
      const VerificationMeta('layerId');
  @override
  late final GeneratedColumn<String> layerId = GeneratedColumn<String>(
      'layer_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
      'all_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("all_day" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _startTimeMeta =
      const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<String> startTime = GeneratedColumn<String>(
      'start_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _endTimeMeta =
      const VerificationMeta('endTime');
  @override
  late final GeneratedColumn<String> endTime = GeneratedColumn<String>(
      'end_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceKeyMeta =
      const VerificationMeta('sourceKey');
  @override
  late final GeneratedColumn<String> sourceKey = GeneratedColumn<String>(
      'source_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _importanceMeta =
      const VerificationMeta('importance');
  @override
  late final GeneratedColumn<int> importance = GeneratedColumn<int>(
      'importance', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        profileId,
        layerId,
        date,
        title,
        details,
        allDay,
        startTime,
        endTime,
        sourceKey,
        importance,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_events';
  @override
  VerificationContext validateIntegrity(Insertable<CachedEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('layer_id')) {
      context.handle(_layerIdMeta,
          layerId.isAcceptableOrUnknown(data['layer_id']!, _layerIdMeta));
    } else if (isInserting) {
      context.missing(_layerIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    if (data.containsKey('all_day')) {
      context.handle(_allDayMeta,
          allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta));
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta));
    }
    if (data.containsKey('source_key')) {
      context.handle(_sourceKeyMeta,
          sourceKey.isAcceptableOrUnknown(data['source_key']!, _sourceKeyMeta));
    } else if (isInserting) {
      context.missing(_sourceKeyMeta);
    }
    if (data.containsKey('importance')) {
      context.handle(
          _importanceMeta,
          importance.isAcceptableOrUnknown(
              data['importance']!, _importanceMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, layerId, date, sourceKey};
  @override
  CachedEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedEvent(
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      layerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}layer_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details'])!,
      allDay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}all_day'])!,
      startTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}start_time']),
      endTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}end_time']),
      sourceKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_key'])!,
      importance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}importance'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CachedEventsTable createAlias(String alias) {
    return $CachedEventsTable(attachedDatabase, alias);
  }
}

class CachedEvent extends DataClass implements Insertable<CachedEvent> {
  final String profileId;
  final String layerId;
  final String date;
  final String title;
  final String details;
  final bool allDay;
  final String? startTime;
  final String? endTime;
  final String sourceKey;
  final int importance;
  final DateTime updatedAt;
  const CachedEvent(
      {required this.profileId,
      required this.layerId,
      required this.date,
      required this.title,
      required this.details,
      required this.allDay,
      this.startTime,
      this.endTime,
      required this.sourceKey,
      required this.importance,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['layer_id'] = Variable<String>(layerId);
    map['date'] = Variable<String>(date);
    map['title'] = Variable<String>(title);
    map['details'] = Variable<String>(details);
    map['all_day'] = Variable<bool>(allDay);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<String>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<String>(endTime);
    }
    map['source_key'] = Variable<String>(sourceKey);
    map['importance'] = Variable<int>(importance);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedEventsCompanion toCompanion(bool nullToAbsent) {
    return CachedEventsCompanion(
      profileId: Value(profileId),
      layerId: Value(layerId),
      date: Value(date),
      title: Value(title),
      details: Value(details),
      allDay: Value(allDay),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      sourceKey: Value(sourceKey),
      importance: Value(importance),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedEvent(
      profileId: serializer.fromJson<String>(json['profileId']),
      layerId: serializer.fromJson<String>(json['layerId']),
      date: serializer.fromJson<String>(json['date']),
      title: serializer.fromJson<String>(json['title']),
      details: serializer.fromJson<String>(json['details']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      startTime: serializer.fromJson<String?>(json['startTime']),
      endTime: serializer.fromJson<String?>(json['endTime']),
      sourceKey: serializer.fromJson<String>(json['sourceKey']),
      importance: serializer.fromJson<int>(json['importance']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'layerId': serializer.toJson<String>(layerId),
      'date': serializer.toJson<String>(date),
      'title': serializer.toJson<String>(title),
      'details': serializer.toJson<String>(details),
      'allDay': serializer.toJson<bool>(allDay),
      'startTime': serializer.toJson<String?>(startTime),
      'endTime': serializer.toJson<String?>(endTime),
      'sourceKey': serializer.toJson<String>(sourceKey),
      'importance': serializer.toJson<int>(importance),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedEvent copyWith(
          {String? profileId,
          String? layerId,
          String? date,
          String? title,
          String? details,
          bool? allDay,
          Value<String?> startTime = const Value.absent(),
          Value<String?> endTime = const Value.absent(),
          String? sourceKey,
          int? importance,
          DateTime? updatedAt}) =>
      CachedEvent(
        profileId: profileId ?? this.profileId,
        layerId: layerId ?? this.layerId,
        date: date ?? this.date,
        title: title ?? this.title,
        details: details ?? this.details,
        allDay: allDay ?? this.allDay,
        startTime: startTime.present ? startTime.value : this.startTime,
        endTime: endTime.present ? endTime.value : this.endTime,
        sourceKey: sourceKey ?? this.sourceKey,
        importance: importance ?? this.importance,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CachedEvent copyWithCompanion(CachedEventsCompanion data) {
    return CachedEvent(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      layerId: data.layerId.present ? data.layerId.value : this.layerId,
      date: data.date.present ? data.date.value : this.date,
      title: data.title.present ? data.title.value : this.title,
      details: data.details.present ? data.details.value : this.details,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      sourceKey: data.sourceKey.present ? data.sourceKey.value : this.sourceKey,
      importance:
          data.importance.present ? data.importance.value : this.importance,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedEvent(')
          ..write('profileId: $profileId, ')
          ..write('layerId: $layerId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('details: $details, ')
          ..write('allDay: $allDay, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('importance: $importance, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, layerId, date, title, details,
      allDay, startTime, endTime, sourceKey, importance, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedEvent &&
          other.profileId == this.profileId &&
          other.layerId == this.layerId &&
          other.date == this.date &&
          other.title == this.title &&
          other.details == this.details &&
          other.allDay == this.allDay &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.sourceKey == this.sourceKey &&
          other.importance == this.importance &&
          other.updatedAt == this.updatedAt);
}

class CachedEventsCompanion extends UpdateCompanion<CachedEvent> {
  final Value<String> profileId;
  final Value<String> layerId;
  final Value<String> date;
  final Value<String> title;
  final Value<String> details;
  final Value<bool> allDay;
  final Value<String?> startTime;
  final Value<String?> endTime;
  final Value<String> sourceKey;
  final Value<int> importance;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CachedEventsCompanion({
    this.profileId = const Value.absent(),
    this.layerId = const Value.absent(),
    this.date = const Value.absent(),
    this.title = const Value.absent(),
    this.details = const Value.absent(),
    this.allDay = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.sourceKey = const Value.absent(),
    this.importance = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedEventsCompanion.insert({
    required String profileId,
    required String layerId,
    required String date,
    required String title,
    this.details = const Value.absent(),
    this.allDay = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    required String sourceKey,
    this.importance = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : profileId = Value(profileId),
        layerId = Value(layerId),
        date = Value(date),
        title = Value(title),
        sourceKey = Value(sourceKey),
        updatedAt = Value(updatedAt);
  static Insertable<CachedEvent> custom({
    Expression<String>? profileId,
    Expression<String>? layerId,
    Expression<String>? date,
    Expression<String>? title,
    Expression<String>? details,
    Expression<bool>? allDay,
    Expression<String>? startTime,
    Expression<String>? endTime,
    Expression<String>? sourceKey,
    Expression<int>? importance,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (layerId != null) 'layer_id': layerId,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (details != null) 'details': details,
      if (allDay != null) 'all_day': allDay,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (sourceKey != null) 'source_key': sourceKey,
      if (importance != null) 'importance': importance,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedEventsCompanion copyWith(
      {Value<String>? profileId,
      Value<String>? layerId,
      Value<String>? date,
      Value<String>? title,
      Value<String>? details,
      Value<bool>? allDay,
      Value<String?>? startTime,
      Value<String?>? endTime,
      Value<String>? sourceKey,
      Value<int>? importance,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CachedEventsCompanion(
      profileId: profileId ?? this.profileId,
      layerId: layerId ?? this.layerId,
      date: date ?? this.date,
      title: title ?? this.title,
      details: details ?? this.details,
      allDay: allDay ?? this.allDay,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      sourceKey: sourceKey ?? this.sourceKey,
      importance: importance ?? this.importance,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (layerId.present) {
      map['layer_id'] = Variable<String>(layerId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<String>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<String>(endTime.value);
    }
    if (sourceKey.present) {
      map['source_key'] = Variable<String>(sourceKey.value);
    }
    if (importance.present) {
      map['importance'] = Variable<int>(importance.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedEventsCompanion(')
          ..write('profileId: $profileId, ')
          ..write('layerId: $layerId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('details: $details, ')
          ..write('allDay: $allDay, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('sourceKey: $sourceKey, ')
          ..write('importance: $importance, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomZmanimDatasetTable extends CustomZmanimDataset
    with TableInfo<$CustomZmanimDatasetTable, CustomZmanimDatasetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomZmanimDatasetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _zmanimJsonMeta =
      const VerificationMeta('zmanimJson');
  @override
  late final GeneratedColumn<String> zmanimJson = GeneratedColumn<String>(
      'zmanim_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [profileId, date, zmanimJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_zmanim_dataset';
  @override
  VerificationContext validateIntegrity(
      Insertable<CustomZmanimDatasetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('zmanim_json')) {
      context.handle(
          _zmanimJsonMeta,
          zmanimJson.isAcceptableOrUnknown(
              data['zmanim_json']!, _zmanimJsonMeta));
    } else if (isInserting) {
      context.missing(_zmanimJsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {profileId, date};
  @override
  CustomZmanimDatasetData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomZmanimDatasetData(
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      zmanimJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}zmanim_json'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CustomZmanimDatasetTable createAlias(String alias) {
    return $CustomZmanimDatasetTable(attachedDatabase, alias);
  }
}

class CustomZmanimDatasetData extends DataClass
    implements Insertable<CustomZmanimDatasetData> {
  final String profileId;
  final String date;
  final String zmanimJson;
  final DateTime updatedAt;
  const CustomZmanimDatasetData(
      {required this.profileId,
      required this.date,
      required this.zmanimJson,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['profile_id'] = Variable<String>(profileId);
    map['date'] = Variable<String>(date);
    map['zmanim_json'] = Variable<String>(zmanimJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomZmanimDatasetCompanion toCompanion(bool nullToAbsent) {
    return CustomZmanimDatasetCompanion(
      profileId: Value(profileId),
      date: Value(date),
      zmanimJson: Value(zmanimJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomZmanimDatasetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomZmanimDatasetData(
      profileId: serializer.fromJson<String>(json['profileId']),
      date: serializer.fromJson<String>(json['date']),
      zmanimJson: serializer.fromJson<String>(json['zmanimJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'profileId': serializer.toJson<String>(profileId),
      'date': serializer.toJson<String>(date),
      'zmanimJson': serializer.toJson<String>(zmanimJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomZmanimDatasetData copyWith(
          {String? profileId,
          String? date,
          String? zmanimJson,
          DateTime? updatedAt}) =>
      CustomZmanimDatasetData(
        profileId: profileId ?? this.profileId,
        date: date ?? this.date,
        zmanimJson: zmanimJson ?? this.zmanimJson,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CustomZmanimDatasetData copyWithCompanion(CustomZmanimDatasetCompanion data) {
    return CustomZmanimDatasetData(
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      date: data.date.present ? data.date.value : this.date,
      zmanimJson:
          data.zmanimJson.present ? data.zmanimJson.value : this.zmanimJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomZmanimDatasetData(')
          ..write('profileId: $profileId, ')
          ..write('date: $date, ')
          ..write('zmanimJson: $zmanimJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(profileId, date, zmanimJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomZmanimDatasetData &&
          other.profileId == this.profileId &&
          other.date == this.date &&
          other.zmanimJson == this.zmanimJson &&
          other.updatedAt == this.updatedAt);
}

class CustomZmanimDatasetCompanion
    extends UpdateCompanion<CustomZmanimDatasetData> {
  final Value<String> profileId;
  final Value<String> date;
  final Value<String> zmanimJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomZmanimDatasetCompanion({
    this.profileId = const Value.absent(),
    this.date = const Value.absent(),
    this.zmanimJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomZmanimDatasetCompanion.insert({
    required String profileId,
    required String date,
    required String zmanimJson,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : profileId = Value(profileId),
        date = Value(date),
        zmanimJson = Value(zmanimJson),
        updatedAt = Value(updatedAt);
  static Insertable<CustomZmanimDatasetData> custom({
    Expression<String>? profileId,
    Expression<String>? date,
    Expression<String>? zmanimJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (profileId != null) 'profile_id': profileId,
      if (date != null) 'date': date,
      if (zmanimJson != null) 'zmanim_json': zmanimJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomZmanimDatasetCompanion copyWith(
      {Value<String>? profileId,
      Value<String>? date,
      Value<String>? zmanimJson,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CustomZmanimDatasetCompanion(
      profileId: profileId ?? this.profileId,
      date: date ?? this.date,
      zmanimJson: zmanimJson ?? this.zmanimJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (zmanimJson.present) {
      map['zmanim_json'] = Variable<String>(zmanimJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomZmanimDatasetCompanion(')
          ..write('profileId: $profileId, ')
          ..write('date: $date, ')
          ..write('zmanimJson: $zmanimJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $LayersTable layers = $LayersTable(this);
  late final $ProfileLayersTable profileLayers = $ProfileLayersTable(this);
  late final $MethodsConfigTable methodsConfig = $MethodsConfigTable(this);
  late final $CitiesTable cities = $CitiesTable(this);
  late final $ProfileCityTable profileCity = $ProfileCityTable(this);
  late final $CachedEventsTable cachedEvents = $CachedEventsTable(this);
  late final $CustomZmanimDatasetTable customZmanimDataset =
      $CustomZmanimDatasetTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        profiles,
        layers,
        profileLayers,
        methodsConfig,
        cities,
        profileCity,
        cachedEvents,
        customZmanimDataset
      ];
}

typedef $$ProfilesTableCreateCompanionBuilder = ProfilesCompanion Function({
  required String id,
  required String name,
  required String countryCode,
  required String timezone,
  required double lat,
  required double lon,
  Value<double?> elevation,
  Value<bool> isDefault,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ProfilesTableUpdateCompanionBuilder = ProfilesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> countryCode,
  Value<String> timezone,
  Value<double> lat,
  Value<double> lon,
  Value<double?> elevation,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lon => $composableBuilder(
      column: $table.lon, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get elevation => $composableBuilder(
      column: $table.elevation, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lon => $composableBuilder(
      column: $table.lon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get elevation => $composableBuilder(
      column: $table.elevation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get elevation =>
      $composableBuilder(column: $table.elevation, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()> {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> countryCode = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<double> lat = const Value.absent(),
            Value<double> lon = const Value.absent(),
            Value<double?> elevation = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion(
            id: id,
            name: name,
            countryCode: countryCode,
            timezone: timezone,
            lat: lat,
            lon: lon,
            elevation: elevation,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String countryCode,
            required String timezone,
            required double lat,
            required double lon,
            Value<double?> elevation = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfilesCompanion.insert(
            id: id,
            name: name,
            countryCode: countryCode,
            timezone: timezone,
            lat: lat,
            lon: lon,
            elevation: elevation,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfilesTable,
    Profile,
    $$ProfilesTableFilterComposer,
    $$ProfilesTableOrderingComposer,
    $$ProfilesTableAnnotationComposer,
    $$ProfilesTableCreateCompanionBuilder,
    $$ProfilesTableUpdateCompanionBuilder,
    (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
    Profile,
    PrefetchHooks Function()>;
typedef $$LayersTableCreateCompanionBuilder = LayersCompanion Function({
  required String id,
  required LayerType type,
  Value<String> variant,
  required String displayName,
  required int color,
  Value<bool> enabledByDefault,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$LayersTableUpdateCompanionBuilder = LayersCompanion Function({
  Value<String> id,
  Value<LayerType> type,
  Value<String> variant,
  Value<String> displayName,
  Value<int> color,
  Value<bool> enabledByDefault,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$LayersTableFilterComposer
    extends Composer<_$AppDatabase, $LayersTable> {
  $$LayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LayerType, LayerType, int> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get variant => $composableBuilder(
      column: $table.variant, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabledByDefault => $composableBuilder(
      column: $table.enabledByDefault,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$LayersTableOrderingComposer
    extends Composer<_$AppDatabase, $LayersTable> {
  $$LayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variant => $composableBuilder(
      column: $table.variant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabledByDefault => $composableBuilder(
      column: $table.enabledByDefault,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$LayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LayersTable> {
  $$LayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LayerType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get enabledByDefault => $composableBuilder(
      column: $table.enabledByDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LayersTable,
    Layer,
    $$LayersTableFilterComposer,
    $$LayersTableOrderingComposer,
    $$LayersTableAnnotationComposer,
    $$LayersTableCreateCompanionBuilder,
    $$LayersTableUpdateCompanionBuilder,
    (Layer, BaseReferences<_$AppDatabase, $LayersTable, Layer>),
    Layer,
    PrefetchHooks Function()> {
  $$LayersTableTableManager(_$AppDatabase db, $LayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<LayerType> type = const Value.absent(),
            Value<String> variant = const Value.absent(),
            Value<String> displayName = const Value.absent(),
            Value<int> color = const Value.absent(),
            Value<bool> enabledByDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LayersCompanion(
            id: id,
            type: type,
            variant: variant,
            displayName: displayName,
            color: color,
            enabledByDefault: enabledByDefault,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required LayerType type,
            Value<String> variant = const Value.absent(),
            required String displayName,
            required int color,
            Value<bool> enabledByDefault = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LayersCompanion.insert(
            id: id,
            type: type,
            variant: variant,
            displayName: displayName,
            color: color,
            enabledByDefault: enabledByDefault,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LayersTable,
    Layer,
    $$LayersTableFilterComposer,
    $$LayersTableOrderingComposer,
    $$LayersTableAnnotationComposer,
    $$LayersTableCreateCompanionBuilder,
    $$LayersTableUpdateCompanionBuilder,
    (Layer, BaseReferences<_$AppDatabase, $LayersTable, Layer>),
    Layer,
    PrefetchHooks Function()>;
typedef $$ProfileLayersTableCreateCompanionBuilder = ProfileLayersCompanion
    Function({
  required String profileId,
  required String layerId,
  Value<bool> isEnabled,
  Value<String> visibilityRuleJson,
  Value<String> notificationPolicyJson,
  Value<int> rowid,
});
typedef $$ProfileLayersTableUpdateCompanionBuilder = ProfileLayersCompanion
    Function({
  Value<String> profileId,
  Value<String> layerId,
  Value<bool> isEnabled,
  Value<String> visibilityRuleJson,
  Value<String> notificationPolicyJson,
  Value<int> rowid,
});

class $$ProfileLayersTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileLayersTable> {
  $$ProfileLayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get layerId => $composableBuilder(
      column: $table.layerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visibilityRuleJson => $composableBuilder(
      column: $table.visibilityRuleJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notificationPolicyJson => $composableBuilder(
      column: $table.notificationPolicyJson,
      builder: (column) => ColumnFilters(column));
}

class $$ProfileLayersTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileLayersTable> {
  $$ProfileLayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get layerId => $composableBuilder(
      column: $table.layerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visibilityRuleJson => $composableBuilder(
      column: $table.visibilityRuleJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notificationPolicyJson => $composableBuilder(
      column: $table.notificationPolicyJson,
      builder: (column) => ColumnOrderings(column));
}

class $$ProfileLayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileLayersTable> {
  $$ProfileLayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get layerId =>
      $composableBuilder(column: $table.layerId, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get visibilityRuleJson => $composableBuilder(
      column: $table.visibilityRuleJson, builder: (column) => column);

  GeneratedColumn<String> get notificationPolicyJson => $composableBuilder(
      column: $table.notificationPolicyJson, builder: (column) => column);
}

class $$ProfileLayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfileLayersTable,
    ProfileLayer,
    $$ProfileLayersTableFilterComposer,
    $$ProfileLayersTableOrderingComposer,
    $$ProfileLayersTableAnnotationComposer,
    $$ProfileLayersTableCreateCompanionBuilder,
    $$ProfileLayersTableUpdateCompanionBuilder,
    (
      ProfileLayer,
      BaseReferences<_$AppDatabase, $ProfileLayersTable, ProfileLayer>
    ),
    ProfileLayer,
    PrefetchHooks Function()> {
  $$ProfileLayersTableTableManager(_$AppDatabase db, $ProfileLayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileLayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileLayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileLayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> profileId = const Value.absent(),
            Value<String> layerId = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<String> visibilityRuleJson = const Value.absent(),
            Value<String> notificationPolicyJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileLayersCompanion(
            profileId: profileId,
            layerId: layerId,
            isEnabled: isEnabled,
            visibilityRuleJson: visibilityRuleJson,
            notificationPolicyJson: notificationPolicyJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String profileId,
            required String layerId,
            Value<bool> isEnabled = const Value.absent(),
            Value<String> visibilityRuleJson = const Value.absent(),
            Value<String> notificationPolicyJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileLayersCompanion.insert(
            profileId: profileId,
            layerId: layerId,
            isEnabled: isEnabled,
            visibilityRuleJson: visibilityRuleJson,
            notificationPolicyJson: notificationPolicyJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfileLayersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfileLayersTable,
    ProfileLayer,
    $$ProfileLayersTableFilterComposer,
    $$ProfileLayersTableOrderingComposer,
    $$ProfileLayersTableAnnotationComposer,
    $$ProfileLayersTableCreateCompanionBuilder,
    $$ProfileLayersTableUpdateCompanionBuilder,
    (
      ProfileLayer,
      BaseReferences<_$AppDatabase, $ProfileLayersTable, ProfileLayer>
    ),
    ProfileLayer,
    PrefetchHooks Function()>;
typedef $$MethodsConfigTableCreateCompanionBuilder = MethodsConfigCompanion
    Function({
  required String profileId,
  Value<JewishMethod> jewishMethod,
  Value<IslamicMethod> islamicMethod,
  Value<AsrMethod> asrMethod,
  Value<HighLatRule> highLatRule,
  Value<String> customParamsJson,
  Value<int> rowid,
});
typedef $$MethodsConfigTableUpdateCompanionBuilder = MethodsConfigCompanion
    Function({
  Value<String> profileId,
  Value<JewishMethod> jewishMethod,
  Value<IslamicMethod> islamicMethod,
  Value<AsrMethod> asrMethod,
  Value<HighLatRule> highLatRule,
  Value<String> customParamsJson,
  Value<int> rowid,
});

class $$MethodsConfigTableFilterComposer
    extends Composer<_$AppDatabase, $MethodsConfigTable> {
  $$MethodsConfigTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<JewishMethod, JewishMethod, int>
      get jewishMethod => $composableBuilder(
          column: $table.jewishMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<IslamicMethod, IslamicMethod, int>
      get islamicMethod => $composableBuilder(
          column: $table.islamicMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<AsrMethod, AsrMethod, int> get asrMethod =>
      $composableBuilder(
          column: $table.asrMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<HighLatRule, HighLatRule, int>
      get highLatRule => $composableBuilder(
          column: $table.highLatRule,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get customParamsJson => $composableBuilder(
      column: $table.customParamsJson,
      builder: (column) => ColumnFilters(column));
}

class $$MethodsConfigTableOrderingComposer
    extends Composer<_$AppDatabase, $MethodsConfigTable> {
  $$MethodsConfigTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jewishMethod => $composableBuilder(
      column: $table.jewishMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get islamicMethod => $composableBuilder(
      column: $table.islamicMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get asrMethod => $composableBuilder(
      column: $table.asrMethod, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get highLatRule => $composableBuilder(
      column: $table.highLatRule, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customParamsJson => $composableBuilder(
      column: $table.customParamsJson,
      builder: (column) => ColumnOrderings(column));
}

class $$MethodsConfigTableAnnotationComposer
    extends Composer<_$AppDatabase, $MethodsConfigTable> {
  $$MethodsConfigTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JewishMethod, int> get jewishMethod =>
      $composableBuilder(
          column: $table.jewishMethod, builder: (column) => column);

  GeneratedColumnWithTypeConverter<IslamicMethod, int> get islamicMethod =>
      $composableBuilder(
          column: $table.islamicMethod, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AsrMethod, int> get asrMethod =>
      $composableBuilder(column: $table.asrMethod, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HighLatRule, int> get highLatRule =>
      $composableBuilder(
          column: $table.highLatRule, builder: (column) => column);

  GeneratedColumn<String> get customParamsJson => $composableBuilder(
      column: $table.customParamsJson, builder: (column) => column);
}

class $$MethodsConfigTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MethodsConfigTable,
    MethodsConfigData,
    $$MethodsConfigTableFilterComposer,
    $$MethodsConfigTableOrderingComposer,
    $$MethodsConfigTableAnnotationComposer,
    $$MethodsConfigTableCreateCompanionBuilder,
    $$MethodsConfigTableUpdateCompanionBuilder,
    (
      MethodsConfigData,
      BaseReferences<_$AppDatabase, $MethodsConfigTable, MethodsConfigData>
    ),
    MethodsConfigData,
    PrefetchHooks Function()> {
  $$MethodsConfigTableTableManager(_$AppDatabase db, $MethodsConfigTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MethodsConfigTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MethodsConfigTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MethodsConfigTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> profileId = const Value.absent(),
            Value<JewishMethod> jewishMethod = const Value.absent(),
            Value<IslamicMethod> islamicMethod = const Value.absent(),
            Value<AsrMethod> asrMethod = const Value.absent(),
            Value<HighLatRule> highLatRule = const Value.absent(),
            Value<String> customParamsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MethodsConfigCompanion(
            profileId: profileId,
            jewishMethod: jewishMethod,
            islamicMethod: islamicMethod,
            asrMethod: asrMethod,
            highLatRule: highLatRule,
            customParamsJson: customParamsJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String profileId,
            Value<JewishMethod> jewishMethod = const Value.absent(),
            Value<IslamicMethod> islamicMethod = const Value.absent(),
            Value<AsrMethod> asrMethod = const Value.absent(),
            Value<HighLatRule> highLatRule = const Value.absent(),
            Value<String> customParamsJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MethodsConfigCompanion.insert(
            profileId: profileId,
            jewishMethod: jewishMethod,
            islamicMethod: islamicMethod,
            asrMethod: asrMethod,
            highLatRule: highLatRule,
            customParamsJson: customParamsJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MethodsConfigTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MethodsConfigTable,
    MethodsConfigData,
    $$MethodsConfigTableFilterComposer,
    $$MethodsConfigTableOrderingComposer,
    $$MethodsConfigTableAnnotationComposer,
    $$MethodsConfigTableCreateCompanionBuilder,
    $$MethodsConfigTableUpdateCompanionBuilder,
    (
      MethodsConfigData,
      BaseReferences<_$AppDatabase, $MethodsConfigTable, MethodsConfigData>
    ),
    MethodsConfigData,
    PrefetchHooks Function()>;
typedef $$CitiesTableCreateCompanionBuilder = CitiesCompanion Function({
  required String id,
  required String countryCode,
  required String name,
  Value<String?> nameLocal,
  required double lat,
  required double lon,
  required String timezone,
  required CitySource source,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CitiesTableUpdateCompanionBuilder = CitiesCompanion Function({
  Value<String> id,
  Value<String> countryCode,
  Value<String> name,
  Value<String?> nameLocal,
  Value<double> lat,
  Value<double> lon,
  Value<String> timezone,
  Value<CitySource> source,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameLocal => $composableBuilder(
      column: $table.nameLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get lon => $composableBuilder(
      column: $table.lon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CitySource, CitySource, int> get source =>
      $composableBuilder(
          column: $table.source,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameLocal => $composableBuilder(
      column: $table.nameLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lat => $composableBuilder(
      column: $table.lat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get lon => $composableBuilder(
      column: $table.lon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameLocal =>
      $composableBuilder(column: $table.nameLocal, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CitySource, int> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CitiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CitiesTable,
    City,
    $$CitiesTableFilterComposer,
    $$CitiesTableOrderingComposer,
    $$CitiesTableAnnotationComposer,
    $$CitiesTableCreateCompanionBuilder,
    $$CitiesTableUpdateCompanionBuilder,
    (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
    City,
    PrefetchHooks Function()> {
  $$CitiesTableTableManager(_$AppDatabase db, $CitiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> countryCode = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> nameLocal = const Value.absent(),
            Value<double> lat = const Value.absent(),
            Value<double> lon = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<CitySource> source = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CitiesCompanion(
            id: id,
            countryCode: countryCode,
            name: name,
            nameLocal: nameLocal,
            lat: lat,
            lon: lon,
            timezone: timezone,
            source: source,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String countryCode,
            required String name,
            Value<String?> nameLocal = const Value.absent(),
            required double lat,
            required double lon,
            required String timezone,
            required CitySource source,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CitiesCompanion.insert(
            id: id,
            countryCode: countryCode,
            name: name,
            nameLocal: nameLocal,
            lat: lat,
            lon: lon,
            timezone: timezone,
            source: source,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CitiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CitiesTable,
    City,
    $$CitiesTableFilterComposer,
    $$CitiesTableOrderingComposer,
    $$CitiesTableAnnotationComposer,
    $$CitiesTableCreateCompanionBuilder,
    $$CitiesTableUpdateCompanionBuilder,
    (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
    City,
    PrefetchHooks Function()>;
typedef $$ProfileCityTableCreateCompanionBuilder = ProfileCityCompanion
    Function({
  required String profileId,
  required String cityId,
  Value<bool> isPrimary,
  Value<String> overridesJson,
  Value<int> rowid,
});
typedef $$ProfileCityTableUpdateCompanionBuilder = ProfileCityCompanion
    Function({
  Value<String> profileId,
  Value<String> cityId,
  Value<bool> isPrimary,
  Value<String> overridesJson,
  Value<int> rowid,
});

class $$ProfileCityTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileCityTable> {
  $$ProfileCityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cityId => $composableBuilder(
      column: $table.cityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get overridesJson => $composableBuilder(
      column: $table.overridesJson, builder: (column) => ColumnFilters(column));
}

class $$ProfileCityTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileCityTable> {
  $$ProfileCityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cityId => $composableBuilder(
      column: $table.cityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get overridesJson => $composableBuilder(
      column: $table.overridesJson,
      builder: (column) => ColumnOrderings(column));
}

class $$ProfileCityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileCityTable> {
  $$ProfileCityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get cityId =>
      $composableBuilder(column: $table.cityId, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<String> get overridesJson => $composableBuilder(
      column: $table.overridesJson, builder: (column) => column);
}

class $$ProfileCityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProfileCityTable,
    ProfileCityData,
    $$ProfileCityTableFilterComposer,
    $$ProfileCityTableOrderingComposer,
    $$ProfileCityTableAnnotationComposer,
    $$ProfileCityTableCreateCompanionBuilder,
    $$ProfileCityTableUpdateCompanionBuilder,
    (
      ProfileCityData,
      BaseReferences<_$AppDatabase, $ProfileCityTable, ProfileCityData>
    ),
    ProfileCityData,
    PrefetchHooks Function()> {
  $$ProfileCityTableTableManager(_$AppDatabase db, $ProfileCityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileCityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileCityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileCityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> profileId = const Value.absent(),
            Value<String> cityId = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<String> overridesJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileCityCompanion(
            profileId: profileId,
            cityId: cityId,
            isPrimary: isPrimary,
            overridesJson: overridesJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String profileId,
            required String cityId,
            Value<bool> isPrimary = const Value.absent(),
            Value<String> overridesJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProfileCityCompanion.insert(
            profileId: profileId,
            cityId: cityId,
            isPrimary: isPrimary,
            overridesJson: overridesJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProfileCityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProfileCityTable,
    ProfileCityData,
    $$ProfileCityTableFilterComposer,
    $$ProfileCityTableOrderingComposer,
    $$ProfileCityTableAnnotationComposer,
    $$ProfileCityTableCreateCompanionBuilder,
    $$ProfileCityTableUpdateCompanionBuilder,
    (
      ProfileCityData,
      BaseReferences<_$AppDatabase, $ProfileCityTable, ProfileCityData>
    ),
    ProfileCityData,
    PrefetchHooks Function()>;
typedef $$CachedEventsTableCreateCompanionBuilder = CachedEventsCompanion
    Function({
  required String profileId,
  required String layerId,
  required String date,
  required String title,
  Value<String> details,
  Value<bool> allDay,
  Value<String?> startTime,
  Value<String?> endTime,
  required String sourceKey,
  Value<int> importance,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CachedEventsTableUpdateCompanionBuilder = CachedEventsCompanion
    Function({
  Value<String> profileId,
  Value<String> layerId,
  Value<String> date,
  Value<String> title,
  Value<String> details,
  Value<bool> allDay,
  Value<String?> startTime,
  Value<String?> endTime,
  Value<String> sourceKey,
  Value<int> importance,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CachedEventsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedEventsTable> {
  $$CachedEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get layerId => $composableBuilder(
      column: $table.layerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allDay => $composableBuilder(
      column: $table.allDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceKey => $composableBuilder(
      column: $table.sourceKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get importance => $composableBuilder(
      column: $table.importance, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedEventsTable> {
  $$CachedEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get layerId => $composableBuilder(
      column: $table.layerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allDay => $composableBuilder(
      column: $table.allDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startTime => $composableBuilder(
      column: $table.startTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get endTime => $composableBuilder(
      column: $table.endTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceKey => $composableBuilder(
      column: $table.sourceKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get importance => $composableBuilder(
      column: $table.importance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedEventsTable> {
  $$CachedEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get layerId =>
      $composableBuilder(column: $table.layerId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<String> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<String> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get sourceKey =>
      $composableBuilder(column: $table.sourceKey, builder: (column) => column);

  GeneratedColumn<int> get importance => $composableBuilder(
      column: $table.importance, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedEventsTable,
    CachedEvent,
    $$CachedEventsTableFilterComposer,
    $$CachedEventsTableOrderingComposer,
    $$CachedEventsTableAnnotationComposer,
    $$CachedEventsTableCreateCompanionBuilder,
    $$CachedEventsTableUpdateCompanionBuilder,
    (
      CachedEvent,
      BaseReferences<_$AppDatabase, $CachedEventsTable, CachedEvent>
    ),
    CachedEvent,
    PrefetchHooks Function()> {
  $$CachedEventsTableTableManager(_$AppDatabase db, $CachedEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> profileId = const Value.absent(),
            Value<String> layerId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> details = const Value.absent(),
            Value<bool> allDay = const Value.absent(),
            Value<String?> startTime = const Value.absent(),
            Value<String?> endTime = const Value.absent(),
            Value<String> sourceKey = const Value.absent(),
            Value<int> importance = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedEventsCompanion(
            profileId: profileId,
            layerId: layerId,
            date: date,
            title: title,
            details: details,
            allDay: allDay,
            startTime: startTime,
            endTime: endTime,
            sourceKey: sourceKey,
            importance: importance,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String profileId,
            required String layerId,
            required String date,
            required String title,
            Value<String> details = const Value.absent(),
            Value<bool> allDay = const Value.absent(),
            Value<String?> startTime = const Value.absent(),
            Value<String?> endTime = const Value.absent(),
            required String sourceKey,
            Value<int> importance = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedEventsCompanion.insert(
            profileId: profileId,
            layerId: layerId,
            date: date,
            title: title,
            details: details,
            allDay: allDay,
            startTime: startTime,
            endTime: endTime,
            sourceKey: sourceKey,
            importance: importance,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedEventsTable,
    CachedEvent,
    $$CachedEventsTableFilterComposer,
    $$CachedEventsTableOrderingComposer,
    $$CachedEventsTableAnnotationComposer,
    $$CachedEventsTableCreateCompanionBuilder,
    $$CachedEventsTableUpdateCompanionBuilder,
    (
      CachedEvent,
      BaseReferences<_$AppDatabase, $CachedEventsTable, CachedEvent>
    ),
    CachedEvent,
    PrefetchHooks Function()>;
typedef $$CustomZmanimDatasetTableCreateCompanionBuilder
    = CustomZmanimDatasetCompanion Function({
  required String profileId,
  required String date,
  required String zmanimJson,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CustomZmanimDatasetTableUpdateCompanionBuilder
    = CustomZmanimDatasetCompanion Function({
  Value<String> profileId,
  Value<String> date,
  Value<String> zmanimJson,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CustomZmanimDatasetTableFilterComposer
    extends Composer<_$AppDatabase, $CustomZmanimDatasetTable> {
  $$CustomZmanimDatasetTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get zmanimJson => $composableBuilder(
      column: $table.zmanimJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CustomZmanimDatasetTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomZmanimDatasetTable> {
  $$CustomZmanimDatasetTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get profileId => $composableBuilder(
      column: $table.profileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get zmanimJson => $composableBuilder(
      column: $table.zmanimJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomZmanimDatasetTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomZmanimDatasetTable> {
  $$CustomZmanimDatasetTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get profileId =>
      $composableBuilder(column: $table.profileId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get zmanimJson => $composableBuilder(
      column: $table.zmanimJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CustomZmanimDatasetTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomZmanimDatasetTable,
    CustomZmanimDatasetData,
    $$CustomZmanimDatasetTableFilterComposer,
    $$CustomZmanimDatasetTableOrderingComposer,
    $$CustomZmanimDatasetTableAnnotationComposer,
    $$CustomZmanimDatasetTableCreateCompanionBuilder,
    $$CustomZmanimDatasetTableUpdateCompanionBuilder,
    (
      CustomZmanimDatasetData,
      BaseReferences<_$AppDatabase, $CustomZmanimDatasetTable,
          CustomZmanimDatasetData>
    ),
    CustomZmanimDatasetData,
    PrefetchHooks Function()> {
  $$CustomZmanimDatasetTableTableManager(
      _$AppDatabase db, $CustomZmanimDatasetTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomZmanimDatasetTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomZmanimDatasetTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomZmanimDatasetTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> profileId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> zmanimJson = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomZmanimDatasetCompanion(
            profileId: profileId,
            date: date,
            zmanimJson: zmanimJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String profileId,
            required String date,
            required String zmanimJson,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomZmanimDatasetCompanion.insert(
            profileId: profileId,
            date: date,
            zmanimJson: zmanimJson,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomZmanimDatasetTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomZmanimDatasetTable,
    CustomZmanimDatasetData,
    $$CustomZmanimDatasetTableFilterComposer,
    $$CustomZmanimDatasetTableOrderingComposer,
    $$CustomZmanimDatasetTableAnnotationComposer,
    $$CustomZmanimDatasetTableCreateCompanionBuilder,
    $$CustomZmanimDatasetTableUpdateCompanionBuilder,
    (
      CustomZmanimDatasetData,
      BaseReferences<_$AppDatabase, $CustomZmanimDatasetTable,
          CustomZmanimDatasetData>
    ),
    CustomZmanimDatasetData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$LayersTableTableManager get layers =>
      $$LayersTableTableManager(_db, _db.layers);
  $$ProfileLayersTableTableManager get profileLayers =>
      $$ProfileLayersTableTableManager(_db, _db.profileLayers);
  $$MethodsConfigTableTableManager get methodsConfig =>
      $$MethodsConfigTableTableManager(_db, _db.methodsConfig);
  $$CitiesTableTableManager get cities =>
      $$CitiesTableTableManager(_db, _db.cities);
  $$ProfileCityTableTableManager get profileCity =>
      $$ProfileCityTableTableManager(_db, _db.profileCity);
  $$CachedEventsTableTableManager get cachedEvents =>
      $$CachedEventsTableTableManager(_db, _db.cachedEvents);
  $$CustomZmanimDatasetTableTableManager get customZmanimDataset =>
      $$CustomZmanimDatasetTableTableManager(_db, _db.customZmanimDataset);
}
