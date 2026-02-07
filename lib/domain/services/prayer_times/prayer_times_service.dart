import '../../models/enums.dart';
import 'package:kosher_dart/kosher_dart.dart';
import 'solar_math.dart';
import 'custom_calc_zmanim.dart';
import 'dataset_importer.dart';
import '../../../data/db/app_db.dart';

class PrayerTimesRequest {
  const PrayerTimesRequest({
    required this.profileId,
    required this.date,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    this.elevation,
    this.jewishMethod = JewishMethod.gra,
    this.islamicMethod = IslamicMethod.mwl,
    this.asrMethod = AsrMethod.standard,
    this.highLatRule = HighLatRule.none,
    this.customParams,
  });

  final String profileId;
  final DateTime date;
  final double latitude;
  final double longitude;
  final String timezone;
  final double? elevation;

  final JewishMethod jewishMethod;
  final IslamicMethod islamicMethod;
  final AsrMethod asrMethod;
  final HighLatRule highLatRule;

  final Map<String, double>? customParams;
}

class PrayerTimesResult {
  const PrayerTimesResult({
    required this.date,
    required this.times,
  });

  final DateTime date;
  final List<PrayerTime> times;
}

class PrayerTime {
  const PrayerTime({
    required this.name,
    required this.time,
    this.isApproximate = false,
  });

  final String name;
  final DateTime time;
  final bool isApproximate;
}

abstract class PrayerTimesService {
  const PrayerTimesService();

  Future<PrayerTimesResult> getDailyTimes(PrayerTimesRequest request);
}

class KosherPrayerTimesService extends PrayerTimesService {
  final AppDatabase db;
  const KosherPrayerTimesService(this.db);

  static const Map<String, int> _timezoneOffsetMinutes = {
    'Asia/Jerusalem': 120,
    'America/New_York': -300,
    'America/Los_Angeles': -480,
    'America/Chicago': -360,
    'America/Toronto': -300,
    'America/Vancouver': -480,
    'America/Mexico_City': -360,
    'America/Sao_Paulo': -180,
    'America/Argentina/Buenos_Aires': -180,
    'America/Argentina/Cordoba': -180,
    'Europe/London': 0,
    'Europe/Paris': 60,
    'Europe/Berlin': 60,
    'Europe/Madrid': 60,
    'Europe/Rome': 60,
    'Europe/Amsterdam': 60,
    'Europe/Moscow': 180,
    'Europe/Istanbul': 180,
    'Africa/Cairo': 120,
    'Africa/Casablanca': 0,
    'Asia/Riyadh': 180,
    'Asia/Dubai': 240,
    'Asia/Amman': 120,
    'Asia/Kolkata': 330,
    'Asia/Karachi': 300,
    'Asia/Dhaka': 360,
    'Asia/Jakarta': 420,
    'Asia/Kuala_Lumpur': 480,
    'Asia/Shanghai': 480,
    'Asia/Tokyo': 540,
    'Asia/Seoul': 540,
    'Asia/Bangkok': 420,
    'Australia/Sydney': 600,
    'Australia/Melbourne': 600,
    'Pacific/Auckland': 720,
    'Africa/Johannesburg': 120,
    'Africa/Lagos': 60,
    'Africa/Nairobi': 180,
  };

  @override
  Future<PrayerTimesResult> getDailyTimes(PrayerTimesRequest request) async {
    final day = DateTime(request.date.year, request.date.month, request.date.day);
    final calendarDate = _resolveDateForTimezone(day, request.timezone);
    final geo = GeoLocation.setLocation(
      'Profile (${request.timezone})',
      request.latitude,
      request.longitude,
      calendarDate,
      request.elevation ?? 0,
    );
    final zmanim = ZmanimCalendar.intGeolocation(geo)..setCalendar(calendarDate);

    final times = <PrayerTime>[];
    void addTime(String name, DateTime? time) {
      if (time == null) return;
      times.add(PrayerTime(name: name, time: time));
    }

    // 0. Check for Dataset Overrides
    final importer = DatasetImporter(db);
    final overrides = await importer.getOverrides(request.profileId, calendarDate);
    
    // We will apply overrides later as we add times.
    DateTime? getOverriddenTime(String key, DateTime? original) {
      if (overrides == null || !overrides.containsKey(key)) return original;
      try {
        final timeStr = overrides[key]!; // HH:mm
        final parts = timeStr.split(':');
        return DateTime(
          calendarDate.year,
          calendarDate.month,
          calendarDate.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
      } catch (e) {
        return original;
      }
    }

    if (request.jewishMethod == JewishMethod.itimLeBinah) {
      // Itim LeBinah (Rabbi Mordechai Eliyahu) Implementation
      final sunrise = zmanim.getSunrise();
      final sunset = zmanim.getSunset();

      if (sunrise != null && sunset != null) {
        // Tzet: 20 minutes fixed after Sunset
        final tzet = sunset.add(const Duration(minutes: 20));
        
        // Alot (Dawn): Calculated such that Alot is 72 Zmaniyot minutes before Sunrise.
        // Formula derived: Alot = (Sunrise - 0.1 * Tzet) / 0.9 (using Day = Tzet - Alot)
        // We use milliseconds for calculation.
        final sunriseMs = sunrise.millisecondsSinceEpoch;
        final tzetMs = tzet.millisecondsSinceEpoch;
        final alotMs = (sunriseMs - 0.1 * tzetMs) / 0.9;
        final alot = DateTime.fromMillisecondsSinceEpoch(alotMs.round());

        // Day Lengths (Ms)
        final dayMGA = tzetMs - alotMs;
        final shaZmanitMGA = dayMGA / 12;
        
        final dayGRA = sunset.difference(sunrise).inMilliseconds.toDouble();
        final shaZmanitGRA = dayGRA / 12;

        // Times
        addTime('Alot Hashachar (Itim LeBinah)', alot);
        addTime('Misheyakir (Itim LeBinah)', sunrise.subtract(const Duration(minutes: 60))); // ~60 min before Sunrise
        addTime('Sunrise (Netz)', sunrise);
        
        // Shema
        addTime('Sof Zman Shema (MGA)', alot.add(Duration(milliseconds: (3 * shaZmanitMGA).round())));
        addTime('Sof Zman Shema (GRA)', sunrise.add(Duration(milliseconds: (3 * shaZmanitGRA).round())));
        
        // Tefila
        addTime('Sof Zman Tefila (MGA)', alot.add(Duration(milliseconds: (4 * shaZmanitMGA).round())));
        addTime('Sof Zman Tefila (GRA)', sunrise.add(Duration(milliseconds: (4 * shaZmanitGRA).round())));

        // Chatzot
        addTime('Chatzot (Noon)', sunrise.add(Duration(milliseconds: (6 * shaZmanitGRA).round())));
        
        // Mincha
        addTime('Mincha Gedola', sunrise.add(Duration(milliseconds: (6.5 * shaZmanitGRA).round())));
        addTime('Plag Hamincha', sunrise.add(Duration(milliseconds: (10.75 * shaZmanitGRA).round())));
        
        addTime('Sunset', sunset);
        addTime('Tzeit Hakochavim (Itim LeBinah)', tzet);
      } else {
        // Fallback if no sunrise/sunset (polar regions)
        addTime('Sunrise', sunrise);
        addTime('Sunset', sunset);
      }
    } else if (request.jewishMethod == JewishMethod.customCalc) {
      // Custom Calculation Implementation
      final params = CustomCalcParams(
        latitude: request.latitude,
        longitude: request.longitude,
        elevation: request.elevation ?? 0.0,
        solarAngleSunrise: request.customParams?['solarAngleSunrise'] ?? -0.833,
        solarAngleSunset: request.customParams?['solarAngleSunset'] ?? -0.833,
        solarAngleAlos: request.customParams?['solarAngleAlos'],
        solarAngleTzeit: request.customParams?['solarAngleTzeit'],
        offsetAlosMinutes: request.customParams?['offsetAlosMinutes']?.round(),
        offsetTzeitMinutes: request.customParams?['offsetTzeitMinutes']?.round(),
        isMGA: request.customParams?['zmaniyotMethod'] == 1.0,
      );

      final customTimes = CustomCalcZmanim.calculate(calendarDate, params);

      addTime('Alot Hashachar (Custom)', customTimes.alos);
      addTime('Sunrise (Custom)', customTimes.sunrise);
      addTime('Sof Zman Shema (Custom)', customTimes.sofZmanShema);
      addTime('Sof Zman Tefila (Custom)', customTimes.sofZmanTefila);
      addTime('Chatzot (Custom)', customTimes.chatzot);
      addTime('Mincha Gedola (Custom)', customTimes.minchaGedola);
      addTime('Mincha Ketana (Custom)', customTimes.minchaKetana);
      addTime('Plag Hamincha (Custom)', customTimes.plagHamincha);
      addTime('Sunset (Custom)', customTimes.sunset);
      addTime('Tzeit Hakochavim (Custom)', customTimes.tzeit);
    } else {
      // Default (GRA/Stack)
      addTime('Alot Hashachar', zmanim.getAlosHashachar());
      addTime('Sunrise', zmanim.getSunrise());
      addTime('Sof Zman Shema (GRA)', zmanim.getSofZmanShmaGRA());
      addTime('Sof Zman Tefila (GRA)', zmanim.getSofZmanTfilaGRA());
      addTime('Chatzot', zmanim.getChatzos());
      addTime('Mincha Gedola', zmanim.getMinchaGedola());
      addTime('Mincha Ketana', zmanim.getMinchaKetana());
      addTime('Plag Hamincha', zmanim.getPlagHamincha());
      addTime('Sunset', zmanim.getSunset());
      addTime('Tzeit Hakochavim', zmanim.getTzais());
    }
    
    // Always add Candle Lighting if Friday
    if (calendarDate.weekday == DateTime.friday) {
       addTime('Candle Lighting', zmanim.getCandleLighting());
    }

    times.sort((a, b) => a.time.compareTo(b.time));

    return PrayerTimesResult(
      date: day,
      times: times,
    );
  }

  DateTime _resolveDateForTimezone(DateTime day, String timezone) {
    final tz = timezone.trim();
    if (tz.isEmpty) return day;
    if (tz.toUpperCase() == 'UTC') return day.toUtc();

    final utcOffsetMatch =
        RegExp(r'^UTC([+-])(\d{1,2})(?::?(\d{2}))?$').firstMatch(tz);
    if (utcOffsetMatch != null) {
      final sign = utcOffsetMatch.group(1) == '-' ? -1 : 1;
      final hours = int.tryParse(utcOffsetMatch.group(2) ?? '0') ?? 0;
      final minutes = int.tryParse(utcOffsetMatch.group(3) ?? '0') ?? 0;
      final offset = Duration(hours: sign * hours, minutes: sign * minutes);
      return day.toUtc().add(offset);
    }

    final knownOffset = _timezoneOffsetMinutes[tz];
    if (knownOffset != null) {
      return day.toUtc().add(Duration(minutes: knownOffset));
    }

    return day;
  }
}
