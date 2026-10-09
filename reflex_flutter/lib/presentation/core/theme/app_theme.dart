import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class ReflexTheme {
  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          surface: ReflexColors.darkSurface,
          primary: ReflexColors.primary,
          secondary: ReflexColors.accent,
          error: ReflexColors.chromaticRed,
        ),
        scaffoldBackgroundColor: ReflexColors.darkBackground,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: ReflexColors.darkBackground,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ReflexColors.darkSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.darkBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.primary, width: 1.5),
          ),
        ),
        cardTheme: CardThemeData(
          color: ReflexColors.darkCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: ReflexColors.darkBorder),
          ),
        ),
        useMaterial3: true,
      );

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          surface: ReflexColors.lightSurface,
          primary: ReflexColors.primary,
          secondary: ReflexColors.accent,
          error: ReflexColors.chromaticRed,
        ),
        scaffoldBackgroundColor: ReflexColors.lightBackground,
        textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: ReflexColors.lightBackground,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ReflexColors.lightSurface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.lightBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.lightBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: ReflexColors.primary, width: 1.5),
          ),
        ),
        cardTheme: CardThemeData(
          color: ReflexColors.lightCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: ReflexColors.lightBorder),
          ),
        ),
        useMaterial3: true,
      );
}
