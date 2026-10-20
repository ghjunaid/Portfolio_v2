import 'package:flutter/material.dart';

/// Circular profile photo with an accent ring. Falls back to initials when
/// no photo path is set.
class Avatar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final inner = photo.isNotEmpty
        ? Image.asset(
            photo,
            width: size,
            height: size,
            fit: BoxFit.cover,
            semanticLabel: 'Photo of $name',
          )
        : Semantics(
            label: '$name initials',
            child: ExcludeSemantics(
              child: Container(
                alignment: Alignment.center,
                color: scheme.surfaceContainerHigh,
                child: Text(
                  initials,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontSize: size * 0.32,
                    color: scheme.primary,
                  ),
                ),
              ),
            ),
          );

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, scheme.primary.withValues(alpha: 0.15)],
        ),
      ),
      child: ClipOval(child: inner),
    );
  }
}
