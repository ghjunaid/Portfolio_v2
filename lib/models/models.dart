/// Plain data types for portfolio content. Edit values in
/// `lib/data/portfolio.dart`, not here.
library;

enum SocialKind { github, linkedin, email }

class SocialLink {
  const SocialLink({required this.kind, required this.label, required this.url});

  final SocialKind kind;
  final String label;
  final String url;
}

class Profile {
  const Profile({
    required this.name,
    required this.initials,
    required this.title,
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
  final String title;
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
    this.githubUrl = '',
    this.liveUrl = '',
    this.storeUrl = '',
  });

  final String title;
  final String description;
  final List<String> tags;

  /// Leave empty to hide the matching button.
  final String githubUrl;
  final String liveUrl;
  final String storeUrl;
}

class SkillGroup {
  const SkillGroup({required this.name, required this.skills});

  final String name;
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

class NavItem {
  const NavItem({required this.id, required this.label});

  final String id;
  final String label;
}
