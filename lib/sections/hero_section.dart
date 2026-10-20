import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../utils/links.dart';
import '../utils/reduced_motion.dart';
import '../widgets/avatar.dart';
import '../widgets/content_container.dart';
import '../widgets/gradient_button.dart';
import '../widgets/gradient_text.dart';
import '../widgets/nav_bar.dart';
import '../widgets/pulse_dot.dart';
import '../widgets/social_links.dart';
import '../widgets/tech_icons.dart';
import '../widgets/typewriter.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewProjects,
    required this.onScrollDown,
  });

  final VoidCallback onViewProjects;
  final VoidCallback onScrollDown;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final vibe = Vibe.of(context);
    final size = MediaQuery.sizeOf(context);
    final mobile = size.width < Breakpoints.tablet;
    final wide = size.width >= Breakpoints.desktop;
    final reduce = prefersReducedMotion(context);
    final align = wide ? CrossAxisAlignment.start : CrossAxisAlignment.center;
    final textAlign = wide ? TextAlign.start : TextAlign.center;

    // Staggered fade/slide-in on first load.
    var order = 0;
    Widget enter(Widget child) {
      final i = order++;
      if (reduce) return child;
      return child
          .animate(delay: (150 + 110 * i).ms)
          .fadeIn(duration: 650.ms, curve: Curves.easeOut)
          .slideY(
            begin: 0.3,
            end: 0,
            duration: 650.ms,
            curve: Curves.easeOutCubic,
          );
    }

    final intro = Column(
      crossAxisAlignment: align,
      children: [
        if (profile.status.isNotEmpty) ...[
          enter(const _StatusPill()),
          const SizedBox(height: Space.lg),
        ],
        enter(
          Text(
            profile.greeting,
            style: vibe.mono.copyWith(
              fontSize: mobile ? 16 : 18,
              color: vibe.accent,
            ),
          ),
        ),
        const SizedBox(height: Space.sm),
        enter(
          Semantics(
            header: true,
            child: GradientText(
              profile.name,
              animate: true,
              textAlign: textAlign,
              style: text.displayLarge?.copyWith(
                fontSize: mobile ? 44 : (wide ? 76 : 60),
                height: 1.02,
                letterSpacing: mobile ? -1 : -2.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: Space.md),
        enter(
          Semantics(
            label: profile.title,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExcludeSemantics(
                  child: Text(
                    '> ',
                    style: vibe.mono.copyWith(
                      fontSize: mobile ? 17 : 22,
                      color: vibe.accent,
                    ),
                  ),
                ),
                Flexible(
                  child: Typewriter(
                    words: profile.roles,
                    style: vibe.mono.copyWith(
                      fontSize: mobile ? 17 : 22,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Space.lg),
        enter(
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              profile.valueStatement,
              textAlign: textAlign,
              style: text.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant,
                fontSize: mobile ? 17 : 19,
              ),
            ),
          ),
        ),
        const SizedBox(height: Space.xl),
        enter(
          Wrap(
            spacing: Space.md,
            runSpacing: Space.md,
            alignment: wide ? WrapAlignment.start : WrapAlignment.center,
            children: [
              GradientButton(
                label: 'View Projects',
                icon: Icons.arrow_downward_rounded,
                onPressed: onViewProjects,
              ),
              if (profile.resumeUrl.isNotEmpty)
                OutlinedButton.icon(
                  onPressed: () => openUrl(profile.resumeUrl),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: vibe.glass,
                    side: BorderSide(color: vibe.glassBorder),
                  ),
                  icon: const Icon(Icons.download_rounded, size: 20),
                  label: const Text('Download Resume'),
                ),
            ],
          ),
        ),
        const SizedBox(height: Space.lg),
        enter(SocialLinks(links: profile.socials)),
      ],
    );

    final avatarSize = mobile ? 140.0 : (wide ? 300.0 : 200.0);
    final avatar = Avatar(
      name: profile.name,
      initials: profile.initials,
      photo: profile.profilePhoto,
      size: avatarSize,
    );
    final visual = reduce
        ? avatar
        : avatar
              .animate()
              .fadeIn(duration: 900.ms)
              .scaleXY(
                begin: 0.85,
                end: 1,
                duration: 900.ms,
                curve: Curves.easeOutBack,
              );

    return ConstrainedBox(
      // Near full-screen on desktop, capped so tall monitors don't get a
      // mostly empty hero.
      constraints: BoxConstraints(
        minHeight: wide ? (size.height * 0.95).clamp(0, 900) : 0,
      ),
      child: Center(
        child: ContentContainer(
          vertical: false,
          child: Padding(
            padding: EdgeInsets.only(
              top: navBarHeight + (mobile ? Space.xl : Space.xxxl),
              bottom: mobile ? Space.xl : Space.xxl,
            ),
            child: Column(
              children: [
                wide
                    ? Row(
                        children: [
                          Expanded(flex: 3, child: intro),
                          const SizedBox(width: Space.xxl),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: _AvatarCluster(
                                avatar: visual,
                                avatarSize: avatarSize,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          visual,
                          const SizedBox(height: Space.xl),
                          intro,
                        ],
                      ),
                if (wide) ...[
                  const SizedBox(height: Space.xxl),
                  _ScrollCue(onTap: onScrollDown),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vibe = Vibe.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.md,
        vertical: Space.sm,
      ),
      decoration: BoxDecoration(
        color: vibe.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(Radii.pill),
        border: Border.all(color: vibe.accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulseDot(color: vibe.accent, size: 8),
          const SizedBox(width: Space.sm + 2),
          Flexible(
            child: Text(
              profile.status,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Avatar with tech badges floating around it (desktop only).
class _AvatarCluster extends StatelessWidget {
  const _AvatarCluster({required this.avatar, required this.avatarSize});

  final Widget avatar;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final reduce = prefersReducedMotion(context);
    final badges = profile.heroBadges.take(3).toList();
    // Spots around the avatar: top-left, right, bottom-left.
    const spots = [
      Alignment(-1.0, -0.75),
      Alignment(1.0, -0.05),
      Alignment(-0.8, 0.9),
    ];

    return SizedBox(
      width: avatarSize + 140,
      height: avatarSize + 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          avatar,
          for (final (i, name) in badges.indexed)
            Align(
              alignment: spots[i],
              child: reduce
                  ? _TechBadge(name: name)
                  : _TechBadge(name: name)
                        .animate(delay: (900 + 150 * i).ms)
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: 0.4, end: 0, duration: 500.ms)
                        // Gentle endless bob, layered on the entrance.
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(
                          begin: 0,
                          end: -10,
                          duration: (2200 + 400 * i).ms,
                          curve: Curves.easeInOut,
                        ),
            ),
        ],
      ),
    );
  }
}

class _TechBadge extends StatelessWidget {
  const _TechBadge({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final vibe = Vibe.of(context);
    final tech = techIconFor(name);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Space.md,
        vertical: Space.sm + 2,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainer.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(Radii.md),
        border: Border.all(color: vibe.glassBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (tech != null) ...[
            Icon(
              tech.icon,
              size: 18,
              color: techIconColor(tech, scheme.onSurface, theme.brightness),
            ),
            const SizedBox(width: Space.sm),
          ],
          Text(
            name,
            style: vibe.mono.copyWith(fontSize: 14, color: scheme.onSurface),
          ),
        ],
      ),
    );
  }
}

class _ScrollCue extends StatelessWidget {
  const _ScrollCue({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final vibe = Vibe.of(context);
    final arrow = Icon(
      Icons.keyboard_double_arrow_down_rounded,
      color: vibe.accent,
    );

    return Tooltip(
      message: 'Scroll to About',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Radii.pill),
        child: Padding(
          padding: const EdgeInsets.all(Space.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'scroll',
                style: vibe.mono.copyWith(
                  fontSize: 12,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              prefersReducedMotion(context)
                  ? arrow
                  : arrow
                        .animate(onPlay: (c) => c.repeat(reverse: true))
                        .moveY(
                          begin: 0,
                          end: 6,
                          duration: 900.ms,
                          curve: Curves.easeInOut,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
