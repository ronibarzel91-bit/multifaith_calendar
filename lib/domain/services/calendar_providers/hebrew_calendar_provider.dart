import 'package:intl/intl.dart';
import 'package:kosher_dart/kosher_dart.dart';

import '../../models/calendar_event.dart';
import '../../models/localized_date.dart';

class HebrewCalendarProvider {
  String get layerId => 'layer_hebrew';

  List<CalendarEventDto> getEventsForDate(DateTime date, String countryCode) {
    final events = <CalendarEventDto>[];
    final key = DateFormat('yyyy-MM-dd').format(date);
    final cal = JewishCalendar.fromDateTime(date);
    cal.inIsrael = countryCode == 'IL';
    final formatter = HebrewDateFormatter();
    formatter.hebrewFormat = true;

    final yomTov = formatter.formatYomTov(cal);
    if (yomTov.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: yomTov,
        sourceKey: 'yomtov_${key}',
        importance: 1,
      ));
    }

    final roshChodesh = formatter.formatRoshChodesh(cal);
    if (roshChodesh.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: roshChodesh,
        sourceKey: 'roshchodesh_$key',
      ));
    }

    final erevRoshChodesh = formatter.formatErevRoshChodesh(cal);
    if (erevRoshChodesh.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: erevRoshChodesh,
        sourceKey: 'erevroshchodesh_$key',
      ));
    }

    final omer = formatter.formatOmer(cal);
    if (omer.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: omer,
        sourceKey: 'omer_$key',
      ));
    }

    final parsha = formatter.formatParsha(cal);
    if (parsha.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: parsha,
        sourceKey: 'parsha_$key',
      ));
    }

    final specialParsha = formatter.formatSpecialParsha(cal);
    if (specialParsha.isNotEmpty) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: specialParsha,
        sourceKey: 'specialparsha_$key',
      ));
    }

    final dayOfChanukah = cal.getDayOfChanukah();
    if (dayOfChanukah > 0) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'יום ${formatter.formatHebrewNumber(dayOfChanukah)} לחנוכה',
        sourceKey: 'chanukah_$key',
      ));
    }

    return events;
  }

  /// Returns Hebrew date string for display (e.g. "21 Shevat 5785").
  String getHebrewDateString(DateTime date, String countryCode) {
    final cal = JewishCalendar.fromDateTime(date);
    cal.inIsrael = countryCode == 'IL';
    final formatter = HebrewDateFormatter();
    formatter.hebrewFormat = true;
    return formatter.format(cal, pattern: 'dd MM yy');
  }

  HebrewDateParts getHebrewDateParts(DateTime date, String countryCode) {
    final cal = JewishCalendar.fromDateTime(date);
    cal.inIsrael = countryCode == 'IL';
    final formatter = HebrewDateFormatter();
    formatter.hebrewFormat = true;

    return HebrewDateParts(
      dayNumber: cal.getJewishDayOfMonth(),
      dayHebrew: formatter.formatHebrewNumber(cal.getJewishDayOfMonth()),
      monthHebrew: formatter.formatMonth(cal),
      yearNumber: cal.getJewishYear(),
      yearHebrew: formatter.formatHebrewNumber(cal.getJewishYear()),
    );
  }
}
