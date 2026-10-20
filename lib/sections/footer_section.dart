import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../widgets/content_container.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.onBackToTop});

  final VoidCallback onBackToTop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final style = vibe.mono.copyWith(
      fontSize: 14,
      color: scheme.onSurfaceVariant,
    );

    return Semantics(
      role: SemanticsRole.contentInfo,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: vibe.glassBorder)),
        ),
        child: ContentContainer(
          vertical: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Space.lg),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: Space.md,
              runSpacing: Space.sm,
              children: [
                Text('© ${DateTime.now().year} ${profile.name}', style: style),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(footerCredit, style: style),
                    const SizedBox(width: Space.sm),
                    IconButton(
                      tooltip: 'Back to top',
                      onPressed: onBackToTop,
                      style: IconButton.styleFrom(
                        backgroundColor: vibe.glass,
                        side: BorderSide(color: vibe.glassBorder),
                      ),
                      icon: Icon(
                        Icons.arrow_upward_rounded,
                        color: vibe.accent,
                        semanticLabel: 'Back to top',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
