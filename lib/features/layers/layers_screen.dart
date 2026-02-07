import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/i18n.dart';
import '../../data/db/app_db.dart';
import '../../data/repositories/layers_repo.dart';
import '../../features/home/home_controller.dart';
import '../../providers.dart';

class LayersScreen extends ConsumerWidget {
  const LayersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);
    final async = ref.watch(_layersWithStateForDefaultProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.t('app_layers')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/'),
        ),
      ),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${strings.t('common_error')}: $e')),
        data: (data) {
          if (data == null || data.items.isEmpty) {
            return Center(child: Text(strings.t('layers_no_layers')));
          }
          final profile = data.profile;
          final list = data.items;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final item = list[i];
              final label = _localizedLayerName(
                item.layer.id,
                strings,
                fallback: item.layer.displayName,
              );
              return _LayerTile(
                layer: item.layer,
                label: label,
                isEnabled: item.isEnabled,
                onChanged: (value) async {
                  await ref.read(layersRepoProvider).setLayerEnabled(
                        profile.id,
                        item.layer.id,
                        value,
                      );
                  ref.invalidate(_layersWithStateForDefaultProfileProvider);
                  ref.invalidate(homeTodayProvider);
                },
              ).animate().fadeIn(delay: (i * 100).ms).slideX(begin: 0.1);
            },
          );
        },
      ),
    );
  }
}

class _DefaultProfileLayersData {
  const _DefaultProfileLayersData({
    required this.profile,
    required this.items,
  });
  final Profile profile;
  final List<LayerWithState> items;
}

final _layersWithStateForDefaultProfileProvider =
    FutureProvider<_DefaultProfileLayersData?>((ref) async {
  final profile = await ref.watch(defaultProfileProvider.future);
  if (profile == null) return null;
  final items =
      await ref.watch(layersRepoProvider).getLayersWithProfileState(profile.id);
  return _DefaultProfileLayersData(profile: profile, items: items);
});

class _LayerTile extends StatelessWidget {
  const _LayerTile({
    required this.layer,
    required this.label,
    required this.isEnabled,
    required this.onChanged,
  });

  final Layer layer;
  final String label;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(layer.color).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getLayerIcon(layer.id),
              color: Color(layer.color),
              size: 24,
            ),
          ),
          title: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          trailing: Switch.adaptive(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: Color(layer.color),
          ),
        ),
      ),
    );
  }

  IconData _getLayerIcon(String id) {
    switch (id) {
      case 'layer_hebrew': return Icons.auto_stories_rounded;
      case 'layer_islamic': return Icons.mosque_rounded;
      case 'layer_christian': return Icons.church_rounded;
      case 'layer_national': return Icons.flag_rounded;
      default: return Icons.layers_rounded;
    }
  }
}

String _localizedLayerName(
  String layerId,
  AppStrings strings, {
  required String fallback,
}) {
  switch (layerId) {
    case 'layer_hebrew': return strings.t('layer_hebrew');
    case 'layer_islamic': return strings.t('layer_islamic');
    case 'layer_christian': return strings.t('layer_christian');
    case 'layer_national': return strings.t('layer_national');
    default: return fallback;
  }
}

