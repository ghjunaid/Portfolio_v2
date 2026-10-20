import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';

/// Centers content at a max width of 1200px with responsive side gutters
/// (16px on phones) and section spacing.
class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.vertical = true,
  });

  final Widget child;

  /// Adds the standard section padding above and below.
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final width = Breakpoints.widthOf(context);
    final gutter = Breakpoints.gutter(width);
    final verticalPad = !vertical
        ? 0.0
        : width < Breakpoints.tablet
        ? Space.xxxl
        : Space.section;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Breakpoints.maxContentWidth + gutter * 2,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: gutter,
            vertical: verticalPad,
          ),
          child: child,
        ),
      ),
    );
  }
}
