import 'dart:math' as math;

/// A pure mathematical utility for solar calculations based on astronomical formulas.
class SolarMath {
  static const double pi = math.pi;
  static const double degToRad = pi / 180.0;
  static const double radToDeg = 180.0 / pi;

  /// Calculates the Julian Day for a given [DateTime].
  static double getJulianDay(DateTime date) {
    int year = date.year;
    int month = date.month;
    int day = date.day;

    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    int a = (year / 100).floor();
    int b = 2 - a + (a / 4).floor();

    double jd = (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        b -
        1524.5;
    
    // Add time component
    jd += (date.hour + (date.minute / 60.0) + (date.second / 3600.0)) / 24.0;
    
    return jd;
  }

  /// Calculates the Equation of Time (EOT) in minutes for a given Julian Day.
  static double getEquationOfTime(double jd) {
    double t = (jd - 2451545.0) / 36525.0;
    double l0 = 280.46646 + 36000.76983 * t + 0.0003032 * t * t;
    double m = 357.52911 + 35999.05029 * t - 0.0001537 * t * t;
    double e = 0.016708634 - 0.000042037 * t - 0.0000001267 * t * t;
    
    l0 = _normalizeDegrees(l0);
    m = _normalizeDegrees(m);

    double c = (1.914602 - 0.004817 * t - 0.000014 * t * t) * math.sin(m * degToRad) +
        (0.019993 - 0.000101 * t) * math.sin(2 * m * degToRad) +
        0.000289 * math.sin(3 * m * degToRad);

    double lambda = l0 + c;
    double r = 1.00014 - 0.01671 * math.cos(m * degToRad) - 0.00014 * math.cos(2 * m * degToRad);
    
    double epsilon = 23.439291 - 0.01300416 * t - 0.0000001639 * t * t + 0.0000005036 * t * t * t;
    double y = math.tan(epsilon / 2 * degToRad) * math.tan(epsilon / 2 * degToRad);

    double eot = y * math.sin(2 * l0 * degToRad) - 
        2 * e * math.sin(m * degToRad) + 
        4 * e * y * math.sin(m * degToRad) * math.cos(2 * l0 * degToRad) - 
        0.5 * y * y * math.sin(4 * l0 * degToRad) - 
        1.25 * e * e * math.sin(2 * m * degToRad);

    return eot * radToDeg * 4.0; // convert to minutes
  }

  /// Calculates Solar Declination in degrees for a given Julian Day.
  static double getSolarDeclination(double jd) {
    double t = (jd - 2451545.0) / 36525.0;
    double l0 = 280.46646 + 36000.76983 * t + 0.0003032 * t * t;
    double m = 357.52911 + 35999.05029 * t - 0.0001537 * t * t;
    
    l0 = _normalizeDegrees(l0);
    m = _normalizeDegrees(m);

    double c = (1.914602 - 0.004817 * t - 0.000014 * t * t) * math.sin(m * degToRad) +
        (0.019993 - 0.000101 * t) * math.sin(2 * m * degToRad) +
        0.000289 * math.sin(3 * m * degToRad);

    double lambda = l0 + c;
    double epsilon = 23.439291 - 0.01300416 * t - 0.0000001639 * t * t + 0.0000005036 * t * t * t;

    double delta = math.asin(math.sin(epsilon * degToRad) * math.sin(lambda * degToRad));
    return delta * radToDeg;
  }

  /// Calculates the Hour Angle for a given [lat], [declination], and [solarAngle].
  static double? getHourAngle(double lat, double declination, double solarAngle) {
    double phi = lat * degToRad;
    double delta = declination * degToRad;
    double h0 = solarAngle * degToRad;

    double cosH = (math.sin(h0) - math.sin(phi) * math.sin(delta)) /
        (math.cos(phi) * math.cos(delta));

    if (cosH > 1.0 || cosH < -1.0) {
      return null; // Sun doesn't reach this angle (polar regions)
    }

    return math.acos(cosH) * radToDeg;
  }

  static double _normalizeDegrees(double deg) {
    double result = deg % 360.0;
    if (result < 0) result += 360.0;
    return result;
  }

  /// Estimates Solar Noon (UTC minutes from start of day) for a given [jd] and [lon].
  static double getSolarNoon(double jd, double lon) {
    // Julian Day at 00:00 UTC for the given day
    double jd0 = (jd + 0.5).floor() - 0.5;
    double t = (jd0 - 2451545.0) / 36525.0;
    
    // Mean solar noon at Greenwich
    double solNoonUtc = 720 - (4 * lon) - getEquationOfTime(jd0);
    
    // Refine once
    double jdNoon = jd0 + solNoonUtc / 1440.0;
    solNoonUtc = 720 - (4 * lon) - getEquationOfTime(jdNoon);
    
    return solNoonUtc;
  }
}
