import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../utils/links.dart';
import '../widgets/avatar.dart';
import '../widgets/content_container.dart';
import '../widgets/nav_bar.dart';
import '../widgets/social_links.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final size = MediaQuery.sizeOf(context);
    final mobile = size.width < Breakpoints.tablet;
    final wide = size.width >= Breakpoints.desktop;

    final intro = Column(
      crossAxisAlignment:
          wide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_outlined, size: 18, color: scheme.primary),
            const SizedBox(width: Space.xs),
            Text(
              profile.location,
              style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: Space.md),
        Semantics(
          header: true,
          child: Text(
            profile.name,
            textAlign: wide ? TextAlign.start : TextAlign.center,
            style: text.displayLarge?.copyWith(fontSize: mobile ? 40 : 56),
          ),
        ),
        const SizedBox(height: Space.md),
        Text(
          profile.title,
          textAlign: wide ? TextAlign.start : TextAlign.center,
          style: text.titleLarge?.copyWith(
            color: scheme.primary,
            fontSize: mobile ? 18 : 22,
          ),
        ),
        const SizedBox(height: Space.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            profile.valueStatement,
            textAlign: wide ? TextAlign.start : TextAlign.center,
            style: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: Space.xl),
        Wrap(
          spacing: Space.md,
          runSpacing: Space.md,
          alignment: wide ? WrapAlignment.start : WrapAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: onViewProjects,
              icon: const Icon(Icons.arrow_downward, size: 20),
              label: const Text('View Projects'),
            ),
            if (profile.resumeUrl.isNotEmpty)
              OutlinedButton.icon(
                onPressed: () => openUrl(profile.resumeUrl),
                icon: const Icon(Icons.download_outlined, size: 20),
                label: const Text('Download Resume'),
              ),
          ],
        ),
        const SizedBox(height: Space.lg),
        SocialLinks(links: profile.socials),
      ],
    );

    final avatar = Avatar(
      name: profile.name,
      initials: profile.initials,
      photo: profile.profilePhoto,
      size: mobile ? 128 : (wide ? 260 : 180),
    );

    return ConstrainedBox(
      // Near full-screen on desktop, capped so tall monitors don't get a
      // mostly empty hero.
      constraints: BoxConstraints(
        minHeight: wide ? (size.height * 0.9).clamp(0, 860) : 0,
      ),
      child: Center(
        child: ContentContainer(
          vertical: false,
          child: Padding(
            padding: EdgeInsets.only(
              top: navBarHeight + (mobile ? Space.xl : Space.xxxl),
              bottom: mobile ? Space.xl : Space.xxxl,
            ),
            child: wide
                ? Row(
                    children: [
                      Expanded(flex: 3, child: intro),
                      const SizedBox(width: Space.xxl),
                      Expanded(flex: 2, child: Center(child: avatar)),
                    ],
                  )
                : Column(
                    children: [
                      avatar,
                      const SizedBox(height: Space.xl),
                      intro,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
