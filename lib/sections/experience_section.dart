import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/experience_card.dart';
import '../widgets/pulse_dot.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

/// Stacked cards on small screens; a glowing vertical timeline from 768px up.
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
                ? _TimelineEntry(item: item, isLast: i == experience.length - 1)
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
    final vibe = Vibe.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                const SizedBox(height: Space.lg + 4),
                if (item.current)
                  Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: vibe.accent.withValues(alpha: 0.2),
                      boxShadow: [
                        BoxShadow(
                          color: vibe.accent.withValues(alpha: 0.6),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: PulseDot(color: vibe.accent, size: 10),
                  )
                else
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scheme.surface,
                      border: Border.all(color: vibe.accent2, width: 3),
                    ),
                  ),
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.only(top: Space.xs),
                    decoration: BoxDecoration(
                      gradient: isLast
                          ? null
                          : LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                vibe.accent.withValues(alpha: 0.7),
                                vibe.accent3.withValues(alpha: 0.2),
                              ],
                            ),
                    ),
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
