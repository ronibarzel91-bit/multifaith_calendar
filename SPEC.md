flutter create multifaith_calendar
cd multifaith_calendar
flutter config --enable-web

dependencies:
  flutter:
    sdk: flutter

  # State
  flutter_riverpod: ^2.5.1

  # Routing
  go_router: ^14.2.7

  # Local DB (SQLite)
  drift: ^2.20.0
  drift_flutter: ^2.20.0
  sqlite3_flutter_libs: ^0.5.24
  path_provider: ^2.1.4
  path: ^1.9.0

  # Utils
  uuid: ^4.5.1
  intl: ^0.19.0
  collection: ^1.18.0

  # (אופציונלי ל-MVP)
  geolocator: ^12.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  drift_dev: ^2.20.0
  build_runner: ^2.4.12

lib/
  main.dart
  app/
    router.dart
    theme.dart
    bootstrap.dart
  data/
    db/
      app_db.dart
      tables.dart
      dao_profiles.dart
      dao_layers.dart
      dao_events_cache.dart
    repositories/
      profiles_repo.dart
      layers_repo.dart
      cache_repo.dart
  domain/
    models/
      enums.dart
      calendar_event.dart
      localized_date.dart
    services/
      calendar_providers/   // Hebrew/Islamic/Christian
      prayer_times/
      country_packs/
  features/
    home/
      home_screen.dart
      home_controller.dart
    month/
      month_screen.dart
    layers/
      layers_screen.dart
    profiles/
      profiles_screen.dart
    settings/
      settings_screen.dart
  shared/
    widgets/
      app_scaffold.dart
      loading_skeleton.dart

enum LayerType { hebrew, islamic, christian, national }

enum JewishMethod { gra, mga }

enum IslamicMethod { mwl, isna, egypt, karachi, ummAlQura }

enum AsrMethod { standard, hanafi }

enum HighLatRule { none, middleOfNight, seventhOfNight, angleBased }

enum CitySource { pack, userSearch, gps }

import 'package:drift/drift.dart';

class Profiles extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get name => text()();

  TextColumn get countryCode => text()(); // "IL"
  TextColumn get timezone => text()();    // "Asia/Jerusalem"

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
  TextColumn get id => text()(); // uuid
  IntColumn get type => intEnum<LayerType>()();

  TextColumn get variant => text().withDefault(const Constant(''))(); // e.g. "catholic"
  TextColumn get displayName => text()();

  IntColumn get color => integer()(); // ARGB int
  BoolColumn get enabledByDefault => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProfileLayers extends Table {
  TextColumn get profileId => text()();
  TextColumn get layerId => text()();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  TextColumn get visibilityRuleJson => text().withDefault(const Constant('{}'))();
  TextColumn get notificationPolicyJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId, layerId};
}

class MethodsConfig extends Table {
  TextColumn get profileId => text()();

  IntColumn get jewishMethod => intEnum<JewishMethod>()
      .withDefault(const Constant(0))(); // gra

  IntColumn get islamicMethod => intEnum<IslamicMethod>()
      .withDefault(const Constant(0))(); // mwl

  IntColumn get asrMethod => intEnum<AsrMethod>()
      .withDefault(const Constant(0))(); // standard

  IntColumn get highLatRule => intEnum<HighLatRule>()
      .withDefault(const Constant(0))(); // none

  TextColumn get customParamsJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId};
}

class Cities extends Table {
  TextColumn get id => text()(); // uuid
  TextColumn get countryCode => text()();

  TextColumn get name => text()();      // e.g. "Jerusalem"
  TextColumn get nameLocal => text().nullable()(); // e.g. "ירושלים"

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

  // אופציונלי: תיקונים מקומיים
  TextColumn get overridesJson => text().withDefault(const Constant('{}'))();

  @override
  Set<Column> get primaryKey => {profileId, cityId};
}

/// Cache לאירועים מחושבים (לטווחים נצפים)
class CachedEvents extends Table {
  TextColumn get profileId => text()();
  TextColumn get layerId => text()();

  // YYYY-MM-DD
  TextColumn get date => text()();

  TextColumn get title => text()();
  TextColumn get details => text().withDefault(const Constant(''))();

  BoolColumn get allDay => boolean().withDefault(const Constant(true))();
  TextColumn get startTime => text().nullable()(); // "HH:MM"
  TextColumn get endTime => text().nullable()();

  TextColumn get sourceKey => text()(); // מזהה פנימי לאירוע (חג/חישוב)
  IntColumn get importance => integer().withDefault(const Constant(0))(); // 0 normal

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {profileId, layerId, date, sourceKey};
}

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'app_db.g.dart';

@DriftDatabase(tables: [
  Profiles, Layers, ProfileLayers, MethodsConfig, Cities, ProfileCity, CachedEvents
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // עובד באנדרואיד; בווב Drift משתמש בפתרון אחר דרך drift_flutter (זה OK למבנה הזה)
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

dart run build_runner build --delete-conflicting-outputs

import 'package:uuid/uuid.dart';
import '../db/app_db.dart';

class ProfilesRepo {
  ProfilesRepo(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<String> createDefaultProfileIfMissing() async {
    final existing = await db.select(db.profiles).get();
    if (existing.isNotEmpty) return existing.first.id;

    final id = _uuid.v4();
    final now = DateTime.now();

    await db.into(db.profiles).insert(ProfilesCompanion.insert(
      id: id,
      name: 'בית',
      countryCode: 'IL',
      timezone: 'Asia/Jerusalem',
      lat: 31.7683,
      lon: 35.2137,
      elevation: const Value(null),
      isDefault: const Value(true),
      createdAt: now,
      updatedAt: now,
    ));

    await db.into(db.methodsConfig).insert(MethodsConfigCompanion.insert(
      profileId: id,
    ));

    return id;
  }

  Future<Profile?> getDefaultProfile() async {
    final q = db.select(db.profiles)..where((p) => p.isDefault.equals(true));
    return q.getSingleOrNull();
  }
}
 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/db/app_db.dart';
import 'data/repositories/profiles_repo.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

final profilesRepoProvider = Provider<ProfilesRepo>((ref) {
  return ProfilesRepo(ref.watch(dbProvider));
});

final bootstrapProvider = FutureProvider<void>((ref) async {
  final repo = ref.watch(profilesRepoProvider);
  await repo.createDefaultProfileIfMissing();
});

import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/month/month_screen.dart';
import '../features/layers/layers_screen.dart';
import '../features/profiles/profiles_screen.dart';
import '../features/settings/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/month', builder: (_, __) => const MonthScreen()),
    GoRoute(path: '/layers', builder: (_, __) => const LayersScreen()),
    GoRoute(path: '/profiles', builder: (_, __) => const ProfilesScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(bootstrapProvider);

    return MaterialApp.router(
      theme: appTheme,
      routerConfig: router,
      builder: (context, child) {
        return boot.when(
          loading: () => const Material(child: Center(child: CircularProgressIndicator())),
          error: (e, _) => Material(child: Center(child: Text('Bootstrap error: $e'))),
          data: (_) => child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
