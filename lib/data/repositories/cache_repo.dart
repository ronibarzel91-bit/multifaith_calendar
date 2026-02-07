import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

import '../../domain/models/calendar_event.dart';
import '../db/app_db.dart';

class CacheRepo {
  CacheRepo(this.db);
  final AppDatabase db;

  static String dateToKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<List<CachedEvent>> getEventsForDate(
      String profileId, DateTime date) async {
    final key = dateToKey(date);
    final rows = await (db.select(db.cachedEvents)
          ..where((e) =>
              e.profileId.equals(profileId) & e.date.equals(key)))
        .get();
    return rows;
  }

  Future<void> upsertEvents(String profileId, List<CalendarEventDto> events) async {
    final now = DateTime.now();
    for (final e in events) {
      await db.into(db.cachedEvents).insert(
            CachedEventsCompanion.insert(
              profileId: profileId,
              layerId: e.layerId,
              date: e.date,
              title: e.title,
              details: Value(e.details),
              allDay: Value(e.allDay),
              startTime: Value(e.startTime),
              endTime: Value(e.endTime),
              sourceKey: e.sourceKey,
              importance: Value(e.importance),
              updatedAt: now,
            ),
            mode: InsertMode.insertOrReplace,
          );
    }
  }
}
