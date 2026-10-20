/// All portfolio content lives here. Widgets read from these constants and
/// never hardcode resume text, so updating the site means editing this file.
///
/// Empty strings ('') hide the related button or fall back gracefully.
library;

import '../models/models.dart';

const profile = Profile(
  name: 'Junaid Mohammad Shaikh',
  initials: 'JS',
  title: 'Software Engineer (Cross-Platform) — Flutter · Full-Stack',
  valueStatement:
      'I build cross-platform mobile apps and the secure, scalable APIs behind them.',
  location: 'Margao, Goa, India',
  email: 'work.junaidshaikh03@gmail.com',
  phone: '+91 93079 55609',
  // Drop a photo in assets/images/ and set e.g. 'assets/images/profile.jpg'.
  profilePhoto: '',
  // Drop your PDF in web/ with this exact name (served from the site root).
  resumeUrl: 'Junaid_Shaikh_Resume.pdf',
  socials: [
    SocialLink(
      kind: SocialKind.github,
      label: 'GitHub',
      url: 'https://github.com/ghjunaid',
    ),
    SocialLink(
      kind: SocialKind.linkedin,
      label: 'LinkedIn',
      url: 'https://www.linkedin.com/in/junaid-m-shaikh',
    ),
    SocialLink(
      kind: SocialKind.email,
      label: 'Email',
      url: 'mailto:work.junaidshaikh03@gmail.com',
    ),
  ],
);

const navItems = [
  NavItem(id: 'about', label: 'About'),
  NavItem(id: 'experience', label: 'Experience'),
  NavItem(id: 'projects', label: 'Projects'),
  NavItem(id: 'skills', label: 'Skills'),
  NavItem(id: 'education', label: 'Education'),
  NavItem(id: 'contact', label: 'Contact'),
];

const about = About(
  intro:
      'I\'m a software engineer who builds cross-platform mobile apps with '
      'Flutter and scalable backends with FastAPI, Python, and PostgreSQL. '
      'At WealthNest.AI I\'m developing a wealth management app in fintech, '
      'owning features end to end from design to live release. My background '
      'in web development and UI/UX design means I care about both the '
      'interface and the system behind it.',
  stats: [
    Stat(value: '3', label: 'Roles'),
    Stat(value: '3', label: 'Projects'),
    Stat(value: 'Flutter · FastAPI · PostgreSQL', label: 'Core stack'),
  ],
);

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
    ],
    tags: ['React.js', 'JavaScript', 'HTML', 'CSS', 'UI/UX'],
  ),
];

const projects = [
  Project(
    title: 'Wealth Management App (WealthNest.AI)',
    description:
        'Cross-platform fintech app for tracking and managing wealth; '
        'user-facing flows in Flutter with FastAPI services and PostgreSQL.',
    tags: ['Flutter', 'FastAPI', 'Python', 'PostgreSQL'],
    storeUrl: '', // {PLAY_STORE_LINK}
    liveUrl: '', // {LIVE_LINK}
  ),
  Project(
    title: 'Petba — Pet Adoption App',
    description:
        'Cross-platform app with real-time chat-style features and '
        'notifications.',
    tags: ['Flutter', 'Dart', 'Laravel', 'Socket.IO', 'Firebase', 'MySQL'],
    githubUrl: '', // {PETBA_GITHUB_LINK}
    storeUrl: '', // {PETBA_STORE_LINK}
  ),
  Project(
    title: 'Keep Notes',
    description:
        'Full-stack notes app with create, view, update, and delete via '
        'REST APIs.',
    tags: ['React.js', 'Oracle DB', 'REST API'],
    githubUrl: '', // {KEEP_NOTES_GITHUB_LINK}
  ),
];

const skillGroups = [
  SkillGroup(
    name: 'Mobile & Frontend',
    skills: ['Flutter', 'Dart', 'React.js', 'Next.js', 'Tailwind CSS'],
  ),
  SkillGroup(
    name: 'Backend & APIs',
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
    skills: ['Python', 'JavaScript', 'TypeScript', 'Java', 'C', 'C++', 'SQL'],
  ),
  SkillGroup(
    name: 'Databases',
    skills: ['PostgreSQL', 'MySQL', 'MongoDB'],
  ),
  SkillGroup(
    name: 'Design',
    skills: ['UI/UX Design', 'Graphic Design'],
  ),
];

const education = [
  Education(
    degree: 'Bachelor of Engineering in Information Technology',
    institution: 'Padre Conceicao College of Engineering, Goa',
    start: 'Sept 2021',
    end: 'July 2025',
  ),
];

const certifications = [
  Certification(
    name: 'Affective Computing',
    issuer: 'NPTEL, in collaboration with IIT Kharagpur',
  ),
];

const contact = Contact(
  heading: 'Let\'s build something',
  invitation:
      'Open to software engineering roles and interesting Flutter or '
      'full-stack projects. The quickest way to reach me is email.',
);

const footerCredit = 'Built with Flutter';
