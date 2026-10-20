import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';

/// Text filled with the accent gradient. With [animate], the gradient slowly
/// flows across the text (static when reduced motion is on).
class GradientText extends StatefulWidget {
  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.animate = false,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool animate;

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with TickerProviderStateMixin {
  AnimationController? _flow;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shouldAnimate = widget.animate && !prefersReducedMotion(context);
    if (shouldAnimate && _flow == null) {
      _flow = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 6),
      )..repeat();
    } else if (!shouldAnimate && _flow != null) {
      _flow!.dispose();
      _flow = null;
    }
  }

  @override
  void dispose() {
    _flow?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vibe = Vibe.of(context);
    final colors = [vibe.accent, vibe.accent2, vibe.accent3, vibe.accent];

    final text = Text(
      widget.text,
      textAlign: widget.textAlign,
      style: (widget.style ?? const TextStyle()).copyWith(color: Colors.white),
    );

    Widget masked(double t) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        tileMode: TileMode.repeated,
        transform: _Slide(t),
      ).createShader(bounds),
      child: text,
    );

    final flow = _flow;
    if (flow == null) return masked(0);
    return AnimatedBuilder(
      animation: flow,
      builder: (context, _) => masked(flow.value),
    );
  }
}

class _Slide extends GradientTransform {
  const _Slide(this.t);

  final double t;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) =>
      Matrix4.translationValues(bounds.width * t, 0, 0);
}
