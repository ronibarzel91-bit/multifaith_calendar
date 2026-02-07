import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multifaith_calendar/features/home/home_controller.dart';
import 'package:multifaith_calendar/main.dart';
import 'package:multifaith_calendar/providers.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Bypass bootstrap initialization
          bootstrapProvider.overrideWith((ref) async {}),
          // Mock home data to avoid DB calls
          homeTodayProvider.overrideWith((ref) async {
            return HomeTodayData(
              profileName: 'Test Home',
              cityName: 'Test City',
              date: DateTime(2025, 1, 1),
              activeLayers: [],
              prayerTimes: [],
              events: [],
            );
          }),
        ],
        child: const App(),
      ),
    );

    // Allow async providers to load
    await tester.pumpAndSettle();

    // Verify Home Screen appears
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('פרופיל: Test Home'), findsOneWidget);
  });
}
