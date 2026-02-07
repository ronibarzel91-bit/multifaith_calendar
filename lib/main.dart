import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/i18n.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boot = ref.watch(bootstrapProvider);
    final lang = ref.watch(appLanguageProvider).valueOrNull ?? AppLanguage.english;
    final locale = lang.locale;
    final supportedLocales =
        AppLanguage.values.map((language) => language.locale).toList();
    const delegates = GlobalMaterialLocalizations.delegates;
    final strings = ref.watch(appStringsProvider);

    return boot.when(
      loading: () => MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: delegates,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(strings.t('app_loading')),
              ],
            ),
          ),
        ),
      ),
      error: (e, _) => MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: delegates,
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('${strings.t('app_error_prefix')}: $e'),
            ),
          ),
        ),
      ),
      data: (_) => MaterialApp.router(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: delegates,
        routerConfig: router,
      ),
    );
  }
}
