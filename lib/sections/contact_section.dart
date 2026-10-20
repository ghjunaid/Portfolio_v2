import 'package:flutter/material.dart';

import '../data/portfolio.dart';
import '../theme/app_theme.dart';
import '../utils/breakpoints.dart';
import '../utils/links.dart';
import '../widgets/copy_email_button.dart';
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
    final mobile = Breakpoints.isMobile(context);

    return Section(
      navId: 'contact',
      child: Reveal(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(mobile ? Space.lg : Space.xxl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Radii.lg),
            border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                scheme.primary.withValues(alpha: 0.12),
                scheme.surfaceContainer,
              ],
            ),
          ),
          child: Column(
            children: [
              Text(
                contact.heading,
                textAlign: TextAlign.center,
                style: text.displaySmall?.copyWith(fontSize: mobile ? 28 : 36),
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
              const SizedBox(height: Space.md),
              // Kept on one line; shrinks slightly on the narrowest phones
              // instead of breaking mid-address.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  profile.email,
                  maxLines: 1,
                  style: text.titleMedium?.copyWith(color: scheme.primary),
                ),
              ),
              const SizedBox(height: Space.xl),
              Wrap(
                spacing: Space.md,
                runSpacing: Space.md,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: () => openUrl('mailto:${profile.email}'),
                    icon: const Icon(Icons.mail_outline, size: 20),
                    label: const Text('Email me'),
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
    );
  }
}
