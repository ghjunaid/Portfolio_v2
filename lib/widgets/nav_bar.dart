import 'dart:ui' show ImageFilter, SemanticsRole;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import 'social_links.dart';
import 'theme_toggle.dart';

const double navBarHeight = 64;

/// Sticky top bar. Shows section links from 768px up and a menu button
/// (opening [NavDrawer]) below that. Gains a blurred background once the
/// page is scrolled.
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = Breakpoints.widthOf(context);
    final wide = width >= Breakpoints.nav;
    final gutter = Breakpoints.gutter(width);

    final bar = SizedBox(
      height: navBarHeight,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Breakpoints.maxContentWidth + gutter * 2,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: gutter - Space.sm),
            child: Row(
              children: [
                _Logo(onTap: () => onNavigate('home')),
                if (!wide) const Spacer(),
                if (wide)
                  // Scales down only if the links can't fit at their natural
                  // size, so the bar never overflows near the breakpoint.
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
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
                    tooltip: 'Open menu',
                    icon: const Icon(Icons.menu, semanticLabel: 'Open menu'),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    return Semantics(
      role: SemanticsRole.navigation,
      child: ValueListenableBuilder(
        valueListenable: scrolled,
        builder: (context, isScrolled, child) => ClipRect(
          child: BackdropFilter(
            enabled: isScrolled,
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isScrolled
                    ? scheme.surface.withValues(alpha: 0.8)
                    : scheme.surface.withValues(alpha: 0),
                border: Border(
                  bottom: BorderSide(
                    color: isScrolled
                        ? scheme.outlineVariant
                        : Colors.transparent,
                  ),
                ),
              ),
              child: child,
            ),
          ),
        ),
        child: bar,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    // Hidden between 768px and 1024px, where the nav links need the room.
    final width = Breakpoints.widthOf(context);
    final showName = width < Breakpoints.nav
        ? width >= 420
        : width >= Breakpoints.desktop;

    return Semantics(
      label: '${profile.name}, back to top',
      button: true,
      excludeSemantics: true,
      onTap: onTap,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.md),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Space.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(Radii.sm),
                  ),
                  child: Text(
                    profile.initials,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (showName) ...[
                  const SizedBox(width: Space.sm + Space.xs),
                  Text(
                    profile.name.split(' ').first,
                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                ],
              ],
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

    return Semantics(
      selected: active,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: active ? scheme.primary : scheme.onSurfaceVariant,
          padding: const EdgeInsets.symmetric(horizontal: Space.sm + Space.xs),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2,
              width: active ? 16 : 0,
              color: scheme.primary,
            ),
          ],
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
                    child: Text(profile.name, style: theme.textTheme.titleMedium),
                  ),
                  IconButton(
                    tooltip: 'Close menu',
                    autofocus: true,
                    icon: const Icon(Icons.close, semanticLabel: 'Close menu'),
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
                    for (final item in navItems)
                      Semantics(
                        selected: item.id == active,
                        child: ListTile(
                          minTileHeight: 52,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Radii.md),
                          ),
                          selected: item.id == active,
                          selectedColor: scheme.primary,
                          selectedTileColor: scheme.primary.withValues(alpha: 0.1),
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
