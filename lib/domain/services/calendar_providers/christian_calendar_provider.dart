import 'package:intl/intl.dart';

import '../../models/calendar_event.dart';

class ChristianCalendarProvider {
  String get layerId => 'layer_christian';

  List<CalendarEventDto> getEventsForDate(DateTime date, String countryCode) {
    final events = <CalendarEventDto>[];
    final key = DateFormat('yyyy-MM-dd').format(date);
    final m = date.month;
    final d = date.day;

    if (m == 12 && d == 25) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Christmas',
        sourceKey: 'christmas_$key',
        importance: 1,
      ));
    }
    if (m == 12 && d == 24) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Christmas Eve',
        sourceKey: 'christmas_eve_$key',
      ));
    }
    if (m == 1 && d == 1) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'New Year\'s Day',
        sourceKey: 'newyear_$key',
      ));
    }
    if (m == 1 && d == 6) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Epiphany',
        sourceKey: 'epiphany_$key',
      ));
    }

    final easter = _easter(date.year);
    if (date.year == easter.year &&
        date.month == easter.month &&
        date.day == easter.day) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Easter Sunday',
        sourceKey: 'easter_$key',
        importance: 1,
      ));
    }
    final goodFriday = _goodFriday(easter);
    if (date.year == goodFriday.year &&
        date.month == goodFriday.month &&
        date.day == goodFriday.day) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Good Friday',
        sourceKey: 'goodfriday_$key',
        importance: 1,
      ));
    }

    return events;
  }

  static DateTime _easter(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  static DateTime _goodFriday(DateTime easter) {
    return easter.subtract(const Duration(days: 2));
  }
}
