import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/i18n.dart';
import '../../domain/models/enums.dart';
import '../../domain/models/localized_date.dart';
import '../../domain/services/prayer_times/prayer_times_service.dart';
import '../../providers.dart';

enum _MonthViewMode { spread, list }
enum _CalendarMode { gregorian, hebrew }

class MonthScreen extends ConsumerStatefulWidget {
  const MonthScreen({super.key});

  @override
  ConsumerState<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends ConsumerState<MonthScreen> {
  late DateTime _visibleMonth;
  late DateTime _selectedDate;
  _MonthViewMode _viewMode = _MonthViewMode.spread;
  _CalendarMode _calendarMode = _CalendarMode.gregorian;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month, 1);
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    final monthDataAsync = ref.watch(_monthDataProvider(_visibleMonth));
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final monthLabel = DateFormat('MMMM y', localeTag).format(_visibleMonth);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.t('app_month')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Column(
        children: [
          _MonthPickerHeader(
            monthLabel: monthLabel,
            onPrev: () => _changeMonth(-1),
            onNext: () => _changeMonth(1),
            onPickDate: _pickDate,
            strings: strings,
          ),
          _ViewModeControls(
            viewMode: _viewMode,
            calendarMode: _calendarMode,
            onViewModeChanged: (v) => setState(() => _viewMode = v),
            onCalendarModeChanged: (c) => setState(() => _calendarMode = c),
            strings: strings,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: monthDataAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('${strings.t('common_error')}: $e')),
              data: (data) {
                if (data.days.isEmpty) {
                  return Center(child: Text(strings.t('month_no_data')));
                }

                if (_viewMode == _MonthViewMode.list) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: data.days.length,
                    itemBuilder: (context, index) {
                      return _MonthDayCard(
                        day: data.days[index],
                        calendarMode: _calendarMode,
                        strings: strings,
                      ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
                    },
                  );
                }

                final selectedDay = _findDayData(data.days, _selectedDate) ?? data.days.first;
                return _MonthSpreadView(
                  days: data.days,
                  selectedDate: selectedDay.date,
                  calendarMode: _calendarMode,
                  strings: strings,
                  onSelectDate: (date) {
                    setState(() => _selectedDate = date);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta, 1);
      final lastDay = DateTime(_visibleMonth.year, _visibleMonth.month + 1, 0).day;
      _selectedDate = DateTime(_visibleMonth.year, _visibleMonth.month, math.min(_selectedDate.day, lastDay));
    });
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (picked == null) return;
    setState(() {
      _selectedDate = picked;
      _visibleMonth = DateTime(picked.year, picked.month, 1);
    });
  }
}

class _MonthPickerHeader extends StatelessWidget {
  const _MonthPickerHeader({
    required this.monthLabel,
    required this.onPrev,
    required this.onNext,
    required this.onPickDate,
    required this.strings,
  });

  final String monthLabel;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onPickDate;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _HeaderIconButton(icon: Icons.chevron_left_rounded, onTap: onPrev),
          Expanded(
            child: InkWell(
              onTap: onPickDate,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Text(
                  monthLabel,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
            ),
          ),
          _HeaderIconButton(icon: Icons.chevron_right_rounded, onTap: onNext),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: const Color(0xFF475569)),
        onPressed: onTap,
      ),
    );
  }
}

class _ViewModeControls extends StatelessWidget {
  const _ViewModeControls({
    required this.viewMode,
    required this.calendarMode,
    required this.onViewModeChanged,
    required this.onCalendarModeChanged,
    required this.strings,
  });

  final _MonthViewMode viewMode;
  final _CalendarMode calendarMode;
  final ValueChanged<_MonthViewMode> onViewModeChanged;
  final ValueChanged<_CalendarMode> onCalendarModeChanged;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _SegmentedControl<_MonthViewMode>(
              value: viewMode,
              onChanged: onViewModeChanged,
              items: [
                _SegmentItem(value: _MonthViewMode.spread, label: strings.t('month_spread'), icon: Icons.grid_view_rounded),
                _SegmentItem(value: _MonthViewMode.list, label: strings.t('month_list'), icon: Icons.view_list_rounded),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _SegmentedControl<_CalendarMode>(
              value: calendarMode,
              onChanged: onCalendarModeChanged,
              items: [
                _SegmentItem(value: _CalendarMode.gregorian, label: strings.t('month_gregorian'), icon: Icons.calendar_today_rounded),
                _SegmentItem(value: _CalendarMode.hebrew, label: strings.t('month_hebrew'), icon: Icons.auto_stories_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedControl<T> extends StatelessWidget {
  const _SegmentedControl({required this.value, required this.onChanged, required this.items});
  final T value;
  final ValueChanged<T> onChanged;
  final List<_SegmentItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = item.value == value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item.value),
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 16, color: isSelected ? Theme.of(context).primaryColor : const Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text(
                      item.label,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Theme.of(context).primaryColor : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SegmentItem<T> {
  const _SegmentItem({required this.value, required this.label, required this.icon});
  final T value;
  final String label;
  final IconData icon;
}

class _MonthSpreadView extends StatelessWidget {
  const _MonthSpreadView({
    required this.days,
    required this.selectedDate,
    required this.calendarMode,
    required this.strings,
    required this.onSelectDate,
  });

  final List<_MonthDayData> days;
  final DateTime selectedDate;
  final _CalendarMode calendarMode;
  final AppStrings strings;
  final ValueChanged<DateTime> onSelectDate;

  @override
  Widget build(BuildContext context) {
    final monthStart = DateTime(days.first.date.year, days.first.date.month, 1);
    final offset = monthStart.weekday % 7;
    final cells = <_MonthDayData?>[
      for (var i = 0; i < offset; i++) null,
      ...days,
    ];
    while (cells.length % 7 != 0) cells.add(null);

    final selectedDay = _findDayData(days, selectedDate) ?? days.first;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final weekLabels = calendarMode == _CalendarMode.hebrew
        ? const ['\u05d0', '\u05d1', '\u05d2', '\u05d3', '\u05d4', '\u05d5', '\u05e9']
        : List.generate(7, (i) {
            // Jan 7, 2024 is a Sunday
            final date = DateTime(2024, 1, 7 + i);
            // Get narrow format (single letter)
            try {
              return DateFormat.E(localeTag).format(date).characters.first;
            } catch (_) {
              return DateFormat.E(localeTag).format(date).substring(0, 1);
            }
          });

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Row(
          children: weekLabels.map((l) => Expanded(
            child: Center(
              child: Text(l, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF94A3B8))),
            ),
          )).toList(),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cells.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 85, // Increased height for Parasha name
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final day = cells[index];
            if (day == null) return const SizedBox.shrink();

            final isSelected = _isSameDate(day.date, selectedDate);
            final isToday = _isSameDate(day.date, DateTime.now());
            final label = calendarMode == _CalendarMode.hebrew ? (day.hebrewParts?.dayHebrew ?? '${day.date.day}') : '${day.date.day}';

            String? parashaName;
            if (day.date.weekday == DateTime.saturday) {
              try {
                final pEvent = day.events.firstWhere((e) =>
                    e.layerId == 'layer_hebrew' &&
                    (e.sourceKey.startsWith('parsha_') ||
                        e.sourceKey.startsWith('specialparsha_')));
                parashaName = pEvent.title;
              } catch (_) {}
            }

            return GestureDetector(
              onTap: () => onSelectDate(day.date),
              child: AnimatedContainer(
                duration: 200.ms,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? Theme.of(context).primaryColor : (isToday ? Theme.of(context).primaryColor.withOpacity(0.1) : const Color(0xFFF8FAFC)),
                  borderRadius: BorderRadius.circular(16),
                  border: isToday ? Border.all(color: Theme.of(context).primaryColor, width: 1.5) : null,
                  boxShadow: isSelected ? [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : (isToday ? Theme.of(context).primaryColor : const Color(0xFF1E293B)),
                      ),
                    ),
                    if (parashaName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          parashaName,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 9,
                            height: 1,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white.withOpacity(0.9) : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    const Spacer(),
                    if (day.events.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: day.events.take(4).map((e) => Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Color(e.layerColor),
                              shape: BoxShape.circle,
                              boxShadow: isSelected ? null : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                          )).toList(),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _SelectedDayCard(day: selectedDay, calendarMode: calendarMode, strings: strings)
            .animate().fadeIn().slideY(begin: 0.1),
      ],
    );
  }
}

class _SelectedDayCard extends StatelessWidget {
  const _SelectedDayCard({required this.day, required this.calendarMode, required this.strings});
  final _MonthDayData day;
  final _CalendarMode calendarMode;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE, MMM d', localeTag).format(day.date),
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
          ),
          if (day.hebrewDateString != null)
            Text(day.hebrewDateString!, style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF64748B))),
          const Divider(height: 32),
          if (day.prayerTimes.isNotEmpty) ...[
            Text(strings.t('home_prayer_times'), style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: day.prayerTimes.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Text('${_localizedPrayerName(t.name, strings)}: ${DateFormat('HH:mm').format(t.time)}', style: GoogleFonts.outfit(fontSize: 12)),
              )).toList(),
            ),
            const SizedBox(height: 20),
          ],
          ...day.events.map((e) => _EventListTile(event: e)),
          if (day.events.isEmpty && day.prayerTimes.isEmpty)
            Center(child: Text(strings.t('month_no_events'), style: GoogleFonts.outfit(color: const Color(0xFF94A3B8)))),
        ],
      ),
    );
  }
}

class _EventListTile extends StatelessWidget {
  const _EventListTile({required this.event});
  final _MonthEventItem event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 4, height: 32, decoration: BoxDecoration(color: Color(event.layerColor), borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(event.layerName, style: GoogleFonts.outfit(fontSize: 12, color: const Color(0xFF64748B))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthDayCard extends StatelessWidget {
  const _MonthDayCard({required this.day, required this.calendarMode, required this.strings});
  final _MonthDayData day;
  final _CalendarMode calendarMode;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat('EEE, MMM d', localeTag).format(day.date), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w700)),
              if (day.hebrewParts != null) Text(day.hebrewParts!.dayHebrew, style: GoogleFonts.outfit(fontSize: 14, color: const Color(0xFF64748B))),
            ],
          ),
          if (day.prayerTimes.isNotEmpty) ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: day.prayerTimes.take(4).map((t) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text('${_localizedPrayerName(t.name, strings)} ${DateFormat('HH:mm').format(t.time)}', style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF94A3B8))),
                )).toList(),
              ),
            ),
          ],
          if (day.events.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...day.events.take(2).map((e) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Container(width: 6, height: 6, decoration: BoxDecoration(color: Color(e.layerColor), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e.title, style: GoogleFonts.outfit(fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}

class _MonthData {
  const _MonthData({required this.days});
  final List<_MonthDayData> days;
}

class _MonthDayData {
  const _MonthDayData({
    required this.date,
    required this.hebrewParts,
    required this.hebrewDateString,
    required this.islamicDateString,
    required this.events,
    required this.prayerTimes,
  });
  final DateTime date;
  final HebrewDateParts? hebrewParts;
  final String? hebrewDateString;
  final String? islamicDateString;
  final List<_MonthEventItem> events;
  final List<PrayerTime> prayerTimes;
}

class _MonthEventItem {
  const _MonthEventItem({
    required this.title,
    required this.layerId,
    required this.sourceKey,
    required this.layerName,
    required this.layerColor,
    required this.timeLabel,
    required this.importance,
    required this.details,
  });
  final String title;
  final String layerId;
  final String sourceKey;
  final String layerName;
  final int layerColor;
  final String timeLabel;
  final int importance;
  final String details;
}

final _monthDataProvider = FutureProvider.family<_MonthData, DateTime>((ref, month) async {
  final monthStart = DateTime(month.year, month.month, 1);
  final profile = await ref.watch(defaultProfileProvider.future);
  if (profile == null) return const _MonthData(days: []);

  final strings = ref.watch(appStringsProvider);
  final layersRepo = ref.watch(layersRepoProvider);
  final calendarService = ref.watch(calendarServiceProvider);
  final prayerTimesService = ref.watch(prayerTimesServiceProvider);
  final enabledLayers = ref.watch(enabledLayersProvider).valueOrNull ?? const [];
  final layerById = {for (final layer in enabledLayers) layer.id: layer};

  final daysInMonth = DateTime(monthStart.year, monthStart.month + 1, 0).day;
  final days = <_MonthDayData>[];

  final hasHebrewLayer = enabledLayers.any((l) => l.id == 'layer_hebrew');
  final hasIslamicLayer = enabledLayers.any((l) => l.id == 'layer_islamic');

  for (var dayNumber = 1; dayNumber <= daysInMonth; dayNumber++) {
    final date = DateTime(monthStart.year, monthStart.month, dayNumber);
    final dayEvents = calendarService.getEventsForDate(date, profile.countryCode, enabledLayers);
    final events = dayEvents.map((event) {
      final layer = layerById[event.layerId];
      
      // Attempt holiday translation
      String displayTitle = event.title;
      if (event.sourceKey.isNotEmpty) {
        final keyBody = event.sourceKey.split('_').first;
        final holidayKey = 'event_$keyBody';
        final localizedTitle = strings.t(holidayKey);
        if (localizedTitle != holidayKey) {
          displayTitle = localizedTitle;
        }
      }

      return _MonthEventItem(
        title: displayTitle,
        layerId: event.layerId,
        sourceKey: event.sourceKey,
        layerName: _localizedLayerName(event.layerId, strings, fallback: layer?.displayName ?? event.layerId),
        layerColor: layer?.color ?? 0xFF9E9E9E,
        timeLabel: event.allDay ? strings.t('home_all_day') : '${event.startTime ?? '--:--'} - ${event.endTime ?? '--:--'}',
        importance: event.importance,
        details: event.details,
      );
    }).toList()..sort((a, b) => b.importance.compareTo(a.importance));

    final prayerTimes = <PrayerTime>[];
    if (hasHebrewLayer) {
      final res = await prayerTimesService.getDailyTimes(
        PrayerTimesRequest(
          profileId: profile.id,
          date: date,
          latitude: profile.lat,
          longitude: profile.lon,
          timezone: profile.timezone,
          elevation: profile.elevation,
          jewishMethod: JewishMethod.itimLeBinah,
        ),
      );
      prayerTimes.addAll(res.times);
    }

    days.add(_MonthDayData(
      date: date,
      hebrewParts: hasHebrewLayer ? calendarService.getHebrewDateParts(date, profile.countryCode) : null,
      hebrewDateString: hasHebrewLayer ? calendarService.getHebrewDateString(date, profile.countryCode) : null,
      islamicDateString: hasIslamicLayer ? calendarService.getIslamicDateString(date) : null,
      events: events,
      prayerTimes: prayerTimes,
    ));
  }
  return _MonthData(days: days);
});

_MonthDayData? _findDayData(List<_MonthDayData> days, DateTime date) {
  for (final day in days) {
    if (_isSameDate(day.date, date)) return day;
  }
  return null;
}

bool _isSameDate(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String _localizedLayerName(String layerId, AppStrings strings, {required String fallback}) {
  switch (layerId) {
    case 'layer_hebrew': return strings.t('layer_hebrew');
    case 'layer_islamic': return strings.t('layer_islamic');
    case 'layer_christian': return strings.t('layer_christian');
    case 'layer_national': return strings.t('layer_national');
    default: return fallback;
  }
}

String _localizedPrayerName(String canonicalName, AppStrings strings) {
  switch (canonicalName) {
    case 'Alot Hashachar': return strings.t('prayer_alot_hashachar');
    case 'Alot Hashachar (Itim LeBinah)': return strings.t('prayer_alot_hashachar_itim');
    case 'Misheyakir (Itim LeBinah)': return strings.t('prayer_misheyakir_itim');
    case 'Sunrise':
    case 'Sunrise (Netz)': return strings.t('prayer_sunrise');
    case 'Sof Zman Shema (GRA)': return strings.t('prayer_sof_zman_shema_gra');
    case 'Sof Zman Shema (MGA)': return strings.t('prayer_sof_zman_shema_mga');
    case 'Sof Zman Tefila (GRA)': return strings.t('prayer_sof_zman_tefila_gra');
    case 'Sof Zman Tefila (MGA)': return strings.t('prayer_sof_zman_tefila_mga');
    case 'Chatzot':
    case 'Chatzot (Noon)': return strings.t('prayer_chatzot');
    case 'Mincha Gedola': return strings.t('prayer_mincha_gedola');
    case 'Mincha Ketana': return strings.t('prayer_mincha_ketana');
    case 'Plag Hamincha': return strings.t('prayer_plag_hamincha');
    case 'Sunset': return strings.t('prayer_sunset');
    case 'Tzeit Hakochavim': return strings.t('prayer_tzeit_hakochavim');
    case 'Tzeit Hakochavim (Itim LeBinah)': return strings.t('prayer_tzeit_hakochavim_itim');
    case 'Alot Hashachar (Custom)': return '${strings.t('prayer_alot_hashachar')} (${strings.t('common_custom')})';
    case 'Sunrise (Custom)': return '${strings.t('prayer_sunrise')} (${strings.t('common_custom')})';
    case 'Sof Zman Shema (Custom)': return '${strings.t('prayer_sof_zman_shema_gra')} (${strings.t('common_custom')})';
    case 'Sof Zman Tefila (Custom)': return '${strings.t('prayer_sof_zman_tefila_gra')} (${strings.t('common_custom')})';
    case 'Chatzot (Custom)': return '${strings.t('prayer_chatzot')} (${strings.t('common_custom')})';
    case 'Mincha Gedola (Custom)': return '${strings.t('prayer_mincha_gedola')} (${strings.t('common_custom')})';
    case 'Mincha Ketana (Custom)': return '${strings.t('prayer_mincha_ketana')} (${strings.t('common_custom')})';
    case 'Plag Hamincha (Custom)': return '${strings.t('prayer_plag_hamincha')} (${strings.t('common_custom')})';
    case 'Sunset (Custom)': return '${strings.t('prayer_sunset')} (${strings.t('common_custom')})';
    case 'Tzeit Hakochavim (Custom)': return '${strings.t('prayer_tzeit_hakochavim')} (${strings.t('common_custom')})';
    case 'Candle Lighting': return strings.t('prayer_candle_lighting');
    default: return canonicalName;
  }
}
