import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 4/8px spacing scale used across the site.
abstract final class Space {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
  static const double section = 96;
}

abstract final class Radii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double pill = 999;
}

/// Extra design tokens for the "vibe" layer: gradient stops, glass surfaces,
/// background blobs and the monospace label font.
class Vibe extends ThemeExtension<Vibe> {
  const Vibe({
    required this.accent,
    required this.accent2,
    required this.accent3,
    required this.glass,
    required this.glassBorder,
    required this.blobOpacity,
    required this.dotColor,
    this.mono = const TextStyle(fontFamily: 'monospace'),
  });

  final Color accent;
  final Color accent2;
  final Color accent3;

  /// Translucent card fill and hairline border.
  final Color glass;
  final Color glassBorder;

  /// Strength of the animated background blobs.
  final double blobOpacity;
  final Color dotColor;
  final TextStyle mono;

  List<Color> get gradientColors => [accent, accent2, accent3];

  LinearGradient get gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accent2],
  );

  static Vibe of(BuildContext context) => Theme.of(context).extension<Vibe>()!;

  @override
  Vibe copyWith({TextStyle? mono}) => Vibe(
    accent: accent,
    accent2: accent2,
    accent3: accent3,
    glass: glass,
    glassBorder: glassBorder,
    blobOpacity: blobOpacity,
    dotColor: dotColor,
    mono: mono ?? this.mono,
  );

  @override
  Vibe lerp(Vibe? other, double t) {
    if (other == null) return this;
    return Vibe(
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      accent3: Color.lerp(accent3, other.accent3, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      glassBorder: Color.lerp(glassBorder, other.glassBorder, t)!,
      blobOpacity: blobOpacity + (other.blobOpacity - blobOpacity) * t,
      dotColor: Color.lerp(dotColor, other.dotColor, t)!,
      mono: t < 0.5 ? mono : other.mono,
    );
  }
}

abstract final class AppTheme {
  // Emerald accent. The light-mode shade is darker so text and icons keep
  // WCAG AA contrast on a white background.
  static const _accentDark = Color(0xFF10B981);
  static const _accentLight = Color(0xFF047857);

  static ThemeData dark({bool useGoogleFonts = true}) => _build(
    brightness: Brightness.dark,
    useGoogleFonts: useGoogleFonts,
    vibe: const Vibe(
      accent: Color(0xFF34D399),
      accent2: Color(0xFF22D3EE),
      accent3: Color(0xFF818CF8),
      glass: Color(0x0DFFFFFF),
      glassBorder: Color(0x1AFFFFFF),
      blobOpacity: 0.22,
      dotColor: Color(0x14FFFFFF),
    ),
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _accentDark,
      onPrimary: Color(0xFF02140D),
      primaryContainer: Color(0xFF0B2A21),
      onPrimaryContainer: Color(0xFF6EE7B7),
      secondary: _accentDark,
      onSecondary: Color(0xFF02140D),
      error: Color(0xFFF87171),
      onError: Color(0xFF1F0000),
      surface: Color(0xFF070A10),
      onSurface: Color(0xFFE6EDF3),
      onSurfaceVariant: Color(0xFF9AA7B4),
      surfaceContainer: Color(0xFF0D131B),
      surfaceContainerHigh: Color(0xFF151D27),
      outline: Color(0xFF334155),
      outlineVariant: Color(0xFF1F2A35),
    ),
  );

  static ThemeData light({bool useGoogleFonts = true}) => _build(
    brightness: Brightness.light,
    useGoogleFonts: useGoogleFonts,
    // Darker gradient stops so gradient text keeps AA contrast on white.
    vibe: const Vibe(
      accent: Color(0xFF047857),
      accent2: Color(0xFF0E7490),
      accent3: Color(0xFF4F46E5),
      glass: Color(0xB3FFFFFF),
      glassBorder: Color(0x140F172A),
      blobOpacity: 0.16,
      dotColor: Color(0x140F172A),
    ),
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _accentLight,
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD1FAE5),
      onPrimaryContainer: Color(0xFF064E3B),
      secondary: _accentLight,
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFB91C1C),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFF8FAFC),
      onSurface: Color(0xFF0F172A),
      onSurfaceVariant: Color(0xFF475569),
      surfaceContainer: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xFFF1F5F9),
      outline: Color(0xFFCBD5E1),
      outlineVariant: Color(0xFFE2E8F0),
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Vibe vibe,
    required bool useGoogleFonts,
  }) {
    final base = ThemeData(brightness: brightness, useMaterial3: true);
    final mono = useGoogleFonts
        ? GoogleFonts.jetBrainsMono(fontWeight: FontWeight.w500)
        : const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w500);
    // Body text stays at 16px minimum; headings use the display font.
    final body = useGoogleFonts
        ? GoogleFonts.interTextTheme(base.textTheme)
        : base.textTheme;
    TextStyle? display(TextStyle? s) =>
        useGoogleFonts ? GoogleFonts.spaceGrotesk(textStyle: s) : s;

    final textTheme = body
        .copyWith(
          displayLarge: display(
            body.displayLarge?.copyWith(
              fontSize: 56,
              fontWeight: FontWeight.w700,
              height: 1.05,
              letterSpacing: -1.5,
            ),
          ),
          displaySmall: display(
            body.displaySmall?.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          headlineMedium: display(
            body.headlineMedium?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          titleLarge: display(
            body.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          titleMedium: body.titleMedium?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: body.bodyLarge?.copyWith(fontSize: 18, height: 1.6),
          bodyMedium: body.bodyMedium?.copyWith(fontSize: 16, height: 1.6),
          labelLarge: body.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          labelMedium: body.labelMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    const minTap = Size(44, 44);
    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.md),
    );
    const buttonPadding = EdgeInsets.symmetric(
      horizontal: Space.lg,
      vertical: Space.md,
    );

    return base.copyWith(
      extensions: [vibe.copyWith(mono: mono)],
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      dividerColor: scheme.outlineVariant,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      focusColor: scheme.primary.withValues(alpha: 0.18),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: minTap,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minTap,
          padding: buttonPadding,
          shape: buttonShape,
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: minTap,
          shape: buttonShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(minimumSize: minTap),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: scheme.surface,
        shape: const RoundedRectangleBorder(),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
