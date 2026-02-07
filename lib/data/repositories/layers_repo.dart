import 'package:drift/drift.dart';

import '../db/app_db.dart';
import '../db/tables.dart';

class LayerWithState {
  const LayerWithState({
    required this.layer,
    required this.isEnabled,
  });
  final Layer layer;
  final bool isEnabled;
}

class LayersRepo {
  LayersRepo(this.db);
  final AppDatabase db;

  static const _defaultLayerIds = [
    'layer_hebrew',
    'layer_islamic',
    'layer_christian',
    'layer_national',
  ];

  static const _defaultLayers = [
    (LayerType.hebrew, 'עברי', 0xFF0E7490),
    (LayerType.islamic, 'אסלאמי', 0xFF166534),
    (LayerType.christian, 'נוצרי', 0xFF1D4ED8),
    (LayerType.national, 'לאומי', 0xFF9A3412),
  ];

  Future<void> seedDefaultLayersIfMissing() async {
    final existing = await db.select(db.layers).get();
    if (existing.isNotEmpty) return;

    final now = DateTime.now();
    for (var i = 0; i < _defaultLayers.length; i++) {
      final (type, displayName, color) = _defaultLayers[i];
      final id = _defaultLayerIds[i];
      await db.into(db.layers).insert(LayersCompanion.insert(
            id: id,
            type: type,
            variant: const Value(''),
            displayName: displayName,
            color: color,
            enabledByDefault: const Value(false),
            createdAt: now,
          ));
    }
  }

  Future<void> ensureProfileHasLayers(String profileId) async {
    final layers = await db.select(db.layers).get();
    for (final layer in layers) {
      final link = await (db.select(db.profileLayers)
            ..where((pl) =>
                pl.profileId.equals(profileId) & pl.layerId.equals(layer.id)))
          .getSingleOrNull();
      if (link == null) {
        await db.into(db.profileLayers).insert(ProfileLayersCompanion.insert(
              profileId: profileId,
              layerId: layer.id,
              isEnabled: const Value(true),
            ));
      }
    }
  }

  Future<List<Layer>> getEnabledLayersForProfile(String profileId) async {
    final query = db.select(db.layers).join([
      innerJoin(db.profileLayers,
          db.profileLayers.layerId.equalsExp(db.layers.id)),
    ])
      ..where(db.profileLayers.profileId.equals(profileId) &
          db.profileLayers.isEnabled.equals(true));
    final rows = await query.get();
    return rows.map((r) => r.readTable(db.layers)).toList();
  }

  Future<List<LayerWithState>> getLayersWithProfileState(String profileId) async {
    final layers = await db.select(db.layers).get();
    final list = <LayerWithState>[];
    for (final layer in layers) {
      final pl = await (db.select(db.profileLayers)
            ..where((pl) =>
                pl.profileId.equals(profileId) & pl.layerId.equals(layer.id)))
          .getSingleOrNull();
      list.add(LayerWithState(
        layer: layer,
        isEnabled: pl?.isEnabled ?? false,
      ));
    }
    return list;
  }

  Stream<List<Layer>> watchEnabledLayersForProfile(String profileId) {
    final query = db.select(db.layers).join([
      innerJoin(db.profileLayers,
          db.profileLayers.layerId.equalsExp(db.layers.id)),
    ])
      ..where(db.profileLayers.profileId.equals(profileId) &
          db.profileLayers.isEnabled.equals(true));
    return query.watch().map((rows) => rows.map((r) => r.readTable(db.layers)).toList());
  }

  Future<void> setLayerEnabled(
      String profileId, String layerId, bool isEnabled) async {
    await db.into(db.profileLayers).insert(
          ProfileLayersCompanion.insert(
            profileId: profileId,
            layerId: layerId,
            isEnabled: Value(isEnabled),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
