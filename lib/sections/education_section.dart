import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

/// Compact cards for degrees and certifications.
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sideBySide = Breakpoints.widthOf(context) >= Breakpoints.nav;

    final cards = <Widget>[
      for (final e in education)
        _InfoCard(
          icon: Icons.school_outlined,
          kind: 'Degree',
          title: e.degree,
          subtitle: e.institution,
          meta: '${e.start} – ${e.end}',
        ),
      for (final c in certifications)
        _InfoCard(
          icon: Icons.workspace_premium_outlined,
          kind: 'Certification',
          title: c.name,
          subtitle: c.issuer,
        ),
    ];

    return Section(
      navId: 'education',
      child: sideBySide
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, card) in cards.indexed) ...[
                    if (i > 0) const SizedBox(width: Space.lg),
                    Expanded(
                      child: Reveal(
                        delay: Duration(milliseconds: 80 * i),
                        child: card,
                      ),
                    ),
                  ],
                ],
              ),
            )
          : Column(
              children: [
                for (final (i, card) in cards.indexed) ...[
                  if (i > 0) const SizedBox(height: Space.lg),
                  Reveal(child: card),
                ],
              ],
            ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.kind,
    required this.title,
    required this.subtitle,
    this.meta,
  });

  final IconData icon;
  final String kind;
  final String title;
  final String subtitle;
  final String? meta;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Space.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Radii.lg),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: Icon(icon, color: scheme.onPrimaryContainer),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kind.toUpperCase(),
                  style: text.labelMedium?.copyWith(
                    color: scheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: Space.xs),
                Semantics(
                  header: true,
                  child: Text(title, style: text.titleMedium),
                ),
                const SizedBox(height: Space.xs),
                Text(
                  subtitle,
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                if (meta != null) ...[
                  const SizedBox(height: Space.xs),
                  Text(
                    meta!,
                    style: text.labelMedium?.copyWith(
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
