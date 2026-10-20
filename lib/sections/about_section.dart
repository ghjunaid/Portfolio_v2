import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wide = Breakpoints.isDesktop(context);

    final intro = Text(
      about.intro,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );

    final stats = LayoutBuilder(
      builder: (context, constraints) {
        final half = (constraints.maxWidth - Space.md) / 2;
        return Wrap(
          spacing: Space.md,
          runSpacing: Space.md,
          children: [
            for (final (i, stat) in about.stats.indexed)
              Reveal(
                delay: Duration(milliseconds: 80 * i),
                child: SizedBox(
                  // Short numbers sit two per row; longer values take a row.
                  width: stat.value.length <= 4 ? half : constraints.maxWidth,
                  child: _StatTile(stat: stat),
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
                const SizedBox(width: Space.xxl),
                Expanded(flex: 2, child: stats),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Reveal(child: intro),
                const SizedBox(height: Space.xl),
                stats,
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
    final scheme = theme.colorScheme;
    final short = stat.value.length <= 4;

    return Container(
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stat.value,
            style: (short
                    ? theme.textTheme.displaySmall
                    : theme.textTheme.titleLarge)
                ?.copyWith(color: scheme.primary),
          ),
          const SizedBox(height: Space.xs),
          Text(
            stat.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
