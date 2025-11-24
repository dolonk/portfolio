import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../responsive/responsive_helper.dart';

class DFontSizes {
  factory DFontSizes.of(BuildContext context) => DFontSizes._fromContext(context);

  // ✅ Display font sizes (Hero section) - RAJDHANI
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;

  // ✅ Headline font sizes (Section titles) - RAJDHANI
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;

  // ✅ Title font sizes (Subheadings) - RAJDHANI
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  // ✅ Body font sizes (Normal text) - RUBIK
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  // ✅ Label font sizes (Small text, captions) - RUBIK
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  // Private named constructor
  DFontSizes._internal({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  // Build AppFonts instance dynamically based on context
  factory DFontSizes._fromContext(BuildContext context) {
    final mobile = _MobileFonts();
    final tablet = _TabletFonts();
    final desktop = _DesktopFonts();

    TextStyle res(
      TextStyle Function(_MobileFonts m) m,
      TextStyle Function(_TabletFonts t) t,
      TextStyle Function(_DesktopFonts d) d,
    ) {
      return ResponsiveHelper.value(context, mobile: m(mobile), tablet: t(tablet), desktop: d(desktop));
    }

    return DFontSizes._internal(
      // Display fonts (RAJDHANI - Hero section)
      displayLarge: res((m) => m.displayLarge, (t) => t.displayLarge, (d) => d.displayLarge),
      displayMedium: res((m) => m.displayMedium, (t) => t.displayMedium, (d) => d.displayMedium),
      displaySmall: res((m) => m.displaySmall, (t) => t.displaySmall, (d) => d.displaySmall),

      // Headline fonts (RAJDHANI - Section titles)
      headlineLarge: res((m) => m.headlineLarge, (t) => t.headlineLarge, (d) => d.headlineLarge),
      headlineMedium: res((m) => m.headlineMedium, (t) => t.headlineMedium, (d) => d.headlineMedium),
      headlineSmall: res((m) => m.headlineSmall, (t) => t.headlineSmall, (d) => d.headlineSmall),

      // Title fonts (RAJDHANI - Subheadings)
      titleLarge: res((m) => m.titleLarge, (t) => t.titleLarge, (d) => d.titleLarge),
      titleMedium: res((m) => m.titleMedium, (t) => t.titleMedium, (d) => d.titleMedium),
      titleSmall: res((m) => m.titleSmall, (t) => t.titleSmall, (d) => d.titleSmall),

      // Body fonts (RUBIK - Normal text)
      bodyLarge: res((m) => m.bodyLarge, (t) => t.bodyLarge, (d) => d.bodyLarge),
      bodyMedium: res((m) => m.bodyMedium, (t) => t.bodyMedium, (d) => d.bodyMedium),
      bodySmall: res((m) => m.bodySmall, (t) => t.bodySmall, (d) => d.bodySmall),

      // Label fonts (RUBIK - Small text, captions)
      labelLarge: res((m) => m.labelLarge, (t) => t.labelLarge, (d) => d.labelLarge),
      labelMedium: res((m) => m.labelMedium, (t) => t.labelMedium, (d) => d.labelMedium),
      labelSmall: res((m) => m.labelSmall, (t) => t.labelSmall, (d) => d.labelSmall),
    );
  }
}

/// ============== DEVICE-SPECIFIC FONT DEFINITIONS =================
class _MobileFonts {
  // Display fonts (RAJDHANI - Hero section)
  late final TextStyle displayLarge = GoogleFonts.rajdhani(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displayMedium = GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displaySmall = GoogleFonts.rajdhani(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );

  // Headline fonts (RAJDHANI - Section titles)
  late final TextStyle headlineLarge = GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineMedium = GoogleFonts.rajdhani(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineSmall = GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Title fonts (RAJDHANI - Subheadings)
  late final TextStyle titleLarge = GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleMedium = GoogleFonts.rajdhani(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleSmall = GoogleFonts.rajdhani(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Body fonts (RUBIK - Normal text)
  late final TextStyle bodyLarge = GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodyMedium = GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodySmall = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );

  // Label fonts (RUBIK - Small text, captions)
  late final TextStyle labelLarge = GoogleFonts.rubik(fontSize: 14, fontWeight: FontWeight.w500);
  late final TextStyle labelMedium = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
  late final TextStyle labelSmall = GoogleFonts.rubik(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
}

class _TabletFonts {
  // Display fonts (RAJDHANI - Hero section)
  late final TextStyle displayLarge = GoogleFonts.rajdhani(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displayMedium = GoogleFonts.rajdhani(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displaySmall = GoogleFonts.rajdhani(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );

  // Headline fonts (RAJDHANI - Section titles)
  late final TextStyle headlineLarge = GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineMedium = GoogleFonts.rajdhani(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineSmall = GoogleFonts.rajdhani(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Title fonts (RAJDHANI - Subheadings)
  late final TextStyle titleLarge = GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleMedium = GoogleFonts.rajdhani(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleSmall = GoogleFonts.rajdhani(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Body fonts (RUBIK - Normal text)
  late final TextStyle bodyLarge = GoogleFonts.rubik(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodyMedium = GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodySmall = GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );

  // Label fonts (RUBIK - Small text, captions)
  late final TextStyle labelLarge = GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
  late final TextStyle labelMedium = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
  late final TextStyle labelSmall = GoogleFonts.rubik(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
}

class _DesktopFonts {
  // Display fonts (RAJDHANI - Hero section)
  late final TextStyle displayLarge = GoogleFonts.rajdhani(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displayMedium = GoogleFonts.rajdhani(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle displaySmall = GoogleFonts.rajdhani(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );

  // Headline fonts (RAJDHANI - Section titles)
  late final TextStyle headlineLarge = GoogleFonts.rajdhani(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineMedium = GoogleFonts.rajdhani(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: DColors.textPrimary,
  );
  late final TextStyle headlineSmall = GoogleFonts.rajdhani(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Title fonts (RAJDHANI - Subheadings)
  late final TextStyle titleLarge = GoogleFonts.rajdhani(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleMedium = GoogleFonts.rajdhani(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );
  late final TextStyle titleSmall = GoogleFonts.rajdhani(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: DColors.textPrimary,
  );

  // Body fonts (RUBIK - Normal text)
  late final TextStyle bodyLarge = GoogleFonts.rubik(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodyMedium = GoogleFonts.rubik(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );
  late final TextStyle bodySmall = GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: DColors.textPrimary,
  );

  // Label fonts (RUBIK - Small text, captions)
  late final TextStyle labelLarge = GoogleFonts.rubik(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
  late final TextStyle labelMedium = GoogleFonts.rubik(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: DColors.textPrimary,
  );
  late final TextStyle labelSmall = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: DColors.textPrimary,
  );
}

/// ✅ Quick access extension
extension AppFontsShorthand on BuildContext {
  DFontSizes get fonts => DFontSizes.of(this);
}

extension TextStyleCustom on TextStyle {
  /// 🔹 Rajdhani font with customizable properties
  TextStyle rajdhani({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.rajdhani(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  /// 🔹 Rubik font with customizable properties
  TextStyle rubik({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    TextDecoration? decoration,
    Color? decorationColor,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.rubik(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      color: color ?? this.color,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  /// 🔹 Quick weight changer (keeps current font family if possible)
  TextStyle weight(FontWeight w) {
    return copyWith(fontWeight: w);
  }

  /// 🔹 Quick color changer
  TextStyle withColor(Color c) {
    return copyWith(color: c);
  }

  /// 🔹 Quick size changer
  TextStyle withSize(double s) {
    return copyWith(fontSize: s);
  }
}

/*
Mobile  →  Tablet  →  Desktop
32      →  40      →  48        (displayLarge)
28      →  36      →  44        (displayMedium)
24      →  32      →  40        (displaySmall)

22      →  28      →  32        (headlineLarge)
20      →  26      →  28        (headlineMedium)
18      →  24      →  26        (headlineSmall)

18      →  22      →  26        (titleLarge)
16      →  20      →  24        (titleMedium)
14      →  18      →  22        (titleSmall)

16      →  18      →  20        (bodyLarge)
14      →  16      →  18        (bodyMedium)
12      →  14      →  16        (bodySmall)

14      →  14      →  16        (labelLarge)
12      →  12      →  14        (labelMedium)
10      →  10      →  12        (labelSmall)
*/
