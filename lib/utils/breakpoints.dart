import 'package:flutter/widgets.dart';

/// Mobile-first breakpoints. Layouts start from the mobile version and add
/// columns as width grows.
abstract final class Breakpoints {
  static const double tablet = 600;
  static const double nav = 768;
  static const double desktop = 1024;
  static const double maxContentWidth = 1200;

  static double widthOf(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) => widthOf(context) < tablet;
  static bool isDesktop(BuildContext context) => widthOf(context) >= desktop;

  /// Side gutter: 16px on phones, growing with the viewport.
  static double gutter(double width) {
    if (width < tablet) return 16;
    if (width < desktop) return 32;
    return 48;
  }
}
