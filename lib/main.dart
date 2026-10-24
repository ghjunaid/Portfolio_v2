import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'data/constant.dart';
import 'pages/home_page.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Build the accessibility tree up front so screen readers and Lighthouse
  // see real elements instead of Flutter's "enable accessibility" button.
  if (kIsWeb) SemanticsBinding.instance.ensureSemantics();
  // Check visibility often enough that scroll reveals feel immediate.
  VisibilityDetectorController.instance.updateInterval = const Duration(
    milliseconds: 100,
  );

  final (themeController, _) = await (
    ThemeController.load(),
    _preloadFonts(),
  ).wait;
  runApp(PortfolioApp(themeController: themeController));
}

/// Waits (behind the HTML splash) for the web fonts so the first layout uses
/// them. Without this, text can re-wrap after the fonts arrive and leave
/// equal-height card rows measured with the fallback font. Gives up after a
/// few seconds so a slow network never blocks the page.
Future<void> _preloadFonts() async {
  try {
    await GoogleFonts.pendingFonts([
      for (final weight in [
        FontWeight.w400,
        FontWeight.w500,
        FontWeight.w600,
        FontWeight.w700,
      ])
        GoogleFonts.inter(fontWeight: weight),
      GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w600),
      GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w700),
      GoogleFonts.jetBrainsMono(fontWeight: FontWeight.w500),
    ]).timeout(const Duration(seconds: 4));
  } catch (_) {
    // Fall back to whatever has loaded; the layout still works.
  }
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({
    super.key,
    required this.themeController,
    this.useGoogleFonts = true,
  });

  final ThemeController themeController;

  /// Tests turn this off so they don't need network access.
  final bool useGoogleFonts;

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      controller: themeController,
      child: ValueListenableBuilder(
        valueListenable: themeController,
        builder: (context, mode, _) => MaterialApp(
          title: siteTitle,
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: AppTheme.light(useGoogleFonts: useGoogleFonts),
          darkTheme: AppTheme.dark(useGoogleFonts: useGoogleFonts),
          home: const HomePage(),
        ),
      ),
    );
  }
}
