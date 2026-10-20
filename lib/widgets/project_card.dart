import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import '../utils/links.dart';
import '../utils/reduced_motion.dart';
import 'skill_chip.dart';

/// Project summary card. Link buttons only appear when their URL is set.
/// Lifts on hover, but only for a real mouse pointer (not touch).
class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, this.fillHeight = false});

  final Project project;

  /// When true, pins the link buttons to the bottom so cards in the same
  /// grid row line up. Requires a bounded height from the parent.
  final bool fillHeight;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  void _setHover(PointerEvent event, bool value) {
    if (event.kind != PointerDeviceKind.mouse) return;
    if (_hovered != value) setState(() => _hovered = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final p = widget.project;
    final lift = _hovered && !prefersReducedMotion(context);

    final links = <Widget>[
      if (p.githubUrl.isNotEmpty)
        _LinkButton(
          label: 'Code',
          semanticLabel: '${p.title} source code on GitHub',
          icon: FaIcon(FontAwesomeIcons.github, size: 16),
          url: p.githubUrl,
        ),
      if (p.liveUrl.isNotEmpty)
        _LinkButton(
          label: 'Live',
          semanticLabel: '${p.title} live site',
          icon: const Icon(Icons.open_in_new, size: 18),
          url: p.liveUrl,
        ),
      if (p.storeUrl.isNotEmpty)
        _LinkButton(
          label: 'Store',
          semanticLabel: '${p.title} on the app store',
          icon: const Icon(Icons.shop_outlined, size: 18),
          url: p.storeUrl,
        ),
    ];

    return MouseRegion(
      onEnter: (e) => _setHover(e, true),
      onExit: (e) => _setHover(e, false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, lift ? -6 : 0, 0),
        padding: const EdgeInsets.all(Space.lg),
        decoration: BoxDecoration(
          color: scheme.surfaceContainer,
          borderRadius: BorderRadius.circular(Radii.lg),
          border: Border.all(
            color: _hovered
                ? scheme.primary.withValues(alpha: 0.6)
                : scheme.outlineVariant,
          ),
          boxShadow: [
            if (lift)
              BoxShadow(
                color: scheme.primary.withValues(alpha: 0.12),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
          ],
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
              style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: Space.md),
            ChipWrap(labels: p.tags, dense: true),
            if (widget.fillHeight) const Spacer(),
            if (links.isNotEmpty) ...[
              const SizedBox(height: Space.md),
              Wrap(spacing: Space.sm, runSpacing: Space.sm, children: links),
            ],
          ],
        ),
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.label,
    required this.semanticLabel,
    required this.icon,
    required this.url,
  });

  final String label;
  final String semanticLabel;
  final Widget icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    // The tooltip doubles as the accessible description, so "Code" is
    // announced together with the project name.
    return Tooltip(
      message: semanticLabel,
      child: TextButton.icon(
        onPressed: () => openUrl(url),
        icon: icon,
        label: Text(label),
      ),
    );
  }
}
