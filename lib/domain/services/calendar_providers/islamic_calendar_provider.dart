import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import '../../models/calendar_event.dart';

class IslamicCalendarProvider {
  String get layerId => 'layer_islamic';

  List<CalendarEventDto> getEventsForDate(DateTime date, String countryCode) {
    final events = <CalendarEventDto>[];
    final key = DateFormat('yyyy-MM-dd').format(date);
    final h = HijriCalendar.fromDate(date);

    if (h.hMonth == 9) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Ramadan',
        sourceKey: 'ramadan_$key',
        details: 'Day ${h.hDay} of Ramadan',
        importance: 1,
      ));
    }
    if (h.hMonth == 10 && h.hDay == 1) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Eid al-Fitr',
        sourceKey: 'eid_fitr_$key',
        importance: 1,
      ));
    }
    if (h.hMonth == 12 && h.hDay == 10) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Eid al-Adha',
        sourceKey: 'eid_adha_$key',
        importance: 1,
      ));
    }
    if (h.hMonth == 1 && h.hDay == 1) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Islamic New Year',
        sourceKey: 'muharram_$key',
        importance: 1,
      ));
    }
    if (h.hMonth == 12 && h.hDay == 9) {
      events.add(CalendarEventDto(
        layerId: layerId,
        date: key,
        title: 'Day of Arafah',
        sourceKey: 'arafah_$key',
      ));
    }

    return events;
  }

  String getIslamicDateString(DateTime date) {
    final h = HijriCalendar.fromDate(date);
    return '${h.hDay} ${h.getLongMonthName()} ${h.hYear}';
  }
}
