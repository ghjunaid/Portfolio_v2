import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Section title with a terminal-style label above it (`02 // experience`),
/// a gradient rule, and an optional tagline below.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.index,
    required this.title,
    this.tagline = '',
  });

  final int index;
  final String title;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vibe = Vibe.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: Space.xl + Space.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExcludeSemantics(
            child: Row(
              children: [
                Text(
                  '${index.toString().padLeft(2, '0')} // ${title.toLowerCase()}',
                  style: vibe.mono.copyWith(fontSize: 14, color: vibe.accent),
                ),
                const SizedBox(width: Space.md),
                Container(
                  width: 48,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [vibe.accent, vibe.accent2.withValues(alpha: 0)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Space.sm),
          Semantics(
            header: true,
            child: Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 40),
            ),
          ),
          if (tagline.isNotEmpty) ...[
            const SizedBox(height: Space.xs),
            Text(
              tagline,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
