import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../utils/links.dart';
import '../widgets/copy_email_button.dart';
import '../widgets/glow_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/gradient_text.dart';
import '../widgets/reveal.dart';
import '../widgets/section.dart';
import '../widgets/social_links.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final text = theme.textTheme;
    final vibe = Vibe.of(context);
    final mobile = Breakpoints.isMobile(context);

    return Section(
      navId: 'contact',
      child: Reveal(
        child: GlowCard(
          highlight: true,
          lift: false,
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? Space.lg : Space.xxl,
            vertical: mobile ? Space.xl : Space.section - Space.lg,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                GradientText(
                  contact.heading,
                  animate: true,
                  textAlign: TextAlign.center,
                  style: text.displaySmall?.copyWith(
                    fontSize: mobile ? 34 : 56,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: Space.md),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    contact.invitation,
                    textAlign: TextAlign.center,
                    style: text.bodyLarge?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: Space.lg),
                // Kept on one line; shrinks slightly on the narrowest phones
                // instead of breaking mid-address.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    profile.email,
                    maxLines: 1,
                    style: vibe.mono.copyWith(
                      fontSize: 17,
                      color: scheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: Space.xl),
                Wrap(
                  spacing: Space.md,
                  runSpacing: Space.md,
                  alignment: WrapAlignment.center,
                  children: [
                    GradientButton(
                      label: 'Email me',
                      icon: Icons.send_rounded,
                      onPressed: () => openUrl('mailto:${profile.email}'),
                    ),
                    CopyEmailButton(email: profile.email),
                  ],
                ),
                const SizedBox(height: Space.lg),
                SocialLinks(links: profile.socials),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
