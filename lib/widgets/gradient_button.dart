import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/reduced_motion.dart';

/// Primary call-to-action: gradient fill with a soft glow that grows on
/// hover, and a visible ring when focused with the keyboard.
class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final active = _hovered || _focused;
    final radius = BorderRadius.circular(Radii.md);

    return Semantics(
      button: true,
      child: AnimatedScale(
        scale: _hovered && !prefersReducedMotion(context) ? 1.04 : 1,
        duration: const Duration(milliseconds: 160),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            gradient: vibe.gradient,
            borderRadius: radius,
            border: Border.all(
              color: _focused ? scheme.onSurface : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: vibe.accent.withValues(alpha: active ? 0.5 : 0.25),
                blurRadius: active ? 32 : 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: radius,
              onTap: widget.onPressed,
              onHover: (v) => setState(() => _hovered = v),
              onFocusChange: (v) => setState(() => _focused = v),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 48),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Space.lg,
                    vertical: Space.sm + Space.xs,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 20, color: scheme.onPrimary),
                        const SizedBox(width: Space.sm),
                      ],
                      Text(
                        widget.label,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: scheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
