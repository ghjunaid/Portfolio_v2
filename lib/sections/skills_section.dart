import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/equal_height_grid.dart';
import '../widgets/glow_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';
import '../widgets/skill_chip.dart';
import '../widgets/tech_marquee.dart';

/// Two logo marquees scrolling in opposite directions, then every skill
/// group as its own card.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Breakpoints.widthOf(context);
    final columns = width < Breakpoints.tablet
        ? 1
        : width < Breakpoints.desktop
        ? 2
        : 3;

    final all = [for (final g in skillGroups) ...g.skills];
    final rowA = [for (var i = 0; i < all.length; i += 2) all[i]];
    final rowB = [for (var i = 1; i < all.length; i += 2) all[i]];

    return Section(
      navId: 'skills',
      child: Column(
        children: [
          Reveal(child: TechMarquee(items: rowA)),
          const SizedBox(height: Space.sm),
          Reveal(child: TechMarquee(items: rowB, reverse: true)),
          const SizedBox(height: Space.xl),
          EqualHeightGrid(
            columns: columns,
            itemCount: skillGroups.length,
            itemBuilder: (context, i, _) => _GroupCard(index: i),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vibe = Vibe.of(context);
    final group = skillGroups[index];

    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: vibe.gradient,
                  borderRadius: BorderRadius.circular(Radii.md),
                ),
                child: Icon(
                  group.icon,
                  size: 22,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(group.name, style: theme.textTheme.titleMedium),
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          ChipWrap(labels: group.skills),
        ],
      ),
    );
  }
}
