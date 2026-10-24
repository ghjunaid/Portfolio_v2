import 'dart:ui' show ImageFilter, SemanticsRole;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/constant.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import 'social_links.dart';
import 'theme_toggle.dart';

/// Space the floating nav takes at the top of the page, including margin.
const double navBarHeight = 80;
const double _pillHeight = 56;

/// Floating glass pill nav. Shows section links from 768px up and a menu
/// button (opening [NavDrawer]) below that. Gets more solid once scrolled.
class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.activeId,
    required this.scrolled,
    required this.onNavigate,
  });

  final ValueListenable<String> activeId;
  final ValueListenable<bool> scrolled;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final vibe = Vibe.of(context);
    final width = Breakpoints.widthOf(context);
    final wide = width >= Breakpoints.nav;
    final gutter = Breakpoints.gutter(width);
    final radius = BorderRadius.circular(Radii.pill);

    // The pill hugs its contents and sits centred on the page.
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (wide)
          // Scales down only if the links can't fit at their natural size,
          // so the bar never overflows near the breakpoint.
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ValueListenableBuilder(
                valueListenable: activeId,
                builder: (context, active, _) => Row(
                  children: [
                    for (final item in navItems)
                      _NavLink(
                        label: item.label,
                        active: item.id == active,
                        onTap: () => onNavigate(item.id),
                      ),
                  ],
                ),
              ),
            ),
          ),
        const ThemeToggle(),
        if (!wide)
          IconButton(
            tooltip: ui.openMenu,
            icon: Icon(Icons.menu_rounded, semanticLabel: ui.openMenu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          ),
      ],
    );

    return Semantics(
      role: SemanticsRole.navigation,
      child: Padding(
        padding: EdgeInsets.fromLTRB(gutter, 12, gutter, 0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: ValueListenableBuilder(
              valueListenable: scrolled,
              builder: (context, isScrolled, child) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: _pillHeight,
                decoration: BoxDecoration(
                  borderRadius: radius,
                  boxShadow: [
                    if (isScrolled)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: radius,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        color: isScrolled
                            ? scheme.surface.withValues(alpha: 0.75)
                            : vibe.glass,
                        borderRadius: radius,
                        border: Border.all(color: vibe.glassBorder),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

/// Thin gradient bar at the very top showing how far down the page is.
class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({super.key, required this.progress});

  final ValueListenable<double> progress;

  @override
  Widget build(BuildContext context) {
    final vibe = Vibe.of(context);
    return ExcludeSemantics(
      child: SizedBox(
        height: 3,
        child: ValueListenableBuilder(
          valueListenable: progress,
          builder: (context, value, _) => Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: vibe.gradientColors),
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final vibe = Vibe.of(context);

    return Semantics(
      selected: active,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: active ? scheme.primary : scheme.onSurfaceVariant,
            backgroundColor: active
                ? vibe.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: Space.md - 2),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

/// Slide-in menu for screens under 768px. Closes on Esc, on the scrim, or
/// after a link is chosen.
class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
    required this.activeId,
    required this.onNavigate,
  });

  final ValueListenable<String> activeId;
  final ValueChanged<String> onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);

    return Drawer(
      width: 300,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '~/${profile.name.split(' ').first.toLowerCase()}',
                      style: vibe.mono.copyWith(
                        fontSize: 16,
                        color: vibe.accent,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: ui.closeMenu,
                    autofocus: true,
                    icon: Icon(Icons.close, semanticLabel: ui.closeMenu),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: Space.md),
              ValueListenableBuilder(
                valueListenable: activeId,
                builder: (context, active, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (i, item) in navItems.indexed)
                      Semantics(
                        selected: item.id == active,
                        child: ListTile(
                          minTileHeight: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Radii.md),
                          ),
                          selected: item.id == active,
                          selectedColor: scheme.primary,
                          selectedTileColor: vibe.accent.withValues(alpha: 0.1),
                          leading: Text(
                            (i + 1).toString().padLeft(2, '0'),
                            style: vibe.mono.copyWith(
                              fontSize: 13,
                              color: vibe.accent,
                            ),
                          ),
                          title: Text(
                            item.label,
                            style: theme.textTheme.titleMedium,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            onNavigate(item.id);
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              SocialLinks(links: profile.socials),
            ],
          ),
        ),
      ),
    );
  }
}
