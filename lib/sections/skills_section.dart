import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';
import '../widgets/skill_chip.dart';

/// Skill groups as chip rows. The group name sits beside its chips on wide
/// screens and above them on phones.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sideBySide = Breakpoints.widthOf(context) >= Breakpoints.nav;

    return Section(
      navId: 'skills',
      child: Column(
        children: [
          for (final (i, group) in skillGroups.indexed)
            Reveal(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Space.lg),
                decoration: BoxDecoration(
                  border: Border(
                    top: i == 0
                        ? BorderSide.none
                        : BorderSide(color: scheme.outlineVariant),
                  ),
                ),
                child: Flex(
                  direction: sideBySide ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sideBySide ? 220 : double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: sideBySide ? Space.sm : 0,
                          bottom: sideBySide ? 0 : Space.md,
                        ),
                        child: Semantics(
                          header: true,
                          child: Text(
                            group.name,
                            style: theme.textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                    if (sideBySide)
                      Expanded(child: ChipWrap(labels: group.skills))
                    else
                      ChipWrap(labels: group.skills),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
