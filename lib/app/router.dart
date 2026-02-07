import 'package:go_router/go_router.dart';

import '../features/home/home_screen.dart';
import '../features/layers/layers_screen.dart';
import '../features/month/month_screen.dart';
import '../features/profiles/profiles_screen.dart';
import '../features/settings/settings_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/month', builder: (_, __) => const MonthScreen()),
    GoRoute(path: '/layers', builder: (_, __) => const LayersScreen()),
    GoRoute(path: '/profiles', builder: (_, __) => const ProfilesScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
