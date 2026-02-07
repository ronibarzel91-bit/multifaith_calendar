import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/i18n.dart';
import '../../providers.dart';
import 'home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(appStringsProvider);
    final todayAsync = ref.watch(homeTodayProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          _CircleActionButton(
            icon: Icons.calendar_month_rounded,
            onPressed: () => context.go('/month'),
          ),
          _CircleActionButton(
            icon: Icons.layers_rounded,
            onPressed: () => context.go('/layers'),
          ),
          _CircleActionButton(
            icon: Icons.person_rounded,
            onPressed: () => context.go('/profiles'),
          ),
          _CircleActionButton(
            icon: Icons.settings_rounded,
            onPressed: () => context.go('/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: todayAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${strings.t('common_error')}: $e')),
        data: (today) => _HomeBody(today: today, strings: strings),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 22),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({required this.today, required this.strings});
  final HomeTodayData today;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final dateLabel = DateFormat('EEEE, MMM d, y', localeTag).format(today.date);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withRed(50),
          ],
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 10),
            _HeaderSection(
              profileName: today.profileName,
              cityName: today.cityName,
              dateLabel: dateLabel,
              hebrewDate: today.hebrewDateString,
              islamicDate: today.islamicDateString,
              strings: strings,
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
            const SizedBox(height: 24),
            _PrayerTimesSection(prayerTimes: today.prayerTimes, strings: strings)
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideY(begin: 0.1),
            const SizedBox(height: 24),
            _EventsSection(events: today.events, strings: strings)
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.1),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({
    required this.profileName,
    required this.cityName,
    required this.dateLabel,
    required this.strings,
    this.hebrewDate,
    this.islamicDate,
  });

  final String profileName;
  final String cityName;
  final String dateLabel;
  final String? hebrewDate;
  final String? islamicDate;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateLabel,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profileName,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    cityName,
                    style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (hebrewDate != null || islamicDate != null)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                if (hebrewDate != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.t('label_hebrew'),
                          style: GoogleFonts.outfit(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          hebrewDate!,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (hebrewDate != null && islamicDate != null)
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.white.withOpacity(0.2),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                if (islamicDate != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.t('label_islamic'),
                          style: GoogleFonts.outfit(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          islamicDate!,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PrayerTimesSection extends StatelessWidget {
  const _PrayerTimesSection({required this.prayerTimes, required this.strings});
  final List<HomePrayerTimeItem> prayerTimes;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    if (prayerTimes.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time_filled_rounded,
                  color: Theme.of(context).colorScheme.primary, size: 20),
              const SizedBox(width: 10),
              Text(
                strings.t('home_prayer_times'),
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _PrayerTimesGrid(prayerTimes: prayerTimes, strings: strings),
        ],
      ),
    );
  }
}

class _PrayerTimesGrid extends StatelessWidget {
  const _PrayerTimesGrid({required this.prayerTimes, required this.strings});
  final List<HomePrayerTimeItem> prayerTimes;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 45,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: prayerTimes.length,
      itemBuilder: (context, index) {
        final time = prayerTimes[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  time.name,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                time.timeLabel,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: const Color(0xFF1E293B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EventsSection extends StatelessWidget {
  const _EventsSection({required this.events, required this.strings});
  final List<HomeEventItem> events;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            strings.t('app_layers'), // Using layers as section title
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...events.map((e) => _ModernEventCard(event: e, strings: strings)),
      ],
    );
  }
}

class _ModernEventCard extends StatelessWidget {
  const _ModernEventCard({required this.event, required this.strings});
  final HomeEventItem event;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: Color(event.layerColor),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${event.allDay ? strings.t('home_all_day') : '${event.startTime} - ${event.endTime}'} • ${event.layerName}',
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          if (event.importance > 0)
            const Icon(Icons.star_rounded, color: Color(0xFFD4AF37), size: 20),
        ],
      ),
    );
  }
}

