import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../widgets/content_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme.bodyMedium?.copyWith(
      color: scheme.onSurfaceVariant,
    );

    return Semantics(
      role: SemanticsRole.contentInfo,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        child: ContentContainer(
          vertical: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Space.lg),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: Space.md,
              runSpacing: Space.sm,
              children: [
                Text('© ${DateTime.now().year} ${profile.name}', style: style),
                Text(footerCredit, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
