import 'package:flutter_test/flutter_test.dart';
import 'package:multifaith_calendar/domain/services/prayer_times/solar_math.dart';
import 'package:multifaith_calendar/domain/services/prayer_times/custom_calc_zmanim.dart';

void main() {
  group('SolarMath Engine Tests', () {
    test('Julian Day Calculation', () {
      final date = DateTime.utc(2026, 2, 7, 12, 0, 0);
      final jd = SolarMath.getJulianDay(date);
      expect(jd, closeTo(2461079.0, 0.1));
    });

    test('Sunrise/Sunset Calculation accuracy (Jerusalem approx)', () {
      // Jerusalem coordinates: 31.7683, 35.2137
      final date = DateTime(2026, 2, 7);
      final params = CustomCalcParams(
        latitude: 31.7683,
        longitude: 35.2137,
      );
      
      final times = CustomCalcZmanim.calculate(date, params);
      
      // Expected approx: 06:33, 17:19 (Jerusalem local time is UTC+2)
      // Note: calculations in CustomCalcZmanim are UTC-based then adjusted?
      // Actually, CustomCalcZmanim returns DateTimes in UTC because we passed dateUtc.
      
      expect(times.sunrise, isNotNull);
      expect(times.sunset, isNotNull);
      
      // Convert UTC to local (Jerusalem UTC+2)
      final sunriseLocal = times.sunrise!.toUtc().add(const Duration(hours: 2));
      final sunsetLocal = times.sunset!.toUtc().add(const Duration(hours: 2));
      
      print('Calculated Sunrise: $sunriseLocal');
      print('Calculated Sunset: $sunsetLocal');
      
      expect(sunriseLocal.hour, 6);
      expect(sunriseLocal.minute, closeTo(33, 3)); // allows 3 min tolerance
      
      expect(sunsetLocal.hour, 17);
      expect(sunsetLocal.minute, closeTo(19, 3));
    });
  });
}
