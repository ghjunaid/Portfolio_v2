# Junaid Mohammad Shaikh — Portfolio

A single-page portfolio built with **Flutter Web**. It is responsive from 360px phones to 1440px+ desktops and supports dark and light mode. All the text on the site comes from one data file.

## Run it

```bash
flutter pub get
flutter run -d chrome          # dev, with hot reload
flutter test                   # widget tests (5 screen widths, theme, menu)
flutter analyze
```

## Build for production

```bash
flutter build web --release --wasm
```

The output goes to `build/web/`. That folder is plain static files and can be hosted anywhere.

## Deploy

**Vercel**

```bash
npm i -g vercel
flutter build web --release --wasm
vercel deploy build/web --prod
```

Vercel's build machines don't have Flutter installed, so build on your own machine and deploy the `build/web` folder as shown above.

**Firebase Hosting** (alternative)

```bash
npm i -g firebase-tools
firebase login
firebase init hosting          # public directory: build/web, single-page app: No
flutter build web --release --wasm
firebase deploy
```

After the first deploy, replace `{SITE_URL}` in `web/index.html` with your live address (for example `https://junaidshaikh.vercel.app`). Then rebuild and deploy again. Without this, LinkedIn and WhatsApp link previews can't show the preview image.

## How to update content

Edit **`lib/data/portfolio.dart`**. It is the only file that holds your text, and no widget has resume text written into it.

**Add a job.** Put a new entry at the top of `experience`. Move `current: true` to it and remove `current: true` from the old job.

```dart
Experience(
  role: 'Software Engineer',
  company: 'New Company',
  start: 'Jan 2027',
  end: 'Present',
  current: true,
  bullets: ['What you built…', 'What you improved…'],
  tags: ['Flutter', 'FastAPI'],
),
```

**Add a project.** Add an entry to `projects`. If you leave a link as `''`, its button stays hidden. `icon` is any Material icon and appears on the card's gradient banner.

```dart
Project(
  title: 'My New App',
  description: 'One or two lines about what it does.',
  tags: ['Flutter', 'Firebase'],
  icon: Icons.rocket_launch_outlined,
  githubUrl: 'https://github.com/ghjunaid/my-new-app',
  liveUrl: '',
  storeUrl: 'https://play.google.com/store/apps/details?id=…',
),
```

**Skills, education, certifications and contact text** are each edited in their own list or constant in the same file.

**Hero extras** are set in `profile`:
- `roles`: the lines the typewriter cycles through
- `status`: the pulsing "Currently building at…" pill. Set it to `''` to hide it.
- `heroBadges`: the tech names that float around the avatar on desktop
- `greeting`: the small line above your name

**Tech logos.** A skill or tag gets a logo automatically when its name matches an entry in `lib/widgets/tech_icons.dart`. To add a logo, add a line there; the icons come from the `simple_icons` package. Names without a match just show no logo.

**Add a new section:**
1. Create a widget in `lib/sections/` that uses `Section(navId: 'yourId', …)`.
2. Add `NavItem(id: 'yourId', label: '…')` to `navItems`.
3. Place the widget in `lib/pages/home_page.dart` with `key: _keys['yourId']`.

## Placeholders to fill in

| What | Where |
| --- | --- |
| Profile photo | Put the image in `assets/images/`, then set `profilePhoto: 'assets/images/profile.jpg'` |
| Resume PDF | `web/Junaid_Shaikh_Resume.pdf`. Replace this file to update the resume. Set `resumeUrl: ''` to hide the button. |
| Project links (GitHub / Live / Store) | `projects` in `lib/data/portfolio.dart` |
| `{SITE_URL}` | `web/index.html`, used by the Open Graph and Twitter preview tags |

## Project layout

```
lib/
├─ main.dart               app root, font preloading, theme wiring
├─ data/portfolio.dart     ALL content
├─ models/models.dart      content types
├─ pages/home_page.dart    scroll shell, active-section tracking
├─ sections/               hero, about, experience, projects, skills, education, contact, footer
├─ theme/                  colours, typography, spacing, theme persistence
├─ utils/                  breakpoints, link opening, reduced-motion check
└─ widgets/                SectionHeading, ExperienceCard, ProjectCard, SkillChip,
                           ThemeToggle, NavBar/NavDrawer, Reveal, Avatar, …
web/index.html             SEO and Open Graph tags, no-JavaScript fallback, loading splash
```

## Notes

- **Performance.** Flutter Web draws the page onto a canvas, so expect a Lighthouse Performance score of roughly 60–80. A plain HTML site would score 90+. Accessibility, Best Practices and SEO can still score high. The page's accessibility tree is always turned on, and `index.html` includes meta tags, a structured-data block and a text summary for search engines.
- **Theme.** If the visitor has chosen a theme, the site uses it (saved in `localStorage`). Otherwise it follows the browser's `prefers-color-scheme` setting.
- **Animations.** The site's effects are listed below. When the visitor's system asks for reduced motion, everything that moves on its own stops, and the logo marquee is hidden.
  - drifting background glow and a cursor glow
  - flowing gradient on your name
  - typewriter line
  - spinning avatar ring and floating tech badges
  - logo marquee
  - card spotlights and scroll reveals
- **Packages.** `flutter_animate` handles the entrance, bob and pulse effects. `simple_icons` provides the tech logos.
