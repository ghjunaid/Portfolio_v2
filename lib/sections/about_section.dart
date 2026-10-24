import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/glow_card.dart';
import '../widgets/gradient_text.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

/// Bento layout: a large intro card beside stat tiles and a location tile.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final wide = Breakpoints.isDesktop(context);

    final intro = GlowCard(
      padding: const EdgeInsets.all(Space.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Text(
              '\$ whoami',
              style: vibe.mono.copyWith(fontSize: 14, color: vibe.accent),
            ),
          ),
          const SizedBox(height: Space.md),
          Text(profile.title, style: theme.textTheme.titleLarge),
          const SizedBox(height: Space.md),
          Text(
            about.intro,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );

    final tiles = LayoutBuilder(
      builder: (context, constraints) {
        final half = (constraints.maxWidth - Space.md) / 2;
        final shortCount = about.stats.where((s) => s.value.length <= 4).length;
        var shortSeen = 0;
        return Wrap(
          spacing: Space.md,
          runSpacing: Space.md,
          children: [
            for (final (i, stat) in about.stats.indexed)
              Reveal(
                delay: Duration(milliseconds: 90 * i),
                child: SizedBox(
                  // Short numbers sit two per row; longer values take a row,
                  // as does the last short one when it would sit alone.
                  width:
                      stat.value.length <= 4 &&
                          (++shortSeen < shortCount || shortCount.isEven)
                      ? half
                      : constraints.maxWidth,
                  child: _StatTile(stat: stat),
                ),
              ),
            Reveal(
              delay: Duration(milliseconds: 90 * about.stats.length),
              child: SizedBox(
                width: constraints.maxWidth,
                child: const _LocationTile(),
              ),
            ),
          ],
        );
      },
    );

    return Section(
      navId: 'about',
      child: wide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: Reveal(child: intro)),
                const SizedBox(width: Space.lg),
                Expanded(flex: 2, child: tiles),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Reveal(child: intro),
                const SizedBox(height: Space.md),
                tiles,
              ],
            ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final Stat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final short = stat.value.length <= 4;

    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            stat.value,
            style: short
                ? theme.textTheme.displaySmall?.copyWith(fontSize: 48)
                : theme.textTheme.titleLarge,
          ),
          const SizedBox(height: Space.xs),
          Text(
            stat.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  const _LocationTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vibe = Vibe.of(context);

    return GlowCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: vibe.gradient,
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'based in',
                  style: vibe.mono.copyWith(
                    fontSize: 13,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(profile.location, style: theme.textTheme.titleMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
