import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';
import 'gradient_text.dart';

/// Circular profile photo inside a slowly spinning gradient ring with a
/// soft glow. Falls back to gradient initials when no photo is set.
class Avatar extends StatefulWidget {
  const Avatar({
    super.key,
    required this.name,
    required this.initials,
    required this.photo,
    this.size = 160,
  });

  final String name;
  final String initials;
  final String photo;
  final double size;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> with TickerProviderStateMixin {
  AnimationController? _spin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = prefersReducedMotion(context);
    if (!reduce && _spin == null) {
      _spin = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 8),
      )..repeat();
    } else if (reduce && _spin != null) {
      _spin!.dispose();
      _spin = null;
    }
  }

  @override
  void dispose() {
    _spin?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final size = widget.size;
    final ring = size * 0.03 + 2;

    final inner = widget.photo.isNotEmpty
        ? Image.asset(
            widget.photo,
            fit: BoxFit.cover,
            semanticLabel: 'Photo of ${widget.name}',
          )
        : Semantics(
            label: '${widget.name} initials',
            child: ExcludeSemantics(
              child: Container(
                alignment: Alignment.center,
                color: scheme.surfaceContainer,
                child: GradientText(
                  widget.initials,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: size * 0.32,
                  ),
                ),
              ),
            ),
          );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: vibe.accent.withValues(alpha: 0.35),
                  blurRadius: size * 0.35,
                ),
              ],
            ),
          ),
          RotationTransition(
            turns: _spin ?? const AlwaysStoppedAnimation(0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    vibe.accent,
                    vibe.accent2,
                    vibe.accent3,
                    vibe.accent3.withValues(alpha: 0.1),
                    vibe.accent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ring),
            child: ClipOval(child: SizedBox.expand(child: inner)),
          ),
        ],
      ),
    );
  }
}
