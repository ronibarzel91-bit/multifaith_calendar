import 'solar_math.dart';

class CustomCalcParams {
  final double latitude;
  final double longitude;
  final double elevation;
  final double solarAngleSunrise;
  final double solarAngleSunset;
  final double? solarAngleAlos;
  final double? solarAngleTzeit;
  final int? offsetAlosMinutes;
  final int? offsetTzeitMinutes;
  final bool isMGA; // false = GRA, true = MGA

  const CustomCalcParams({
    required this.latitude,
    required this.longitude,
    this.elevation = 0.0,
    this.solarAngleSunrise = -0.833,
    this.solarAngleSunset = -0.833,
    this.solarAngleAlos,
    this.solarAngleTzeit,
    this.offsetAlosMinutes,
    this.offsetTzeitMinutes,
    this.isMGA = false,
  });
}

class CustomCalcTimes {
  final DateTime? sunrise;
  final DateTime? sunset;
  final DateTime? alos;
  final DateTime? tzeit;
  final DateTime? chatzot;
  final DateTime? sofZmanShema;
  final DateTime? sofZmanTefila;
  final DateTime? minchaGedola;
  final DateTime? minchaKetana;
  final DateTime? plagHamincha;

  const CustomCalcTimes({
    this.sunrise,
    this.sunset,
    this.alos,
    this.tzeit,
    this.chatzot,
    this.sofZmanShema,
    this.sofZmanTefila,
    this.minchaGedola,
    this.minchaKetana,
    this.plagHamincha,
  });
}

class CustomCalcZmanim {
  static CustomCalcTimes calculate(DateTime date, CustomCalcParams params) {
    // 1. Julian Day for the given date at 12:00 UTC to avoid day boundary issues
    final dateUtc = DateTime.utc(date.year, date.month, date.day, 12, 0, 0);
    final jd = SolarMath.getJulianDay(dateUtc);

    // 2. Solar Noon (UTC minutes)
    final solarNoonUtc = SolarMath.getSolarNoon(jd, params.longitude);
    final declination = SolarMath.getSolarDeclination(jd);

    // 3. Sunrise & Sunset
    final sunrise = _getTimeAtAngle(dateUtc, solarNoonUtc, declination, params.latitude, params.solarAngleSunrise, true);
    final sunset = _getTimeAtAngle(dateUtc, solarNoonUtc, declination, params.latitude, params.solarAngleSunset, false);

    if (sunrise == null || sunset == null) {
      return const CustomCalcTimes(); // Polar regions
    }

    // 4. Alos & Tzeit
    DateTime? alos;
    if (params.solarAngleAlos != null) {
      alos = _getTimeAtAngle(dateUtc, solarNoonUtc, declination, params.latitude, params.solarAngleAlos!, true);
    } else if (params.offsetAlosMinutes != null) {
      alos = sunrise.subtract(Duration(minutes: params.offsetAlosMinutes!));
    }

    DateTime? tzeit;
    if (params.solarAngleTzeit != null) {
      tzeit = _getTimeAtAngle(dateUtc, solarNoonUtc, declination, params.latitude, params.solarAngleTzeit!, false);
    } else if (params.offsetTzeitMinutes != null) {
      tzeit = sunset.add(Duration(minutes: params.offsetTzeitMinutes!));
    }

    // 5. Derived Zmanim (Smaniyot)
    DateTime? chatzot;
    DateTime? sofZmanShema;
    DateTime? sofZmanTefila;
    DateTime? minchaGedola;
    DateTime? minchaKetana;
    DateTime? plagHamincha;

    final baseStart = params.isMGA ? (alos ?? sunrise) : sunrise;
    final baseEnd = params.isMGA ? (tzeit ?? sunset) : sunset;
    
    final dayLengthMs = baseEnd.difference(baseStart).inMilliseconds.toDouble();
    if (dayLengthMs > 0) {
      final shaZmanit = dayLengthMs / 12.0;
      
      chatzot = baseStart.add(Duration(milliseconds: (shaZmanit * 6).round()));
      sofZmanShema = baseStart.add(Duration(milliseconds: (shaZmanit * 3).round()));
      sofZmanTefila = baseStart.add(Duration(milliseconds: (shaZmanit * 4).round()));
      minchaGedola = baseStart.add(Duration(milliseconds: (shaZmanit * 6.5).round()));
      minchaKetana = baseStart.add(Duration(milliseconds: (shaZmanit * 9.5).round()));
      plagHamincha = baseStart.add(Duration(milliseconds: (shaZmanit * 10.75).round()));
    }

    return CustomCalcTimes(
      sunrise: sunrise,
      sunset: sunset,
      alos: alos,
      tzeit: tzeit,
      chatzot: chatzot,
      sofZmanShema: sofZmanShema,
      sofZmanTefila: sofZmanTefila,
      minchaGedola: minchaGedola,
      minchaKetana: minchaKetana,
      plagHamincha: plagHamincha,
    );
  }

  static DateTime? _getTimeAtAngle(DateTime dateUtc, double solarNoonUtc, double declination, double lat, double angle, bool isRising) {
    final ha = SolarMath.getHourAngle(lat, declination, angle);
    if (ha == null) return null;

    final minutesFromNoon = ha * 4.0; // 1 degree = 4 minutes
    final utcMinutes = isRising ? solarNoonUtc - minutesFromNoon : solarNoonUtc + minutesFromNoon;

    return dateUtc.subtract(const Duration(hours: 12)).add(Duration(minutes: utcMinutes.round()));
  }
}
