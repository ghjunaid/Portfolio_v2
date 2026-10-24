import 'dart:ui' show SemanticsRole;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../data/constant.dart';
import '../sections/about_section.dart';
import '../sections/contact_section.dart';
import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../utils/reduced_motion.dart';
import '../widgets/aurora_background.dart';
import '../widgets/nav_bar.dart';

/// Single scrolling page. Tracks which section is in view (for the nav
/// highlight) and scrolls smoothly to a section when a link is chosen.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  final _activeId = ValueNotifier<String>('home');
  final _scrolled = ValueNotifier<bool>(false);
  final _progress = ValueNotifier<double>(0);
  final _pointer = ValueNotifier<Offset?>(null);
  late final Map<String, GlobalKey> _keys = {
    'home': GlobalKey(debugLabel: 'home'),
    for (final item in navItems) item.id: GlobalKey(debugLabel: item.id),
  };

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    _activeId.dispose();
    _scrolled.dispose();
    _progress.dispose();
    _pointer.dispose();
    super.dispose();
  }

  void _onScroll() {
    _scrolled.value = _scroll.offset > 8;
    final position = _scroll.position;
    _progress.value = position.maxScrollExtent > 0
        ? position.pixels / position.maxScrollExtent
        : 0;

    // The active section is the last one whose top has passed ~35% of the
    // viewport. At the very bottom, the last section wins even if short.
    if (position.pixels >= position.maxScrollExtent - 4) {
      _activeId.value = navItems.last.id;
      return;
    }
    final threshold = position.viewportDimension * 0.35;
    var current = 'home';
    for (final MapEntry(:key, :value) in _keys.entries) {
      final box = value.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy <= threshold) current = key;
    }
    _activeId.value = current;
  }

  void _onHover(PointerHoverEvent e) {
    if (e.kind == PointerDeviceKind.mouse) _pointer.value = e.localPosition;
  }

  void _scrollTo(String id) {
    final target = _keys[id]?.currentContext;
    if (target == null) return;
    final reduce = prefersReducedMotion(context);
    Scrollable.ensureVisible(
      target,
      duration: reduce ? Duration.zero : const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(activeId: _activeId, onNavigate: _scrollTo),
      body: MouseRegion(
        onHover: _onHover,
        onExit: (_) => _pointer.value = null,
        child: Stack(
          children: [
            const Positioned.fill(child: AuroraBackground()),
            Positioned.fill(child: CursorGlow(pointer: _pointer)),
            Positioned.fill(
              child: SelectionArea(
                child: SingleChildScrollView(
                  controller: _scroll,
                  child: Column(
                    children: [
                      Semantics(
                        role: SemanticsRole.main,
                        child: Column(
                          children: [
                            HeroSection(
                              key: _keys['home'],
                              onViewProjects: () => _scrollTo('projects'),
                            ),
                            AboutSection(key: _keys['about']),
                            ExperienceSection(key: _keys['experience']),
                            ProjectsSection(key: _keys['projects']),
                            SkillsSection(key: _keys['skills']),
                            EducationSection(key: _keys['education']),
                            ContactSection(key: _keys['contact']),
                          ],
                        ),
                      ),
                      FooterSection(onBackToTop: () => _scrollTo('home')),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                activeId: _activeId,
                scrolled: _scrolled,
                onNavigate: _scrollTo,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ScrollProgressBar(progress: _progress),
            ),
          ],
        ),
      ),
    );
  }
}
