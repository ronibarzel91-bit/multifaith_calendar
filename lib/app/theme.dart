import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ColorScheme celestialColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF1E3A8A), // Deep Indigo
  primary: const Color(0xFF1E3A8A),
  secondary: const Color(0xFFD4AF37), // Metallic Gold
  surface: Colors.white,
  background: const Color(0xFFF8FAFC),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: celestialColorScheme,
  textTheme: GoogleFonts.outfitTextTheme(),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: GoogleFonts.outfit(
      color: const Color(0xFF1E293B),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: Colors.grey.withOpacity(0.1)),
    ),
    color: Colors.white,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.withOpacity(0.05),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5),
    ),
  ),
);

