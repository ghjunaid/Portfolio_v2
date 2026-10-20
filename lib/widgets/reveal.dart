import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../utils/reduced_motion.dart';

/// Fades and slides its child in the first time it scrolls into view.
/// Shows the child immediately when the user prefers reduced motion.
class Reveal extends StatefulWidget {
  const Reveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;

  /// Stagger offset for items in a list.
  final Duration delay;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  final _detectorKey = UniqueKey();
  bool _visible = false;

  void _onVisibility(VisibilityInfo info) {
    if (_visible || info.visibleFraction < 0.1) return;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return widget.child;

    const duration = Duration(milliseconds: 600);
    const curve = Curves.easeOutCubic;
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibility,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: duration,
        curve: curve,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : const Offset(0, 0.06),
          duration: duration,
          curve: curve,
          child: widget.child,
        ),
      ),
    );
  }
}
