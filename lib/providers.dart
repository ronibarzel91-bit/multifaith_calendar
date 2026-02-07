import 'dart:async';

import 'app/i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/db/app_db.dart';
import 'data/repositories/cache_repo.dart';
import 'data/repositories/cities_repo.dart';
import 'data/repositories/layers_repo.dart';
import 'data/repositories/profiles_repo.dart';
import 'data/repositories/settings_repo.dart';
import 'domain/services/calendar_service.dart';
import 'domain/services/prayer_times/prayer_times_service.dart';

final dbProvider = Provider<AppDatabase>((ref) => AppDatabase());

final profilesRepoProvider = Provider<ProfilesRepo>((ref) {
  return ProfilesRepo(ref.watch(dbProvider));
});

final layersRepoProvider = Provider<LayersRepo>((ref) {
  return LayersRepo(ref.watch(dbProvider));
});

final cacheRepoProvider = Provider<CacheRepo>((ref) {
  return CacheRepo(ref.watch(dbProvider));
});

final settingsRepoProvider = Provider<SettingsRepo>((ref) {
  return SettingsRepo(ref.watch(dbProvider));
});

final citiesRepoProvider = Provider<CitiesRepo>((ref) {
  return CitiesRepo(ref.watch(dbProvider));
});

final calendarServiceProvider = Provider<CalendarService>((ref) {
  return CalendarService();
});

final prayerTimesServiceProvider = Provider<PrayerTimesService>((ref) {
  return KosherPrayerTimesService(ref.watch(dbProvider));
});

final bootstrapProvider = FutureProvider<void>((ref) async {
  final profilesRepo = ref.watch(profilesRepoProvider);
  final layersRepo = ref.watch(layersRepoProvider);
  final citiesRepo = ref.watch(citiesRepoProvider);
  await (() async {
    await citiesRepo.seedDefaultCitiesIfMissing();
    final profileId = await profilesRepo.createDefaultProfileIfMissing();
    await layersRepo.seedDefaultLayersIfMissing();
    await layersRepo.ensureProfileHasLayers(profileId);
  }()).timeout(
    const Duration(seconds: 15),
    onTimeout: () => throw TimeoutException('אתחול נתקע – ייתכן שהמסד נתונים לא נטען'),
  );
});

final defaultProfileProvider = FutureProvider<Profile?>((ref) async {
  await ref.watch(bootstrapProvider.future);
  return ref.watch(profilesRepoProvider).getDefaultProfile();
});

final appLanguageProvider = FutureProvider<AppLanguage>((ref) async {
  await ref.watch(bootstrapProvider.future);
  final profile = await ref.watch(profilesRepoProvider).getDefaultProfile();
  if (profile == null) return AppLanguage.english;
  return ref.watch(settingsRepoProvider).getLanguageForProfile(profile.id);
});

final enabledLayersProvider = StreamProvider<List<Layer>>((ref) async* {
  final profile = await ref.watch(defaultProfileProvider.future);
  if (profile == null) {
    yield const [];
    return;
  }
  yield* ref.watch(layersRepoProvider).watchEnabledLayersForProfile(profile.id);
});

final appStringsProvider = Provider<AppStrings>((ref) {
  final lang = ref.watch(appLanguageProvider).valueOrNull ?? AppLanguage.english;
  return AppStrings.of(lang);
});
