/// Every piece of text the portfolio shows lives here: identity, site
/// metadata, section content, and UI labels. Widgets read from this file and
/// never hardcode text, so updating the site means editing only this file.
///
/// Kept free of Flutter imports so `dart run tool/sync_web.dart` can read it
/// and regenerate `web/index.html` and `web/manifest.json`. Run that after
/// editing the identity or site metadata.
///
/// Empty strings ('') hide the related button or fall back gracefully.
library;

import '../models/models.dart';

// Identity and site metadata.

const ownerName = 'Junaid Mohammad Shaikh';

/// Used where the full name is too long: home-screen icon, app switcher.
const shortName = 'Junaid Shaikh';

const jobTitle = 'Software Engineer';
const headline = 'Software Engineer (Cross-Platform) — Flutter · Full-Stack';

const city = 'Margao';
const region = 'Goa';
const country = 'India';
const countryCode = 'IN';
const location = '$city, $region, $country';

const email = 'work.junaidshaikh03@gmail.com';
const phone = '+91 93079 55609';
const githubUrl = 'https://github.com/ghjunaid';
const linkedinUrl = 'https://www.linkedin.com/in/junaid-m-shaikh';
const xUrl = 'https://x.com/JunaidShai67970';
const instagramUrl = 'https://www.instagram.com/just_.junaid/';

/// Deployed address without a trailing slash, e.g.
/// `https://junaidshaikh.vercel.app`. Empty leaves out the link-preview URL
/// and image tags, which need an absolute address.
const siteUrl = '';

/// Browser tab and search result title.
const siteTitle = '$ownerName — $jobTitle';

/// Search result snippet.
const siteDescription =
    '$ownerName is a software engineer in $region, $country, building '
    'cross-platform mobile apps with Flutter and scalable backends with '
    'FastAPI, Python, and PostgreSQL.';

/// Shorter text for link previews on LinkedIn, X, WhatsApp and so on.
const shareDescription =
    'Cross-platform mobile apps with Flutter and scalable backends with '
    'FastAPI, Python, and PostgreSQL.';

/// Screen-reader text on the loading splash.
const loadingMessage = 'Loading $ownerName\'s portfolio';

/// Last line of the plain-text page shown without JavaScript.
const noScriptMessage = 'This site needs JavaScript enabled.';

/// First letter of the first and last names, e.g. "JS".
String get initials {
  final parts = ownerName.split(' ');
  return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
}

// Section content.

/// The role marked `current: true`, if any.
final currentRole = experience.where((e) => e.current).firstOrNull;

final profile = Profile(
  name: ownerName,
  initials: initials,
  greeting: 'Hi, I\'m',
  title: headline,
  roles: const [
    'Flutter Developer',
    'Full-Stack Engineer',
    'FastAPI + PostgreSQL Builder',
    'UI/UX-Minded Engineer',
  ],
  status: currentRole == null
      ? ''
      : 'Currently building at ${currentRole!.company}',
  heroBadges: const ['Flutter', 'FastAPI', 'PostgreSQL'],
  valueStatement:
      'I build cross-platform mobile apps and the secure, scalable APIs behind them.',
  location: location,
  email: email,
  phone: phone,
  // Drop a photo in assets/images/ and set e.g. 'assets/images/profile.jpg'.
  profilePhoto: 'assets/images/profile.png',
  // Drop your PDF in web/ with this exact name (served from the site root).
  resumeUrl: 'Junaid_Shaikh_Resume.pdf',
  socials: const [
    SocialLink(kind: SocialKind.github, label: 'GitHub', url: githubUrl),
    SocialLink(kind: SocialKind.linkedin, label: 'LinkedIn', url: linkedinUrl),
    SocialLink(kind: SocialKind.x, label: 'X', url: xUrl),
    SocialLink(
      kind: SocialKind.instagram,
      label: 'Instagram',
      url: instagramUrl,
    ),
    SocialLink(kind: SocialKind.email, label: 'Email', url: 'mailto:$email'),
  ],
);

/// Every fixed label, tooltip and decoration the widgets show.
const ui = UiText(
  viewProjects: 'View Projects',
  downloadResume: 'Download Resume',
  emailMe: 'Email me',
  copyEmail: 'Copy email',
  copied: 'Copied!',
  codeButton: 'Code',
  codeTooltip: 'source code on GitHub',
  liveButton: 'Live',
  liveTooltip: 'live site',
  storeButton: 'Store',
  storeTooltip: 'on the app store',
  whoami: '\$ whoami',
  basedIn: 'based in',
  degreeKind: 'degree',
  certificationKind: 'certification',
  workshopKind: 'workshop',
  backToTop: 'Back to top',
  openMenu: 'Open menu',
  closeMenu: 'Close menu',
  switchToLight: 'Switch to light mode',
  switchToDark: 'Switch to dark mode',
  photoOf: 'Photo of',
  initialsOf: 'initials',
);

const navItems = [
  NavItem(id: 'about', label: 'About', tagline: 'The short version.'),
  NavItem(
    id: 'experience',
    label: 'Experience',
    tagline: 'Where I\'ve been shipping code.',
  ),
  NavItem(id: 'projects', label: 'Projects', tagline: 'Things I\'ve built.'),
  NavItem(id: 'skills', label: 'Skills', tagline: 'The tools I reach for.'),
  NavItem(id: 'education', label: 'Education', tagline: 'Where I learned.'),
  NavItem(id: 'contact', label: 'Contact', tagline: 'Say hello.'),
];

final about = About(
  intro:
      'I\'m a software engineer who builds cross-platform mobile apps with '
      'Flutter and scalable backends with FastAPI, Python, and PostgreSQL. '
      'At WealthNest.AI I\'m developing a wealth management app in fintech, '
      'owning features end to end from design to live release. My background '
      'in web development and UI/UX design means I care about both the '
      'interface and the system behind it. When I\'m not coding, I enjoy '
      'learning about AI tools, designing graphics, playing games, dancing, '
      'and travelling.',
  stats: [
    // Worked out from [experience] and [projects], so these stay current.
    Stat(value: _yearsOfExperience(), label: 'Years of experience'),
    Stat(value: '${experience.length}', label: 'Roles'),
    Stat(value: '${projects.length}', label: 'Projects'),
    Stat(value: profile.heroBadges.join(' · '), label: 'Core stack'),
  ],
);

/// Total months across all roles (both ends inclusive, current roles running
/// to this month), rounded down to the nearest half year, e.g. '1.5+'.
String _yearsOfExperience() {
  int monthIndex(String date) {
    final [month, year] = date.split(' ');
    const months = 'JanFebMarAprMayJunJulAugSepOctNovDec';
    return int.parse(year) * 12 + months.indexOf(month.substring(0, 3)) ~/ 3;
  }

  final now = DateTime.now();
  final thisMonth = now.year * 12 + now.month - 1;
  final totalMonths = experience.fold(
    0,
    (sum, e) =>
        sum +
        (e.current ? thisMonth : monthIndex(e.end)) -
        monthIndex(e.start) +
        1,
  );
  final halfYears = totalMonths ~/ 6;
  final years = halfYears.isEven ? '${halfYears ~/ 2}' : '${halfYears / 2}';
  return '$years+';
}

const experience = [
  Experience(
    role: 'Associate Software Engineer',
    company: 'WealthNest.AI',
    start: 'Dec 2025',
    end: 'Present',
    current: true,
    bullets: [
      'Built scalable, user-friendly features for a wealth management mobile '
          'app using Flutter.',
      'Designed secure, high-performance backend APIs with FastAPI and Python '
          'for core financial workflows.',
      'Managed and optimized PostgreSQL databases for data integrity and '
          'reliable performance.',
    ],
    tags: ['Flutter', 'FastAPI', 'Python', 'PostgreSQL', 'REST APIs'],
  ),
  Experience(
    role: 'Flutter Full-Stack Developer',
    company: 'Haztech Innovations',
    start: 'Sept 2025',
    end: 'Nov 2025',
    bullets: [
      'Built features and UI/UX improvements for a pet adoption app in '
          'Flutter and Dart.',
      'Integrated real-time features and notifications using Laravel, '
          'Socket.IO, Firebase, and MySQL.',
    ],
    tags: ['Flutter', 'Dart', 'Laravel', 'Socket.IO', 'Firebase', 'MySQL'],
  ),
  Experience(
    role: 'Web Developer Intern',
    company: 'Glance Automation Pvt. Ltd.',
    start: 'Jan 2025',
    end: 'Apr 2025',
    bullets: [
      'Built responsive web interfaces with HTML, CSS, JavaScript, and React.',
      'Assisted with UI/UX enhancements to improve user interaction.',
      'Explored embedded systems development using Arduino and Raspberry Pi.',
    ],
    tags: [
      'React.js',
      'JavaScript',
      'HTML',
      'CSS',
      'UI/UX',
      'Arduino',
      'Raspberry Pi',
      'Embedded C/C++',
    ],
  ),
  Experience(
    role: 'Web Designing Intern',
    company: 'Vanilla Kart',
    start: 'Jul 2024',
    end: 'Aug 2024',
    bullets: [
      'Learned modern web design principles, visual layouts, and design tools.',
      'Gained hands-on experience building user-centric layouts with '
          'professional styling techniques.',
    ],
    tags: ['Web Design', 'Layout Planning', 'Visual Design', 'HTML', 'CSS'],
  ),
];

const projects = [
  Project(
    title: 'Wealth Management App (WealthNest.AI)',
    description:
        'Cross-platform fintech app for tracking and managing wealth; '
        'user-facing flows in Flutter with FastAPI services and PostgreSQL.',
    tags: ['Flutter', 'FastAPI', 'Python', 'PostgreSQL'],
    icon: ContentIcon.wallet,
    storeUrl: '', // {PLAY_STORE_LINK}
    liveUrl: '', // {LIVE_LINK}
  ),
  Project(
    title: 'Petba — Pet Adoption App',
    description:
        'Cross-platform app with real-time chat-style features and '
        'notifications.',
    tags: ['Flutter', 'Dart', 'Laravel', 'Socket.IO', 'Firebase', 'MySQL'],
    icon: ContentIcon.pets,
    githubUrl: '', // {PETBA_GITHUB_LINK}
    storeUrl: '', // {PETBA_STORE_LINK}
  ),
  Project(
    title: 'Image-to-Speech OCR Converter',
    description:
        'Mobile app for visually impaired users that captures images, '
        'extracts text or scene descriptions with CNN-RNN models, and reads '
        'them aloud in real time.',
    tags: [
      'React Native',
      'Tesseract OCR',
      'TensorFlow',
      'Hugging Face',
      'Text-to-Speech',
    ],
    icon: ContentIcon.voice,
    githubUrl: '', // {OCR_GITHUB_LINK}
  ),
  Project(
    title: 'NotesMate — Keep Notes',
    description:
        'Full-stack notes app for ideas, meeting minutes, and to-do lists, '
        'with create, view, update, and delete via REST APIs.',
    tags: ['React.js', 'Oracle DB', 'REST API'],
    icon: ContentIcon.notes,
    githubUrl: '', // {KEEP_NOTES_GITHUB_LINK}
    liveUrl: 'https://keep-notes-ui.vercel.app/',
  ),
  Project(
    title: 'TextUtils — Text Analysis Tool',
    description:
        'React app for case conversion, word counting, alerts, and '
        'light/dark theme toggling.',
    tags: ['React.js', 'JavaScript', 'React Router', 'UI/UX'],
    icon: ContentIcon.text,
    githubUrl: '', // {TEXTUTILS_GITHUB_LINK}
    liveUrl: '', // {TEXTUTILS_LIVE_LINK}
  ),
  Project(
    title: 'E-Commerce Website',
    description:
        'Responsive online store with a mobile-first layout for the best '
        'user experience.',
    tags: ['HTML', 'CSS', 'JavaScript', 'Responsive Design'],
    icon: ContentIcon.shop,
    githubUrl: '', // {ECOMMERCE_GITHUB_LINK}
    liveUrl: '', // {ECOMMERCE_LIVE_LINK}
  ),
];

const skillGroups = [
  SkillGroup(
    name: 'Mobile & Frontend',
    icon: ContentIcon.mobile,
    skills: [
      'Flutter',
      'Dart',
      'React.js',
      'React Native',
      'Next.js',
      'HTML',
      'CSS',
      'Tailwind CSS',
      'Responsive Design',
    ],
  ),
  SkillGroup(
    name: 'Backend & APIs',
    icon: ContentIcon.server,
    skills: [
      'FastAPI',
      'Node.js',
      'Laravel',
      'Firebase',
      'Socket.IO',
      'REST APIs',
    ],
  ),
  SkillGroup(
    name: 'Languages',
    icon: ContentIcon.code,
    skills: ['Python', 'JavaScript', 'TypeScript', 'Java', 'C', 'C++', 'SQL'],
  ),
  SkillGroup(
    name: 'Databases',
    icon: ContentIcon.database,
    skills: ['PostgreSQL', 'MySQL', 'MongoDB', 'Oracle DB'],
  ),
  SkillGroup(
    name: 'Design',
    icon: ContentIcon.design,
    skills: ['UI/UX Design', 'Graphic Design'],
  ),
  SkillGroup(
    name: 'Embedded',
    icon: ContentIcon.chip,
    skills: ['Arduino', 'Raspberry Pi', 'Embedded C/C++'],
  ),
  SkillGroup(
    name: 'Tools & Platforms',
    icon: ContentIcon.tools,
    skills: ['Git', 'GitHub', 'VS Code', 'Salesforce', 'Windows'],
  ),
];

const education = [
  Education(
    degree: 'Bachelor of Engineering in Information Technology',
    institution: 'Padre Conceicao College of Engineering, Goa',
    start: 'Sept 2021',
    end: 'July 2025',
  ),
  Education(
    degree: 'Higher Secondary (12th) — Science',
    institution: 'Damodar Higher Secondary School, Goa',
    start: '2019',
    end: '2021',
  ),
  Education(
    degree: 'Secondary School (10th)',
    institution: 'Shishu Vikas High School, Goa',
    start: '',
    end: '2019',
  ),
];

const certifications = [
  Certification(
    name: 'Affective Computing',
    issuer: 'NPTEL, in collaboration with IIT Kharagpur',
  ),
];

const workshops = [
  'Google Cloud Development Workshop',
  'Future of High Performance and Autonomous Vehicles',
];

const contact = Contact(
  heading: 'Let\'s build something',
  invitation:
      'Open to software engineering roles and interesting Flutter or '
      'full-stack projects. The quickest way to reach me is email.',
);

const footerCredit = 'Designed and Developed by $ownerName';
