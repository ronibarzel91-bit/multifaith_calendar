import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app/i18n.dart';
import '../../domain/models/enums.dart';
import '../../domain/services/prayer_times/prayer_times_service.dart';
import '../../providers.dart';

class HomeTodayData {
  const HomeTodayData({
    required this.profileName,
    required this.cityName,
    required this.date,
    required this.activeLayers,
    required this.prayerTimes,
    required this.events,
    this.hebrewDateString,
    this.islamicDateString,
  });

  final String profileName;
  final String cityName;
  final DateTime date;
  final List<HomeLayerInfo> activeLayers;
  final List<HomePrayerTimeItem> prayerTimes;
  final List<HomeEventItem> events;
  final String? hebrewDateString;
  final String? islamicDateString;
}

class HomeLayerInfo {
  const HomeLayerInfo({
    required this.name,
    required this.color,
  });

  final String name;
  final int color;
}

class HomePrayerTimeItem {
  const HomePrayerTimeItem({
    required this.name,
    required this.timeLabel,
    required this.isApproximate,
  });

  final String name;
  final String timeLabel;
  final bool isApproximate;
}

class HomeEventItem {
  const HomeEventItem({
    required this.title,
    required this.layerName,
    required this.layerColor,
    required this.allDay,
    required this.importance,
    this.startTime,
    this.endTime,
    this.details = '',
  });

  final String title;
  final String layerName;
  final int layerColor;
  final bool allDay;
  final int importance;
  final String? startTime;
  final String? endTime;
  final String details;
}

final homeTodayProvider = FutureProvider<HomeTodayData>((ref) async {
  final profile = await ref.watch(defaultProfileProvider.future);
  if (profile == null) {
    return HomeTodayData(
      profileName: '-',
      cityName: '-',
      date: DateTime.now(),
      activeLayers: const [],
      prayerTimes: const [],
      events: const [],
    );
  }

  final layersRepo = ref.watch(layersRepoProvider);
  final cacheRepo = ref.watch(cacheRepoProvider);
  final calendarService = ref.watch(calendarServiceProvider);
  final prayerTimesService = ref.watch(prayerTimesServiceProvider);
  final strings = ref.watch(appStringsProvider);
  final language = ref.watch(appLanguageProvider).valueOrNull ?? AppLanguage.english;

  final enabledLayers = ref.watch(enabledLayersProvider).valueOrNull ?? const [];
  final now = DateTime.now();
  final todayDate = DateTime(now.year, now.month, now.day);

  final computedEvents = calendarService.getEventsForDate(
    todayDate,
    profile.countryCode,
    enabledLayers,
  );
  if (computedEvents.isNotEmpty) {
    await cacheRepo.upsertEvents(profile.id, computedEvents);
  }
  final events = await cacheRepo.getEventsForDate(profile.id, todayDate);

  final layerById = {for (final l in enabledLayers) l.id: l};
  final rawCity = _cityNameFromTimezone(profile.timezone);
  final cityKey = 'city_${rawCity.toLowerCase().replaceAll(' ', '_')}';
  final cityName = strings.t(cityKey);
  if (cityName == cityKey) { // Fallback if no translation found
    // Optionally keep rawCity or do nothing
  }

  final activeLayers = enabledLayers
      .map(
        (layer) => HomeLayerInfo(
          name: _localizedLayerName(layer.id, strings, fallback: layer.displayName),
          color: layer.color,
        ),
      )
      .toList();

  final hasHebrewLayer = enabledLayers.any((layer) => layer.id == 'layer_hebrew');
  final hasIslamicLayer = enabledLayers.any((layer) => layer.id == 'layer_islamic');

  final prayerTimes = <HomePrayerTimeItem>[];
  if (hasHebrewLayer) {
    final prayerTimesResult = await prayerTimesService.getDailyTimes(
      PrayerTimesRequest(
        profileId: profile.id,
        date: todayDate,
        latitude: profile.lat,
        longitude: profile.lon,
        timezone: profile.timezone,
        elevation: profile.elevation,
        jewishMethod: JewishMethod.itimLeBinah,
      ),
    );
    final timeFormatter = DateFormat('HH:mm', language.code);
    prayerTimes.addAll(
      prayerTimesResult.times.map(
        (time) => HomePrayerTimeItem(
          name: _localizedPrayerName(time.name, strings),
          timeLabel: timeFormatter.format(time.time),
          isApproximate: time.isApproximate,
        ),
      ),
    );
  }

  final eventItems = events.map((e) {
    final layer = layerById[e.layerId];
    
    // Attempt holiday translation
    String displayTitle = e.title;
    if (e.sourceKey.isNotEmpty) {
      final keyBody = e.sourceKey.split('_').first;
      final holidayKey = 'event_$keyBody';
      final localizedTitle = strings.t(holidayKey);
      if (localizedTitle != holidayKey) {
        displayTitle = localizedTitle;
      }
    }

    return HomeEventItem(
      title: displayTitle,
      layerName: _localizedLayerName(
        e.layerId,
        strings,
        fallback: layer?.displayName ?? e.layerId,
      ),
      layerColor: layer?.color ?? 0xFF9E9E9E,
      allDay: e.allDay,
      importance: e.importance,
      startTime: e.startTime,
      endTime: e.endTime,
      details: e.details,
    );
  }).toList();

  final hebrewDateString = hasHebrewLayer
      ? calendarService.getHebrewDateString(todayDate, profile.countryCode)
      : null;
  final islamicDateString = hasIslamicLayer
      ? calendarService.getIslamicDateString(todayDate)
      : null;

  return HomeTodayData(
    profileName: profile.name,
    cityName: cityName,
    date: todayDate,
    activeLayers: activeLayers,
    prayerTimes: prayerTimes,
    events: eventItems,
    hebrewDateString: hebrewDateString,
    islamicDateString: islamicDateString,
  );
});

String _cityNameFromTimezone(String timezone) {
  final normalized = timezone.trim();
  if (normalized.isEmpty) return '-';
  if (!normalized.contains('/')) return normalized;
  final cityPart = normalized.split('/').last;
  return cityPart.replaceAll('_', ' ');
}

String _localizedLayerName(
  String layerId,
  AppStrings strings, {
  required String fallback,
}) {
  switch (layerId) {
    case 'layer_hebrew':
      return strings.t('layer_hebrew');
    case 'layer_islamic':
      return strings.t('layer_islamic');
    case 'layer_christian':
      return strings.t('layer_christian');
    case 'layer_national':
      return strings.t('layer_national');
    default:
      return fallback;
  }
}

String _localizedPrayerName(String canonicalName, AppStrings strings) {
  switch (canonicalName) {
    case 'Alot Hashachar':
      return strings.t('prayer_alot_hashachar');
    case 'Alot Hashachar (Itim LeBinah)':
      return strings.t('prayer_alot_hashachar_itim');
    case 'Misheyakir (Itim LeBinah)':
      return strings.t('prayer_misheyakir_itim');
    case 'Sunrise':
    case 'Sunrise (Netz)':
      return strings.t('prayer_sunrise');
    case 'Sof Zman Shema (GRA)':
      return strings.t('prayer_sof_zman_shema_gra');
    case 'Sof Zman Shema (MGA)':
      return strings.t('prayer_sof_zman_shema_mga');
    case 'Sof Zman Tefila (GRA)':
      return strings.t('prayer_sof_zman_tefila_gra');
    case 'Sof Zman Tefila (MGA)':
      return strings.t('prayer_sof_zman_tefila_mga');
    case 'Chatzot':
    case 'Chatzot (Noon)':
      return strings.t('prayer_chatzot');
    case 'Mincha Gedola':
      return strings.t('prayer_mincha_gedola');
    case 'Mincha Ketana':
      return strings.t('prayer_mincha_ketana');
    case 'Plag Hamincha':
      return strings.t('prayer_plag_hamincha');
    case 'Sunset':
      return strings.t('prayer_sunset');
    case 'Tzeit Hakochavim':
      return strings.t('prayer_tzeit_hakochavim');
    case 'Tzeit Hakochavim (Itim LeBinah)':
      return strings.t('prayer_tzeit_hakochavim_itim');
    case 'Alot Hashachar (Custom)':
      return '${strings.t('prayer_alot_hashachar')} (${strings.t('common_custom')})';
    case 'Sunrise (Custom)':
      return '${strings.t('prayer_sunrise')} (${strings.t('common_custom')})';
    case 'Sof Zman Shema (Custom)':
      return '${strings.t('prayer_sof_zman_shema_gra')} (${strings.t('common_custom')})';
    case 'Sof Zman Tefila (Custom)':
      return '${strings.t('prayer_sof_zman_tefila_gra')} (${strings.t('common_custom')})';
    case 'Chatzot (Custom)':
      return '${strings.t('prayer_chatzot')} (${strings.t('common_custom')})';
    case 'Mincha Gedola (Custom)':
      return '${strings.t('prayer_mincha_gedola')} (${strings.t('common_custom')})';
    case 'Mincha Ketana (Custom)':
      return '${strings.t('prayer_mincha_ketana')} (${strings.t('common_custom')})';
    case 'Plag Hamincha (Custom)':
      return '${strings.t('prayer_plag_hamincha')} (${strings.t('common_custom')})';
    case 'Sunset (Custom)':
      return '${strings.t('prayer_sunset')} (${strings.t('common_custom')})';
    case 'Tzeit Hakochavim (Custom)':
      return '${strings.t('prayer_tzeit_hakochavim')} (${strings.t('common_custom')})';
    case 'Candle Lighting':
      return strings.t('prayer_candle_lighting');
    default:
      return canonicalName;
  }
}
