import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

class TechIcon {
  const TechIcon(this.icon, this.color);

  final IconData icon;

  /// Brand colour, or null to use the theme's text colour.
  final Color? color;
}

// Keys are lower-case skill/tag names as written in lib/data/constant.dart.
// Anything missing here simply renders without an icon.
const _icons = <String, TechIcon>{
  'flutter': TechIcon(SimpleIcons.flutter, SimpleIconColors.flutter),
  'dart': TechIcon(SimpleIcons.dart, SimpleIconColors.dart),
  'react.js': TechIcon(SimpleIcons.react, SimpleIconColors.react),
  'react native': TechIcon(SimpleIcons.react, SimpleIconColors.react),
  'react router': TechIcon(
    SimpleIcons.reactrouter,
    SimpleIconColors.reactrouter,
  ),
  'next.js': TechIcon(SimpleIcons.nextdotjs, null),
  'tailwind css': TechIcon(
    SimpleIcons.tailwindcss,
    SimpleIconColors.tailwindcss,
  ),
  'fastapi': TechIcon(SimpleIcons.fastapi, SimpleIconColors.fastapi),
  'node.js': TechIcon(SimpleIcons.nodedotjs, SimpleIconColors.nodedotjs),
  'laravel': TechIcon(SimpleIcons.laravel, SimpleIconColors.laravel),
  'firebase': TechIcon(SimpleIcons.firebase, SimpleIconColors.firebase),
  'socket.io': TechIcon(SimpleIcons.socketdotio, null),
  'python': TechIcon(SimpleIcons.python, SimpleIconColors.python),
  'javascript': TechIcon(SimpleIcons.javascript, SimpleIconColors.javascript),
  'typescript': TechIcon(SimpleIcons.typescript, SimpleIconColors.typescript),
  'java': TechIcon(SimpleIcons.openjdk, null),
  'c': TechIcon(SimpleIcons.c, SimpleIconColors.c),
  'c++': TechIcon(SimpleIcons.cplusplus, SimpleIconColors.cplusplus),
  'postgresql': TechIcon(SimpleIcons.postgresql, SimpleIconColors.postgresql),
  'mysql': TechIcon(SimpleIcons.mysql, SimpleIconColors.mysql),
  'mongodb': TechIcon(SimpleIcons.mongodb, SimpleIconColors.mongodb),
  'html': TechIcon(SimpleIcons.html5, SimpleIconColors.html5),
  'css': TechIcon(SimpleIcons.css, SimpleIconColors.css),
  'sql': TechIcon(Icons.table_chart_outlined, null),
  'oracle db': TechIcon(Icons.storage_rounded, null),
  'rest api': TechIcon(Icons.api_rounded, null),
  'rest apis': TechIcon(Icons.api_rounded, null),
  'ui/ux': TechIcon(Icons.design_services_outlined, null),
  'ui/ux design': TechIcon(Icons.design_services_outlined, null),
  'graphic design': TechIcon(Icons.brush_outlined, null),
  'web design': TechIcon(Icons.web_outlined, null),
  'responsive design': TechIcon(Icons.devices_outlined, null),
  'arduino': TechIcon(SimpleIcons.arduino, SimpleIconColors.arduino),
  'raspberry pi': TechIcon(
    SimpleIcons.raspberrypi,
    SimpleIconColors.raspberrypi,
  ),
  'embedded c/c++': TechIcon(Icons.memory_rounded, null),
  'tensorflow': TechIcon(SimpleIcons.tensorflow, SimpleIconColors.tensorflow),
  'hugging face': TechIcon(
    SimpleIcons.huggingface,
    SimpleIconColors.huggingface,
  ),
  'git': TechIcon(SimpleIcons.git, SimpleIconColors.git),
  'github': TechIcon(SimpleIcons.github, null),
};

TechIcon? techIconFor(String name) => _icons[name.toLowerCase()];

/// Brand colour adjusted to read on the current background: near-black
/// logos use the fallback, deep colours are lifted toward white in dark
/// mode, and very light colours fall back on white backgrounds.
Color techIconColor(TechIcon tech, Color fallback, Brightness brightness) {
  final c = tech.color;
  if (c == null) return fallback;
  final lum = c.computeLuminance();
  if (brightness == Brightness.dark) {
    if (lum < 0.05) return fallback;
    if (lum < 0.3) return Color.lerp(c, Colors.white, 0.4)!;
    return c;
  }
  return lum > 0.6 ? fallback : c;
}
