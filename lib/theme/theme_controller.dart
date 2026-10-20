import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Holds the current [ThemeMode]. Starts from the saved choice if there is
/// one, otherwise follows the system (`prefers-color-scheme` on web).
/// Storage can be unavailable (private mode, blocked site data), so every
/// read and write is wrapped in try/catch and failures are ignored.
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController([super.initial = ThemeMode.system]);

  static const _key = 'theme_mode';

  static Future<ThemeController> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return ThemeController(switch (prefs.getString(_key)) {
        'dark' => ThemeMode.dark,
        'light' => ThemeMode.light,
        _ => ThemeMode.system,
      });
    } catch (_) {
      return ThemeController();
    }
  }

  /// Flips between light and dark based on what is currently shown.
  Future<void> toggle(Brightness current) async {
    value = current == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, value == ThemeMode.dark ? 'dark' : 'light');
    } catch (_) {
      // Preference just won't persist; the toggle still works this session.
    }
  }
}

/// Makes the [ThemeController] available to widgets below it.
class ThemeScope extends InheritedNotifier<ThemeController> {
  const ThemeScope({
    super.key,
    required ThemeController controller,
    required super.child,
  }) : super(notifier: controller);

  static ThemeController of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ThemeScope>()!.notifier!;
}
