import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle displaySmall(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle headlineLarge(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle headlineMedium(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle titleLarge(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle titleMedium(BuildContext context) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle labelLarge(BuildContext context) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: Theme.of(context).colorScheme.onBackground,
      );

  static TextStyle codeStyle(BuildContext context) =>
      GoogleFonts.firaCode(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.primary,
      );

  // Gradient/Hero styles
  static TextStyle heroName = GoogleFonts.poppins(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    color: Colors.white,
  );

  static TextStyle heroNameMobile = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: Colors.white,
  );

  static TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );
}
