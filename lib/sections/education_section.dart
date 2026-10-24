import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/equal_height_grid.dart';
import '../widgets/glow_card.dart';
import '../widgets/section.dart';

/// Compact cards for degrees, certifications and workshops.
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sideBySide = Breakpoints.widthOf(context) >= Breakpoints.nav;

    final cards = <Widget>[
      for (final e in education)
        _InfoCard(
          icon: Icons.school_rounded,
          kind: 'degree',
          title: e.degree,
          subtitle: e.institution,
          meta: e.start.isEmpty ? e.end : '${e.start} → ${e.end}',
        ),
      for (final c in certifications)
        _InfoCard(
          icon: Icons.workspace_premium_rounded,
          kind: 'certification',
          title: c.name,
          subtitle: c.issuer,
        ),
      for (final w in workshops)
        _InfoCard(icon: Icons.groups_rounded, kind: 'workshop', title: w),
    ];

    return Section(
      navId: 'education',
      child: EqualHeightGrid(
        columns: sideBySide ? 2 : 1,
        itemCount: cards.length,
        itemBuilder: (context, i, _) => cards[i],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.kind,
    required this.title,
    this.subtitle,
    this.meta,
  });

  final IconData icon;
  final String kind;
  final String title;
  final String? subtitle;
  final String? meta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final vibe = Vibe.of(context);

    return GlowCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: vibe.gradient,
              borderRadius: BorderRadius.circular(Radii.md),
              boxShadow: [
                BoxShadow(
                  color: vibe.accent.withValues(alpha: 0.3),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Icon(icon, color: scheme.onPrimary),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '// $kind',
                  style: vibe.mono.copyWith(fontSize: 13, color: vibe.accent),
                ),
                const SizedBox(height: Space.xs),
                Semantics(
                  header: true,
                  child: Text(title, style: text.titleMedium),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: Space.xs),
                  Text(
                    subtitle!,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (meta != null) ...[
                  const SizedBox(height: Space.xs),
                  Text(
                    meta!,
                    style: vibe.mono.copyWith(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
