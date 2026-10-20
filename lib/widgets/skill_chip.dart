import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Pill-shaped label for a skill or tech tag. No ratings, by design.
class SkillChip extends StatelessWidget {
  const SkillChip({super.key, required this.label, this.dense = false});

  final String label;

  /// Smaller variant for tech tags inside cards.
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? Space.sm + Space.xs : Space.md,
        vertical: dense ? Space.xs + 2 : Space.sm + 2,
      ),
      decoration: BoxDecoration(
        color: dense ? scheme.primaryContainer.withValues(alpha: 0.6) : scheme.surfaceContainer,
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(
          color: dense ? Colors.transparent : scheme.outlineVariant,
        ),
      ),
      child: Text(
        label,
        style: (dense ? theme.textTheme.labelMedium : theme.textTheme.bodyMedium)
            ?.copyWith(
          color: dense ? scheme.onPrimaryContainer : scheme.onSurface,
          height: 1.2,
        ),
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
