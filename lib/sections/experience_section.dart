import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/experience_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

/// Stacked cards on small screens; a vertical timeline from 768px up.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final timeline = Breakpoints.widthOf(context) >= Breakpoints.nav;

    return Section(
      navId: 'experience',
      child: Column(
        children: [
          for (final (i, item) in experience.indexed)
            timeline
                ? _TimelineEntry(
                    item: item,
                    isLast: i == experience.length - 1,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      bottom: i == experience.length - 1 ? 0 : Space.lg,
                    ),
                    child: Reveal(child: ExperienceCard(item: item)),
                  ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.item, required this.isLast});

  final Experience item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                const SizedBox(height: Space.lg + 4),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: item.current ? scheme.primary : scheme.surface,
                    border: Border.all(color: scheme.primary, width: 3),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? Colors.transparent : scheme.outlineVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : Space.lg),
              child: Reveal(child: ExperienceCard(item: item)),
            ),
          ),
        ],
      ),
    );
  }
}
