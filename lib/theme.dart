import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Serafina Colors
  static const Color serafinaPurple = Color(0xFF7B73FF); // Periwinkle
  static const Color serafinaDarkPurple = Color(0xFF5850DD);
  static const Color serafinaYellow = Color(0xFFF3F96D); // Lemon
  static const Color serafinaPink = Color(0xFFFF8FAB);

  // Dark theme colors
  static const Color darkBackground = Color(
    0xFF0A0A0F,
  ); // Very dark purple-black
  static const Color darkSurface = Color(0xFF1A1A2E); // Dark purple-grey
  static const Color darkCard = Color(
    0xFF252540,
  ); // Slightly lighter dark purple

  // Light theme - Current Serafina design
  static ThemeData light =
      FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: serafinaYellow,
          primaryContainer: serafinaDarkPurple,
          secondary: serafinaPink,
          secondaryContainer: Color(0xFFFFD4E5),
          tertiary: Color(0xFF2E2E3A),
          tertiaryContainer: Color(0xFFE8E8F0),
          appBarColor: serafinaPurple,
          error: Color(0xFFFF6B6B),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 0,
        scaffoldBackground: serafinaPurple,
        surface: serafinaPurple,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 0,
          useM2StyleDividerInM3: true,
          defaultRadius: 32,
          cardRadius: 32,
          fabRadius: 32,
          inputDecoratorRadius: 24,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
      ).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          height: 80,
          backgroundColor: serafinaDarkPurple,
          indicatorColor: serafinaYellow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.outfit(
                fontSize: 14,
                color: serafinaYellow,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              );
            }
            return GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: serafinaPurple, size: 28);
            }
            return const IconThemeData(color: Colors.white70, size: 26);
          }),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSerifDisplay(
            fontSize: 56,
            color: serafinaYellow,
            height: 1.0,
          ),
          displayMedium: GoogleFonts.dmSerifDisplay(
            fontSize: 42,
            color: Colors.white,
          ),
          headlineMedium: GoogleFonts.dmSerifDisplay(
            fontSize: 28,
            color: serafinaYellow,
          ),
          titleLarge: GoogleFonts.dmSerifDisplay(
            fontSize: 22,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.outfit(fontSize: 16, color: Colors.white),
          bodyMedium: GoogleFonts.outfit(fontSize: 14, color: Colors.white70),
        ),
      );

  // Dark theme - Darker variant of Serafina
  static ThemeData dark =
      FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: serafinaYellow,
          primaryContainer: darkCard,
          secondary: serafinaPink,
          secondaryContainer: Color(0xFF3A1A2D),
          tertiary: Colors.white,
          tertiaryContainer: Color(0xFF1E1E2E),
          appBarColor: darkSurface,
          error: Color(0xFFFF6B6B),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 0,
        scaffoldBackground: darkBackground,
        surface: darkBackground,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 0,
          useM2StyleDividerInM3: true,
          defaultRadius: 32,
          cardRadius: 32,
          fabRadius: 32,
          inputDecoratorRadius: 24,
          navigationBarIndicatorSchemeColor: SchemeColor.primary,
          navigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        fontFamily: GoogleFonts.dmSerifDisplay().fontFamily,
      ).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          height: 80,
          backgroundColor: darkCard,
          indicatorColor: serafinaYellow,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.outfit(
                fontSize: 14,
                color: serafinaYellow,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              );
            }
            return GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white60,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: darkBackground, size: 28);
            }
            return const IconThemeData(color: Colors.white60, size: 26);
          }),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSerifDisplay(
            fontSize: 56,
            color: serafinaYellow,
            height: 1.0,
          ),
          displayMedium: GoogleFonts.dmSerifDisplay(
            fontSize: 42,
            color: Colors.white,
          ),
          headlineMedium: GoogleFonts.dmSerifDisplay(
            fontSize: 28,
            color: serafinaYellow,
          ),
          titleLarge: GoogleFonts.dmSerifDisplay(
            fontSize: 22,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.outfit(fontSize: 16, color: Colors.white),
          bodyMedium: GoogleFonts.outfit(fontSize: 14, color: Colors.white70),
        ),
      );
}
