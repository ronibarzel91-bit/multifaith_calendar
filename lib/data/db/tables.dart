import 'package:drift/drift.dart';

enum LayerType { hebrew, islamic, christian, national }

enum JewishMethod { gra, mga, itimLeBinah, customCalc }

enum IslamicMethod { mwl, isna, egypt, karachi, ummAlQura }

enum AsrMethod { standard, hanafi }

enum HighLatRule { none, middleOfNight, seventhOfNight, angleBased }

enum CitySource { pack, userSearch, gps }

class CustomZmanimDataset extends Table {
  TextColumn get profileId => text()();
  TextColumn get date => text()(); // YYYY-MM-DD
  
  TextColumn get zmanimJson => text()(); // Stores {"sunrise": "HH:mm", ...}
  
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId, date};
}

class Profiles extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get countryCode => text()();
  TextColumn get timezone => text()();

  RealColumn get lat => real()();
  RealColumn get lon => real()();
  RealColumn get elevation => real().nullable()();

  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class Layers extends Table {
  TextColumn get id => text()();
  IntColumn get type => intEnum<LayerType>()();

  TextColumn get variant => text().withDefault(const Constant(''))();
  TextColumn get displayName => text()();

  IntColumn get color => integer()();
  BoolColumn get enabledByDefault =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProfileLayers extends Table {
  TextColumn get profileId => text()();
  TextColumn get layerId => text()();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  TextColumn get visibilityRuleJson =>
      text().withDefault(const Constant('{}'))();
  TextColumn get notificationPolicyJson =>
      text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId, layerId};
}

class MethodsConfig extends Table {
  TextColumn get profileId => text()();

  IntColumn get jewishMethod =>
      intEnum<JewishMethod>().withDefault(const Constant(0))();

  IntColumn get islamicMethod =>
      intEnum<IslamicMethod>().withDefault(const Constant(0))();

  IntColumn get asrMethod => intEnum<AsrMethod>().withDefault(const Constant(0))();

  IntColumn get highLatRule =>
      intEnum<HighLatRule>().withDefault(const Constant(0))();

  TextColumn get customParamsJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId};
}

class Cities extends Table {
  TextColumn get id => text()();
  TextColumn get countryCode => text()();

  TextColumn get name => text()();
  TextColumn get nameLocal => text().nullable()();

  RealColumn get lat => real()();
  RealColumn get lon => real()();
  TextColumn get timezone => text()();

  IntColumn get source => intEnum<CitySource>()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProfileCity extends Table {
  TextColumn get profileId => text()();
  TextColumn get cityId => text()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(true))();

  TextColumn get overridesJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId, cityId};
}

class CachedEvents extends Table {
  TextColumn get profileId => text()();
  TextColumn get layerId => text()();

  TextColumn get date => text()();

  TextColumn get title => text()();
  TextColumn get details => text().withDefault(const Constant(''))();

  BoolColumn get allDay => boolean().withDefault(const Constant(true))();
  TextColumn get startTime => text().nullable()();
  TextColumn get endTime => text().nullable()();

  TextColumn get sourceKey => text()();
  IntColumn get importance => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId, layerId, date, sourceKey};
}