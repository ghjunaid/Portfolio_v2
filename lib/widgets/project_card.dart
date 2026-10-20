import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/links.dart';
import 'glow_card.dart';
import 'skill_chip.dart';

/// Project card: gradient banner with the project's icon, then title,
/// description, tech tags and any links that are set.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    this.index = 0,
    this.fillHeight = false,
  });

  final Project project;

  /// Picks the banner's gradient so neighbouring cards differ.
  final int index;

  /// When true, pins the link buttons to the bottom so cards in the same
  /// grid row line up. Requires a bounded height from the parent.
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final vibe = Vibe.of(context);
    final p = project;

    final palettes = [
      [vibe.accent, vibe.accent2],
      [vibe.accent2, vibe.accent3],
      [vibe.accent3, vibe.accent],
    ];
    final colors = palettes[index % palettes.length];

    final links = <Widget>[
      if (p.githubUrl.isNotEmpty)
        _LinkButton(
          label: 'Code',
          tooltip: '${p.title} source code on GitHub',
          icon: const FaIcon(FontAwesomeIcons.github, size: 16),
          url: p.githubUrl,
        ),
      if (p.liveUrl.isNotEmpty)
        _LinkButton(
          label: 'Live',
          tooltip: '${p.title} live site',
          icon: const Icon(Icons.open_in_new, size: 18),
          url: p.liveUrl,
        ),
      if (p.storeUrl.isNotEmpty)
        _LinkButton(
          label: 'Store',
          tooltip: '${p.title} on the app store',
          icon: const Icon(Icons.shop_outlined, size: 18),
          url: p.storeUrl,
        ),
    ];

    return GlowCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(
            child: Container(
              height: 132,
              margin: const EdgeInsets.all(Space.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Radii.md),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors[0].withValues(alpha: 0.85),
                    colors[1].withValues(alpha: 0.55),
                  ],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomPaint(
                    painter: _GridLines(Colors.white.withValues(alpha: 0.12)),
                  ),
                  Center(
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(Radii.lg),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      child: Icon(p.icon, size: 36, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _FillIf(
            fillHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                Space.lg,
                Space.md,
                Space.lg,
                Space.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    header: true,
                    child: Text(p.title, style: text.titleLarge),
                  ),
                  const SizedBox(height: Space.sm),
                  Text(
                    p.description,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: Space.md),
                  ChipWrap(labels: p.tags, dense: true),
                  if (fillHeight) const Spacer(),
                  if (links.isNotEmpty) ...[
                    const SizedBox(height: Space.md),
                    Wrap(
                      spacing: Space.sm,
                      runSpacing: Space.sm,
                      children: links,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Expands to the remaining height only when the card is stretched; in an
/// unbounded column (single-column layout) it just shows the child.
class _FillIf extends StatelessWidget {
  const _FillIf(this.fill, {required this.child});

  final bool fill;
  final Widget child;

  @override
  Widget build(BuildContext context) => fill ? Expanded(child: child) : child;
}

class _GridLines extends CustomPainter {
  _GridLines(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    const gap = 22.0;
    for (var x = gap; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = gap; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridLines old) => old.color != color;
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.label,
    required this.tooltip,
    required this.icon,
    required this.url,
  });

  final String label;
  final String tooltip;
  final Widget icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    // The tooltip doubles as the accessible description, so "Code" is
    // announced together with the project name.
    return Tooltip(
      message: tooltip,
      child: TextButton.icon(
        onPressed: () => openUrl(url),
        icon: icon,
        label: Text(label),
      ),
    );
  }
}
