import '../models/calendar_event.dart';
import '../models/localized_date.dart';
import '../../data/db/app_db.dart';
import '../../data/db/tables.dart';
import 'calendar_providers/christian_calendar_provider.dart';
import 'calendar_providers/hebrew_calendar_provider.dart';
import 'calendar_providers/islamic_calendar_provider.dart';

/// Aggregates events from Hebrew, Islamic, and Christian calendar providers
/// for enabled layers and a given date.
class CalendarService {
  CalendarService();

  final _hebrew = HebrewCalendarProvider();
  final _islamic = IslamicCalendarProvider();
  final _christian = ChristianCalendarProvider();

  List<CalendarEventDto> getEventsForDate(
    DateTime date,
    String countryCode,
    List<Layer> enabledLayers,
  ) {
    final events = <CalendarEventDto>[];

    for (final layer in enabledLayers) {
      switch (layer.type) {
        case LayerType.hebrew:
          events.addAll(_hebrew.getEventsForDate(date, countryCode));
          break;
        case LayerType.islamic:
          events.addAll(_islamic.getEventsForDate(date, countryCode));
          break;
        case LayerType.christian:
          events.addAll(_christian.getEventsForDate(date, countryCode));
          break;
        case LayerType.national:
          break;
      }
    }
    return events;
  }

  String? getHebrewDateString(DateTime date, String countryCode) {
    return _hebrew.getHebrewDateString(date, countryCode);
  }

  HebrewDateParts getHebrewDateParts(DateTime date, String countryCode) {
    return _hebrew.getHebrewDateParts(date, countryCode);
  }

  String? getIslamicDateString(DateTime date) {
    return _islamic.getIslamicDateString(date);
  }
}
