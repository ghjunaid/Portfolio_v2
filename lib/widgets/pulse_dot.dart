import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/reduced_motion.dart';

/// Small "live" dot with an expanding ring. Static under reduced motion.
class PulseDot extends StatelessWidget {
  const PulseDot({super.key, required this.color, this.size = 10});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final dot = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
    if (prefersReducedMotion(context)) return dot;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          dot
              .animate(onPlay: (c) => c.repeat())
              .scaleXY(begin: 1, end: 2.8, duration: 1600.ms)
              .fadeOut(begin: 0.7, duration: 1600.ms),
          dot,
        ],
      ),
    );
  }
}
