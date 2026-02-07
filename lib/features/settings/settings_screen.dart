import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/i18n.dart';
import '../../providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);
    final languageAsync = ref.watch(appLanguageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.t('app_settings')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: languageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('${strings.t('app_error_prefix')}: $e'),
        ),
        data: (selectedLanguage) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.t('settings_language_mode'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<AppLanguage>(
                        value: selectedLanguage,
                        decoration: InputDecoration(
                          labelText: strings.t('settings_language'),
                        ),
                        items: AppLanguage.values
                            .map(
                              (language) => DropdownMenuItem<AppLanguage>(
                                value: language,
                                child: Text(
                                  '${language.nativeName} (${language.code.toUpperCase()})',
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (language) async {
                          if (language == null) return;
                          final profile =
                              await ref.read(defaultProfileProvider.future);
                          if (profile == null) return;

                          await ref
                              .read(settingsRepoProvider)
                              .setLanguageForProfile(profile.id, language);
                          ref.invalidate(appLanguageProvider);

                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(strings.t('settings_saved')),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
