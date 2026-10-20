import 'package:flutter/widgets.dart';

import 'reduced_motion_stub.dart'
    if (dart.library.js_interop) 'reduced_motion_web.dart';

/// True when the user asked for less motion, either through the platform's
/// accessibility settings or the browser's `prefers-reduced-motion`.
bool prefersReducedMotion(BuildContext context) =>
    MediaQuery.maybeDisableAnimationsOf(context) == true ||
    platformPrefersReducedMotion();
