import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'tech_icons.dart';

/// Pill-shaped label for a skill or tech tag, with the tech's logo when one
/// is known. No ratings, by design.
class SkillChip extends StatelessWidget {
  const SkillChip({super.key, required this.label, this.dense = false});

  final String label;

  /// Smaller variant for tech tags inside cards.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final tech = techIconFor(label);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? Space.sm + Space.xs : Space.md,
        vertical: dense ? Space.xs + 2 : Space.sm + 2,
      ),
      decoration: BoxDecoration(
        color: dense ? vibe.accent.withValues(alpha: 0.1) : vibe.glass,
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(
          color: dense ? vibe.accent.withValues(alpha: 0.2) : vibe.glassBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tech != null) ...[
            Icon(
              tech.icon,
              size: dense ? 13 : 16,
              color: dense
                  ? scheme.primary
                  : techIconColor(tech, scheme.onSurface, theme.brightness),
            ),
            SizedBox(width: dense ? Space.xs + 2 : Space.sm),
          ],
          // Flexible so a long label wraps instead of overflowing a narrow
          // card.
          Flexible(
            child: Text(
              label,
              style:
                  (dense
                          ? vibe.mono.copyWith(fontSize: 13)
                          : theme.textTheme.bodyMedium)
                      ?.copyWith(
                        color: dense ? scheme.primary : scheme.onSurface,
                        height: 1.2,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Wraps a list of tags into rows of [SkillChip]s.
class ChipWrap extends StatelessWidget {
  const ChipWrap({super.key, required this.labels, this.dense = false});

  final List<String> labels;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Space.sm,
      runSpacing: Space.sm,
      children: [
        for (final label in labels) SkillChip(label: label, dense: dense),
      ],
    );
  }
}
