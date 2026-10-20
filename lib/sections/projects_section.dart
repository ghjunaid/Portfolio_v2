import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../widgets/project_card.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';

/// Grid of project cards: 1 column on phones, 2 on tablets, 3 on desktop.
/// Cards in the same row share a height.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Breakpoints.widthOf(context);
    final columns = width < Breakpoints.tablet
        ? 1
        : width < Breakpoints.desktop
            ? 2
            : 3;

    final rows = <Widget>[];
    for (var start = 0; start < projects.length; start += columns) {
      final rowItems = projects.skip(start).take(columns).toList();
      if (rows.isNotEmpty) rows.add(const SizedBox(height: Space.lg));

      if (columns == 1) {
        rows.add(Reveal(child: ProjectCard(project: rowItems.single)));
        continue;
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) const SizedBox(width: Space.lg),
                Expanded(
                  child: c < rowItems.length
                      ? Reveal(
                          delay: Duration(milliseconds: 80 * c),
                          child: ProjectCard(
                            project: rowItems[c],
                            fillHeight: true,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return Section(navId: 'projects', child: Column(children: rows));
  }
}
