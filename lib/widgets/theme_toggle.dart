import 'package:flutter/material.dart';

import '../data/constant.dart';
import '../theme/theme_controller.dart';

/// Sun/moon button that flips between light and dark mode and remembers it.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ThemeScope.of(context);
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final label = isDark ? ui.switchToLight : ui.switchToDark;

    return IconButton(
      tooltip: label,
      onPressed: () => controller.toggle(brightness),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          semanticLabel: label,
        ),
      ),
    );
  }
}
