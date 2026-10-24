/// All portfolio content lives here. Widgets read from these constants and
/// never hardcode resume text, so updating the site means editing this file.
///
/// Empty strings ('') hide the related button or fall back gracefully.
library;

import 'package:flutter/material.dart' show Icons;

import '../models/models.dart';

const profile = Profile(
  name: 'Junaid Mohammad Shaikh',
  initials: 'JS',
  greeting: 'Hi, I\'m',
  title: 'Software Engineer (Cross-Platform) — Flutter · Full-Stack',
  roles: [
    'Flutter Developer',
    'Full-Stack Engineer',
    'FastAPI + PostgreSQL Builder',
    'UI/UX-Minded Engineer',
  ],
  status: 'Currently building at WealthNest.AI',
  heroBadges: ['Flutter', 'FastAPI', 'PostgreSQL'],
  valueStatement:
      'I build cross-platform mobile apps and the secure, scalable APIs behind them.',
  location: 'Margao, Goa, India',
  email: 'work.junaidshaikh03@gmail.com',
  phone: '+91 93079 55609',
  // Drop a photo in assets/images/ and set e.g. 'assets/images/profile.jpg'.
  profilePhoto: 'assets/images/profile.png',
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
      kind: SocialKind.x,
      label: 'X',
      url: 'https://x.com/JunaidShai67970',
    ),
    SocialLink(
      kind: SocialKind.instagram,
      label: 'Instagram',
      url: 'https://www.instagram.com/just_.junaid/',
    ),
    SocialLink(
      kind: SocialKind.email,
      label: 'Email',
      url: 'mailto:work.junaidshaikh03@gmail.com',
    ),
  ],
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

const about = About(
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
    // Jul 2024 – present across internships and full-time roles (~20 months).
    Stat(value: '1.5+', label: 'Years of experience'),
    Stat(value: '4', label: 'Roles'),
    Stat(value: '6', label: 'Projects'),
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
    icon: Icons.account_balance_wallet_outlined,
    storeUrl: '', // {PLAY_STORE_LINK}
    liveUrl: '', // {LIVE_LINK}
  ),
  Project(
    title: 'Petba — Pet Adoption App',
    description:
        'Cross-platform app with real-time chat-style features and '
        'notifications.',
    tags: ['Flutter', 'Dart', 'Laravel', 'Socket.IO', 'Firebase', 'MySQL'],
    icon: Icons.pets_outlined,
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
    icon: Icons.record_voice_over_outlined,
    githubUrl: '', // {OCR_GITHUB_LINK}
  ),
  Project(
    title: 'NotesMate — Keep Notes',
    description:
        'Full-stack notes app for ideas, meeting minutes, and to-do lists, '
        'with create, view, update, and delete via REST APIs.',
    tags: ['React.js', 'Oracle DB', 'REST API'],
    icon: Icons.sticky_note_2_outlined,
    githubUrl: '', // {KEEP_NOTES_GITHUB_LINK}
    liveUrl: 'https://keep-notes-ui.vercel.app/',
  ),
  Project(
    title: 'TextUtils — Text Analysis Tool',
    description:
        'React app for case conversion, word counting, alerts, and '
        'light/dark theme toggling.',
    tags: ['React.js', 'JavaScript', 'React Router', 'UI/UX'],
    icon: Icons.text_fields_rounded,
    githubUrl: '', // {TEXTUTILS_GITHUB_LINK}
    liveUrl: '', // {TEXTUTILS_LIVE_LINK}
  ),
  Project(
    title: 'E-Commerce Website',
    description:
        'Responsive online store with a mobile-first layout for the best '
        'user experience.',
    tags: ['HTML', 'CSS', 'JavaScript', 'Responsive Design'],
    icon: Icons.shopping_bag_outlined,
    githubUrl: '', // {ECOMMERCE_GITHUB_LINK}
    liveUrl: '', // {ECOMMERCE_LIVE_LINK}
  ),
];

const skillGroups = [
  SkillGroup(
    name: 'Mobile & Frontend',
    icon: Icons.phone_iphone_rounded,
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
    icon: Icons.dns_outlined,
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
    icon: Icons.code_rounded,
    skills: ['Python', 'JavaScript', 'TypeScript', 'Java', 'C', 'C++', 'SQL'],
  ),
  SkillGroup(
    name: 'Databases',
    icon: Icons.storage_rounded,
    skills: ['PostgreSQL', 'MySQL', 'MongoDB', 'Oracle DB'],
  ),
  SkillGroup(
    name: 'Design',
    icon: Icons.palette_outlined,
    skills: ['UI/UX Design', 'Graphic Design'],
  ),
  SkillGroup(
    name: 'Embedded',
    icon: Icons.memory_rounded,
    skills: ['Arduino', 'Raspberry Pi', 'Embedded C/C++'],
  ),
  SkillGroup(
    name: 'Tools & Platforms',
    icon: Icons.build_outlined,
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

const footerCredit = 'Designed and Developed by Junaid Mohammad Shaikh';
