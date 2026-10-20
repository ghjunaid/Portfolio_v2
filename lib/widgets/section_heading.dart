import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Section title with a small numbered accent label above it, e.g.
/// `02 ——` / `Experience`.
class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.index, required this.title});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Row(
              children: [
                Text(
                  index.toString().padLeft(2, '0'),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.primary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(width: Space.sm),
                Container(width: 32, height: 2, color: scheme.primary),
              ],
            ),
          ),
          const SizedBox(height: Space.sm),
          Semantics(
            header: true,
            child: Text(title, style: theme.textTheme.headlineMedium),
          ),
        ],
      ),
    );
  }
}
