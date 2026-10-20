import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';

/// Fixed page background: slowly drifting colour blobs over a dot grid that
/// fades out from the top. Blobs hold still when reduced motion is on.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with TickerProviderStateMixin {
  AnimationController? _drift;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = prefersReducedMotion(context);
    if (!reduce && _drift == null) {
      _drift = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 24),
      )..repeat();
    } else if (reduce && _drift != null) {
      _drift!.dispose();
      _drift = null;
    }
  }

  @override
  void dispose() {
    _drift?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vibe = Vibe.of(context);
    final scheme = Theme.of(context).colorScheme;

    return ExcludeSemantics(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColoredBox(color: scheme.surface),
          RepaintBoundary(
            child: CustomPaint(
              painter: _BlobPainter(
                drift: _drift ?? const AlwaysStoppedAnimation(0),
                vibe: vibe,
              ),
            ),
          ),
          RepaintBoundary(
            child: CustomPaint(painter: _DotGridPainter(vibe.dotColor)),
          ),
        ],
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.drift, required this.vibe})
    : super(repaint: drift);

  final Animation<double> drift;
  final Vibe vibe;

  @override
  void paint(Canvas canvas, Size size) {
    final t = drift.value * 2 * math.pi;
    final r = math.min(size.longestSide * 0.45, 720.0);

    // (colour, base x, base y, x swing, y swing, phase)
    final blobs = [
      (vibe.accent, 0.15, 0.1, 0.08, 0.06, 0.0),
      (vibe.accent2, 0.85, 0.2, 0.06, 0.08, 2.1),
      (vibe.accent3, 0.55, 0.9, 0.1, 0.05, 4.2),
    ];
    for (final (color, bx, by, sx, sy, phase) in blobs) {
      final center = Offset(
        size.width * (bx + sx * math.sin(t + phase)),
        size.height * (by + sy * math.cos(t + phase)),
      );
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              color.withValues(alpha: vibe.blobOpacity),
              color.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: center, radius: r)),
      );
    }
  }

  @override
  bool shouldRepaint(_BlobPainter old) => old.vibe != vibe;
}

class _DotGridPainter extends CustomPainter {
  _DotGridPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const gap = 28.0;
    final points = <Offset>[
      for (var y = gap / 2; y < size.height; y += gap)
        for (var x = gap / 2; x < size.width; x += gap) Offset(x, y),
    ];
    final fadeRect = Rect.fromCenter(
      center: Offset(size.width / 2, 0),
      width: size.width * 1.6,
      height: size.height * 1.6,
    );
    canvas.drawPoints(
      ui.PointMode.points,
      points,
      Paint()
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..shader = RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ).createShader(fadeRect),
    );
  }

  @override
  bool shouldRepaint(_DotGridPainter old) => old.color != color;
}

/// Big, faint glow that trails the mouse across the whole page.
class CursorGlow extends StatelessWidget {
  const CursorGlow({super.key, required this.pointer});

  final ValueListenable<Offset?> pointer;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _CursorGlowPainter(pointer, Vibe.of(context).accent),
        ),
      ),
    );
  }
}

class _CursorGlowPainter extends CustomPainter {
  _CursorGlowPainter(this.pointer, this.color) : super(repaint: pointer);

  final ValueListenable<Offset?> pointer;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final p = pointer.value;
    if (p == null) return;
    const r = 320.0;
    canvas.drawCircle(
      p,
      r,
      Paint()
        ..shader = RadialGradient(
          colors: [color.withValues(alpha: 0.09), color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: p, radius: r)),
    );
  }

  @override
  bool shouldRepaint(_CursorGlowPainter old) => old.color != color;
}
