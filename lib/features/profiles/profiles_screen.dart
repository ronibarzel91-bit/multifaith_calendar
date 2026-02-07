import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/i18n.dart';
import '../../data/db/app_db.dart';
import '../../data/repositories/cities_repo.dart';
import '../../features/home/home_controller.dart';
import '../../providers.dart';

class ProfilesScreen extends ConsumerStatefulWidget {
  const ProfilesScreen({super.key});

  @override
  ConsumerState<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends ConsumerState<ProfilesScreen> {
  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(appStringsProvider);
    final profilesAsync = ref.watch(_profilesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.t('app_profiles')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openProfileDialog(),
        icon: const Icon(Icons.add_rounded),
        label: Text(strings.t('profiles_add'), style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ).animate().scale(delay: 400.ms, duration: 400.ms, curve: Curves.easeOutBack),
      body: profilesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${strings.t('common_error')}: $e')),
        data: (profiles) {
          if (profiles.isEmpty) {
            return Center(child: Text(strings.t('profiles_no_profiles')));
          }

          final defaultProfileId = _findDefaultId(profiles);

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 80),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              final isDefault = profile.id == defaultProfileId;

              return _ProfileModernCard(
                profile: profile,
                isDefault: isDefault,
                strings: ref.watch(appStringsProvider),
                onSetDefault: () => _setDefaultProfile(profile.id),
                onEdit: () => _openProfileDialog(profile: profile),
              ).animate().fadeIn(delay: (index * 100).ms, duration: 500.ms).slideX(begin: 0.05);
            },
          );
        },
      ),
    );
  }

  String? _findDefaultId(List<Profile> profiles) {
    for (final p in profiles) if (p.isDefault) return p.id;
    return null;
  }

  Future<void> _setDefaultProfile(String profileId) async {
    await ref.read(profilesRepoProvider).setDefaultProfile(profileId);
    ref.invalidate(defaultProfileProvider);
    ref.invalidate(homeTodayProvider);
  }

  Future<void> _openProfileDialog({Profile? profile}) async {
    final strings = ref.read(appStringsProvider);
    final profiles = await ref.read(profilesRepoProvider).getProfiles();
    final countries = ref.read(citiesRepoProvider).getSupportedCountries();

    if (countries.isEmpty) return;

    final nameController = TextEditingController(text: profile?.name ?? '');
    var selectedCountryCode = profile?.countryCode ?? countries.first.code;
    var cityOptions = await ref.read(citiesRepoProvider).getCitiesByCountry(selectedCountryCode);
    City? selectedCity = _resolveSelectedCity(profile, cityOptions);
    selectedCity ??= cityOptions.isNotEmpty ? cityOptions.first : null;
    var loadingCities = false;

    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    profile == null ? strings.t('profiles_add_title') : strings.t('profiles_edit_title'),
                    style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: strings.t('profiles_name')),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCountryCode,
                    items: countries.map((c) => DropdownMenuItem(value: c.code, child: Text('${strings.t('country_${c.code}')} (${c.code})'))).toList(),
                    decoration: InputDecoration(labelText: strings.t('profiles_country')),
                    onChanged: (value) async {
                      if (value == null) return;
                      setStateDialog(() { selectedCountryCode = value; loadingCities = true; });
                      final loaded = await ref.read(citiesRepoProvider).getCitiesByCountry(value);
                      setStateDialog(() { cityOptions = loaded; selectedCity = loaded.isNotEmpty ? loaded.first : null; loadingCities = false; });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (loadingCities) const Center(child: LinearProgressIndicator())
                  else DropdownButtonFormField<String>(
                    value: selectedCity?.id,
                    items: cityOptions.map((c) {
                      final cityKey = 'city_${c.name.toLowerCase().replaceAll(' ', '_')}';
                      return DropdownMenuItem(value: c.id, child: Text(strings.t(cityKey)));
                    }).toList(),
                    decoration: InputDecoration(labelText: strings.t('profiles_city')),
                    onChanged: (cityId) {
                      final picked = cityOptions.where((c) => c.id == cityId).firstOrNull;
                      if (picked != null) setStateDialog(() => selectedCity = picked);
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(strings.t('common_cancel')),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: loadingCities ? null : () async {
                          final name = nameController.text.trim();
                          if (name.isEmpty || selectedCity == null) return;
                          // Logic remains same...
                          if (profile == null) {
                            final createdId = await ref.read(profilesRepoProvider).createProfile(
                              name: name, countryCode: selectedCity!.countryCode, timezone: selectedCity!.timezone,
                              lat: selectedCity!.lat, lon: selectedCity!.lon, elevation: null, isDefault: profiles.isEmpty,
                            );
                            await ref.read(layersRepoProvider).ensureProfileHasLayers(createdId);
                          } else {
                            await ref.read(profilesRepoProvider).updateProfile(
                              profileId: profile.id, name: name, countryCode: selectedCity!.countryCode,
                              timezone: selectedCity!.timezone, lat: selectedCity!.lat, lon: selectedCity!.lon, elevation: profile.elevation,
                            );
                          }
                          ref.invalidate(defaultProfileProvider);
                          ref.invalidate(homeTodayProvider);
                          if (mounted) Navigator.pop(context);
                        },
                        child: Text(strings.t('common_save')),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  City? _resolveSelectedCity(Profile? profile, List<City> cityOptions) {
    if (profile == null) return null;
    return cityOptions.where((c) => c.timezone == profile.timezone && (c.lat - profile.lat).abs() < 0.02).firstOrNull;
  }
}

class _ProfileModernCard extends StatelessWidget {
  const _ProfileModernCard({required this.profile, required this.isDefault, required this.strings, required this.onSetDefault, required this.onEdit});
  final Profile profile;
  final bool isDefault;
  final AppStrings strings;
  final VoidCallback onSetDefault;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDefault ? Colors.white : const Color(0xFFF1F5F9).withOpacity(0.5),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: isDefault ? Theme.of(context).primaryColor : Colors.transparent, width: 2),
        boxShadow: isDefault ? [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4))] : null,
      ),
      child: InkWell(
        onTap: onSetDefault,
        borderRadius: BorderRadius.circular(28),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _DefaultIndicator(isDefault: isDefault),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(profile.name, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B))),
                    const SizedBox(height: 2),
                    Text(
                      '${strings.t('country_${profile.countryCode}')} • ${profile.timezone}',
                      style: GoogleFonts.outfit(fontSize: 13, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_note_rounded, color: Color(0xFF64748B)),
                onPressed: onEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultIndicator extends StatelessWidget {
  const _DefaultIndicator({required this.isDefault});
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isDefault ? Theme.of(context).primaryColor : const Color(0xFFCBD5E1), width: 2),
        color: isDefault ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: isDefault ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
    );
  }
}

final _profilesProvider = StreamProvider<List<Profile>>((ref) {
  return ref.watch(profilesRepoProvider).watchProfiles();
});
