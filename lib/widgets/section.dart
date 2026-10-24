import 'package:flutter/material.dart';

import '../data/constant.dart';
import 'content_container.dart';
import 'reveal.dart';
import 'section_heading.dart';

/// Standard page section: container, numbered heading taken from the nav
/// item with [navId], then [child].
class Section extends StatelessWidget {
  const Section({super.key, required this.navId, required this.child});

  final String navId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final index = navItems.indexWhere((item) => item.id == navId);
    final item = navItems[index];

    return ContentContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Reveal(
            child: SectionHeading(
              index: index + 1,
              title: item.label,
              tagline: item.tagline,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
