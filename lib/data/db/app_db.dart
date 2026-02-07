import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_db.g.dart';

@DriftDatabase(tables: [
  Profiles,
  Layers,
  ProfileLayers,
  MethodsConfig,
  Cities,
  ProfileCity,
  CachedEvents,
  CustomZmanimDataset,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'app'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(customZmanimDataset);
          }
        },
      );
}
