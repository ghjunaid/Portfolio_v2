import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'reveal.dart';

/// Lays items out in rows of [columns], with every card in a row stretched
/// to the tallest one. Items reveal with a small stagger.
class EqualHeightGrid extends StatelessWidget {
  const EqualHeightGrid({
    super.key,
    required this.columns,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = Space.lg,
  });

  final int columns;
  final int itemCount;

  /// [fillHeight] is true when the item is stretched to the row height, so
  /// it can push content (like buttons) to the bottom.
  final Widget Function(BuildContext context, int index, bool fillHeight)
  itemBuilder;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var start = 0; start < itemCount; start += columns) {
      if (rows.isNotEmpty) rows.add(SizedBox(height: spacing));

      if (columns == 1) {
        rows.add(Reveal(child: itemBuilder(context, start, false)));
        continue;
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) SizedBox(width: spacing),
                Expanded(
                  child: start + c < itemCount
                      ? Reveal(
                          delay: Duration(milliseconds: 90 * c),
                          child: itemBuilder(context, start + c, true),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}
