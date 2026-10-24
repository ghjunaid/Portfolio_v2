/// Plain data types for portfolio content. Edit values in
/// `lib/data/constant.dart`, not here.
///
/// No Flutter imports, so `tool/sync_web.dart` can load the content as plain
/// Dart.
library;

/// Icons for project banners and skill groups. Each maps to a Material icon
/// in `lib/widgets/content_icons.dart`.
enum ContentIcon {
  wallet,
  pets,
  voice,
  notes,
  text,
  shop,
  mobile,
  server,
  code,
  database,
  design,
  chip,
  tools,
}

enum SocialKind { github, linkedin, x, instagram, email }

class SocialLink {
  const SocialLink({
    required this.kind,
    required this.label,
    required this.url,
  });

  final SocialKind kind;
  final String label;
  final String url;
}

class Profile {
  const Profile({
    required this.name,
    required this.initials,
    required this.greeting,
    required this.title,
    required this.roles,
    required this.status,
    required this.heroBadges,
    required this.valueStatement,
    required this.location,
    required this.email,
    required this.phone,
    required this.profilePhoto,
    required this.resumeUrl,
    required this.socials,
  });

  final String name;
  final String initials;

  /// Small line above the name in the hero.
  final String greeting;
  final String title;

  /// Cycled by the typewriter line in the hero.
  final List<String> roles;

  /// Shown in the pulsing pill at the top of the hero. Empty hides it.
  final String status;

  /// Tech names that float around the avatar (desktop only).
  final List<String> heroBadges;
  final String valueStatement;
  final String location;
  final String email;
  final String phone;

  /// Asset path such as `assets/images/profile.jpg`. Empty shows initials.
  final String profilePhoto;

  /// Path of a PDF placed in `web/`. Empty hides the "Download Resume" button.
  final String resumeUrl;
  final List<SocialLink> socials;
}

class Stat {
  const Stat({required this.value, required this.label});

  final String value;
  final String label;
}

class About {
  const About({required this.intro, required this.stats});

  final String intro;
  final List<Stat> stats;
}

class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.start,
    required this.end,
    required this.bullets,
    required this.tags,
    this.current = false,
  });

  final String role;
  final String company;
  final String start;
  final String end;
  final List<String> bullets;
  final List<String> tags;
  final bool current;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.icon,
    this.githubUrl = '',
    this.liveUrl = '',
    this.storeUrl = '',
  });

  final String title;
  final String description;
  final List<String> tags;

  /// Shown large on the card's gradient banner.
  final ContentIcon icon;

  /// Leave empty to hide the matching button.
  final String githubUrl;
  final String liveUrl;
  final String storeUrl;
}

class SkillGroup {
  const SkillGroup({
    required this.name,
    required this.icon,
    required this.skills,
  });

  final String name;
  final ContentIcon icon;
  final List<String> skills;
}

class Education {
  const Education({
    required this.degree,
    required this.institution,
    required this.start,
    required this.end,
  });

  final String degree;
  final String institution;

  /// Empty shows only [end], for single-year entries.
  final String start;
  final String end;
}

class Certification {
  const Certification({required this.name, required this.issuer});

  final String name;
  final String issuer;
}

class Contact {
  const Contact({required this.heading, required this.invitation});

  final String heading;
  final String invitation;
}

/// Fixed labels, tooltips and decorative text used across the widgets.
class UiText {
  const UiText({
    required this.viewProjects,
    required this.downloadResume,
    required this.emailMe,
    required this.copyEmail,
    required this.copied,
    required this.codeButton,
    required this.codeTooltip,
    required this.liveButton,
    required this.liveTooltip,
    required this.storeButton,
    required this.storeTooltip,
    required this.whoami,
    required this.basedIn,
    required this.degreeKind,
    required this.certificationKind,
    required this.workshopKind,
    required this.backToTop,
    required this.openMenu,
    required this.closeMenu,
    required this.switchToLight,
    required this.switchToDark,
    required this.photoOf,
    required this.initialsOf,
  });

  final String viewProjects;
  final String downloadResume;
  final String emailMe;
  final String copyEmail;
  final String copied;

  /// Project card buttons. Tooltips follow the project title.
  final String codeButton;
  final String codeTooltip;
  final String liveButton;
  final String liveTooltip;
  final String storeButton;
  final String storeTooltip;

  /// Code-style decoration above the About intro.
  final String whoami;
  final String basedIn;

  /// Shown as `// <kind>` on education cards.
  final String degreeKind;
  final String certificationKind;
  final String workshopKind;

  final String backToTop;
  final String openMenu;
  final String closeMenu;
  final String switchToLight;
  final String switchToDark;

  /// Screen-reader labels for the avatar, e.g. "Photo of Junaid" and
  /// "Junaid initials".
  final String photoOf;
  final String initialsOf;
}

class NavItem {
  const NavItem({required this.id, required this.label, this.tagline = ''});

  final String id;
  final String label;

  /// Short line under the section heading. Empty hides it.
  final String tagline;
}
