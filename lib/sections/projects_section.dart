import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../utils/breakpoints.dart';
import '../widgets/equal_height_grid.dart';
import '../widgets/project_card.dart';
import '../widgets/section.dart';

/// Grid of project cards: 1 column on phones, 2 on tablets, 3 on desktop.
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

    return Section(
      navId: 'projects',
      child: EqualHeightGrid(
        columns: columns,
        itemCount: projects.length,
        itemBuilder: (context, i, fill) =>
            ProjectCard(project: projects[i], index: i, fillHeight: fill),
      ),
    );
  }
}
