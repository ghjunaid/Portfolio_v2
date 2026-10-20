import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';

/// Glass card with a spotlight that follows the mouse and lights up the
/// border near the cursor. Touch devices just get the glass card.
class GlowCard extends StatefulWidget {
  const GlowCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Space.lg),
    this.highlight = false,
    this.lift = true,
    this.radius = Radii.lg,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  /// Draws a permanent gradient border (used for the current job, contact).
  final bool highlight;

  /// Raises the card slightly on hover.
  final bool lift;
  final double radius;

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  final _pointer = ValueNotifier<Offset?>(null);
  bool _hovered = false;

  @override
  void dispose() {
    _pointer.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent e) {
    if (e.kind != PointerDeviceKind.mouse) return;
    _pointer.value = e.localPosition;
    if (!_hovered) setState(() => _hovered = true);
  }

  void _onExit(PointerEvent e) {
    _pointer.value = null;
    if (_hovered) setState(() => _hovered = false);
  }

  @override
  Widget build(BuildContext context) {
    final vibe = Vibe.of(context);
    final raise = _hovered && widget.lift && !prefersReducedMotion(context);

    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, raise ? -6 : 0, 0),
        child: CustomPaint(
          painter: _GlowPainter(
            pointer: _pointer,
            vibe: vibe,
            radius: widget.radius,
            highlight: widget.highlight,
          ),
          child: Padding(padding: widget.padding, child: widget.child),
        ),
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter({
    required this.pointer,
    required this.vibe,
    required this.radius,
    required this.highlight,
  }) : super(repaint: pointer);

  final ValueNotifier<Offset?> pointer;
  final Vibe vibe;
  final double radius;
  final bool highlight;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final border = rrect.deflate(0.5);

    canvas.drawRRect(rrect, Paint()..color = vibe.glass);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    if (highlight) {
      borderPaint.shader = LinearGradient(
        colors: [
          vibe.accent.withValues(alpha: 0.7),
          vibe.accent2.withValues(alpha: 0.35),
          vibe.accent3.withValues(alpha: 0.6),
        ],
      ).createShader(rect);
    } else {
      borderPaint.color = vibe.glassBorder;
    }
    canvas.drawRRect(border, borderPaint);

    final p = pointer.value;
    if (p == null) return;

    // Soft spotlight inside the card.
    canvas.save();
    canvas.clipRRect(rrect);
    final spot = Rect.fromCircle(center: p, radius: 260);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          colors: [
            vibe.accent.withValues(alpha: 0.12),
            vibe.accent.withValues(alpha: 0),
          ],
        ).createShader(spot),
    );
    canvas.restore();

    // Bright border segment closest to the cursor.
    canvas.drawRRect(
      border,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..shader = RadialGradient(
          colors: [
            vibe.accent,
            vibe.accent2.withValues(alpha: 0.5),
            vibe.accent2.withValues(alpha: 0),
          ],
          stops: const [0, 0.5, 1],
        ).createShader(Rect.fromCircle(center: p, radius: 180)),
    );
  }

  @override
  bool shouldRepaint(_GlowPainter old) =>
      old.vibe != vibe || old.radius != radius || old.highlight != highlight;
}
