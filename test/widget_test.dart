import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:junaid_portfolio/data/portfolio.dart';
import 'package:junaid_portfolio/main.dart';
import 'package:junaid_portfolio/theme/theme_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  Future<ThemeController> pumpApp(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final controller = ThemeController(ThemeMode.dark);
    await tester.pumpWidget(
      PortfolioApp(themeController: controller, useGoogleFonts: false),
    );
    await tester.pumpAndSettle();
    return controller;
  }

  for (final (label, size) in [
    ('mobile', const Size(360, 800)),
    ('small tablet', const Size(600, 960)),
    ('tablet', const Size(768, 1024)),
    ('small desktop', const Size(1024, 768)),
    ('desktop', const Size(1440, 900)),
  ]) {
    testWidgets('renders every section without overflow on $label',
        (tester) async {
      await pumpApp(tester, size);

      expect(find.text(profile.name), findsWidgets);
      for (final item in navItems) {
        await tester.scrollUntilVisible(
          find.text(item.label).last,
          400,
          scrollable: find.byType(Scrollable).first,
        );
      }
      await tester.pumpAndSettle();
      // Flutter reports overflow as an exception; none should have fired.
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('theme toggle switches between dark and light', (tester) async {
    final controller = await pumpApp(tester, const Size(1440, 900));

    await tester.tap(find.byTooltip('Switch to light mode'));
    await tester.pumpAndSettle();
    expect(controller.value, ThemeMode.light);

    await tester.tap(find.byTooltip('Switch to dark mode'));
    await tester.pumpAndSettle();
    expect(controller.value, ThemeMode.dark);
  });

  testWidgets('hamburger menu appears on mobile only', (tester) async {
    await pumpApp(tester, const Size(360, 800));
    expect(find.byTooltip('Open menu'), findsOneWidget);

    await tester.tap(find.byTooltip('Open menu'));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsOneWidget);

    await tester.tap(find.byTooltip('Close menu'));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsNothing);
  });

  testWidgets('project buttons are hidden when links are empty',
      (tester) async {
    await pumpApp(tester, const Size(1440, 900));
    final anyLink = projects.any(
      (p) => p.githubUrl.isNotEmpty || p.liveUrl.isNotEmpty || p.storeUrl.isNotEmpty,
    );
    expect(find.text('Code'), anyLink ? findsWidgets : findsNothing);
  });
}
