import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';
import 'tech_icons.dart';

/// Endless, slowly scrolling strip of tech logos. Pauses on hover and while
/// off-screen; not shown when reduced motion is on. Hidden from screen
/// readers because the same skills are listed in full below it.
class TechMarquee extends StatefulWidget {
  const TechMarquee({
    super.key,
    required this.items,
    this.reverse = false,
    this.speed = 36,
  });

  final List<String> items;
  final bool reverse;

  /// Pixels per second.
  final double speed;

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee>
    with SingleTickerProviderStateMixin {
  final _scroll = ScrollController();
  final _detectorKey = UniqueKey();
  late final Ticker _ticker;
  Duration _last = Duration.zero;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    // Created up front (not lazily) so dispose never has to create one.
    _ticker = createTicker(_onTick);
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    if (_hovered || !_scroll.hasClients) return;
    _scroll.jumpTo(_scroll.offset + widget.speed * dt);
  }

  void _onVisibility(VisibilityInfo info) {
    if (!mounted) return;
    final visible = info.visibleFraction > 0;
    if (visible && !_ticker.isActive) {
      _last = Duration.zero;
      _ticker.start();
    } else if (!visible && _ticker.isActive) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();

    // The marquee is pure decoration (every skill is listed in the cards
    // below), so with reduced motion it's simply left out.
    if (prefersReducedMotion(context)) return const SizedBox.shrink();

    return ExcludeSemantics(
      child: VisibilityDetector(
        key: _detectorKey,
        onVisibilityChanged: _onVisibility,
        child: MouseRegion(
          onEnter: (_) => _hovered = true,
          onExit: (_) => _hovered = false,
          child: SizedBox(
            height: 60,
            child: ShaderMask(
              // Fade the strip out at both edges.
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                ],
                stops: [0, 0.1, 0.9, 1],
              ).createShader(bounds),
              child: ListView.builder(
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                reverse: widget.reverse,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Space.xs + 2,
                    vertical: Space.sm,
                  ),
                  child: _LogoChip(name: items[i % items.length]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoChip extends StatefulWidget {
  const _LogoChip({required this.name});

  final String name;

  @override
  State<_LogoChip> createState() => _LogoChipState();
}

class _LogoChipState extends State<_LogoChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final tech = techIconFor(widget.name);
    final iconColor = tech == null
        ? scheme.onSurfaceVariant
        : _hovered
        ? techIconColor(tech, scheme.onSurface, theme.brightness)
        : scheme.onSurfaceVariant;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: Space.md),
        decoration: BoxDecoration(
          color: vibe.glass,
          borderRadius: BorderRadius.circular(Radii.pill),
          border: Border.all(
            color: _hovered
                ? vibe.accent.withValues(alpha: 0.5)
                : vibe.glassBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (tech != null) ...[
              Icon(tech.icon, size: 18, color: iconColor),
              const SizedBox(width: Space.sm),
            ],
            Text(
              widget.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _hovered ? scheme.onSurface : scheme.onSurfaceVariant,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
