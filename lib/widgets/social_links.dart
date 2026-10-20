import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/models.dart';
import '../utils/links.dart';

FaIconData socialIcon(SocialKind kind) => switch (kind) {
      SocialKind.github => FontAwesomeIcons.github,
      SocialKind.linkedin => FontAwesomeIcons.linkedinIn,
      SocialKind.email => FontAwesomeIcons.envelope,
    };

/// Row of icon buttons for GitHub, LinkedIn and email.
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, required this.links});

  final List<SocialLink> links;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 4,
      children: [
        for (final link in links)
          if (link.url.isNotEmpty)
            IconButton(
              tooltip: link.label,
              onPressed: () => openUrl(link.url),
              color: scheme.onSurfaceVariant,
              hoverColor: scheme.primary.withValues(alpha: 0.12),
              icon: FaIcon(
                socialIcon(link.kind),
                size: 20,
                semanticLabel: link.label,
              ),
            ),
      ],
    );
  }
}
