import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import 'glow_card.dart';
import 'pulse_dot.dart';
import 'skill_chip.dart';

/// One job: role, company, dates, bullets and tech tags. The current role
/// gets a gradient border and a live "Present" badge.
class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.item});

  final Experience item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final vibe = Vibe.of(context);

    return GlowCard(
      highlight: item.current,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: Space.md,
            runSpacing: Space.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '${item.start} → ${item.end}',
                style: vibe.mono.copyWith(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              if (item.current) const _PresentBadge(),
            ],
          ),
          const SizedBox(height: Space.sm),
          Semantics(
            header: true,
            child: Text(item.role, style: text.titleLarge),
          ),
          const SizedBox(height: Space.xs),
          Text(
            item.company,
            style: text.titleMedium?.copyWith(color: scheme.primary),
          ),
          const SizedBox(height: Space.md),
          for (final bullet in item.bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: Space.sm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: Space.md),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      size: 18,
                      color: vibe.accent,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bullet,
                      style: text.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: Space.sm),
          ChipWrap(labels: item.tags, dense: true),
        ],
      ),
    );
  }
}

class _PresentBadge extends StatelessWidget {
  const _PresentBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vibe = Vibe.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.sm + 2,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: vibe.accent.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(color: vibe.accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulseDot(color: vibe.accent, size: 7),
          const SizedBox(width: Space.sm),
          Text(
            'Present',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
