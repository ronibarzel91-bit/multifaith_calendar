import 'dart:convert';
import 'package:drift/drift.dart';
import '../../../data/db/app_db.dart';

class DatasetImporter {
  final AppDatabase db;

  DatasetImporter(this.db);

  /// Imports zmanim from a JSON list.
  /// Format: [{"date":"YYYY-MM-DD","sunrise":"HH:mm","sunset":"HH:mm",...}]
  Future<void> importFromJson(String profileId, String jsonString) async {
    final List<dynamic> data = json.decode(jsonString);
    final now = DateTime.now();

    await db.batch((batch) {
      for (final item in data) {
        final dateStr = item['date'] as String;
        // Clean the item to store only zmanim (exclude date)
        final zmanim = Map<String, dynamic>.from(item)..remove('date');
        
        batch.insert(
          db.customZmanimDataset,
          CustomZmanimDatasetCompanion(
            profileId: Value(profileId),
            date: Value(dateStr),
            zmanimJson: Value(json.encode(zmanim)),
            updatedAt: Value(now),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  /// Imports zmanim from a CSV string.
  /// Format: date,sunrise,sunset,alos,tzeit,...
  Future<void> importFromCsv(String profileId, String csvString) async {
    final lines = csvString.trim().split('\n');
    if (lines.isEmpty) return;

    final header = lines[0].split(',').map((e) => e.trim()).toList();
    final now = DateTime.now();

    await db.batch((batch) {
      for (var i = 1; i < lines.length; i++) {
        final values = lines[i].split(',').map((e) => e.trim()).toList();
        if (values.length < header.length) continue;

        String? dateStr;
        final zmanim = <String, String>{};

        for (var j = 0; j < header.length; j++) {
          if (header[j].toLowerCase() == 'date') {
            dateStr = values[j];
          } else {
            zmanim[header[j]] = values[j];
          }
        }

        if (dateStr != null) {
          batch.insert(
            db.customZmanimDataset,
            CustomZmanimDatasetCompanion(
              profileId: Value(profileId),
              date: Value(dateStr),
              zmanimJson: Value(json.encode(zmanim)),
              updatedAt: Value(now),
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
  }

  /// Retrieves overrides for a specific date and profile.
  Future<Map<String, String>?> getOverrides(String profileId, DateTime date) async {
    final dateStr = date.toIso8601String().split('T')[0];
    final row = await (db.select(db.customZmanimDataset)
          ..where((t) => t.profileId.equals(profileId) & t.date.equals(dateStr)))
        .getSingleOrNull();

    if (row == null) return null;
    return Map<String, String>.from(json.decode(row.zmanimJson));
  }
}
