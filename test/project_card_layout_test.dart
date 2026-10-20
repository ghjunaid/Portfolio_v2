import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:junaid_portfolio/main.dart';
import 'package:junaid_portfolio/theme/theme_controller.dart';
import 'package:junaid_portfolio/widgets/project_card.dart';
import 'package:junaid_portfolio/widgets/skill_chip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  for (final width in [768.0, 1100.0, 1440.0]) {
    testWidgets('project card content fits inside the card at $width', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 6000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );

      await tester.pumpWidget(
        PortfolioApp(
          themeController: ThemeController(ThemeMode.dark),
          useGoogleFonts: false,
        ),
      );
      await tester.pumpAndSettle();

      for (final card in find.byType(ProjectCard).evaluate()) {
        final cardRect = tester.getRect(find.byWidget(card.widget));
        final chips = find.descendant(
          of: find.byWidget(card.widget),
          matching: find.byType(ChipWrap),
        );
        final chipsRect = tester.getRect(chips);
        expect(
          chipsRect.bottom,
          lessThanOrEqualTo(cardRect.bottom - 24 + 0.5),
          reason: 'chips overflow card at width $width',
        );
      }
    });
  }
}
