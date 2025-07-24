import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF121212), // Dark background for lock screen
      scaffoldBackgroundColor: Colors.transparent, // Transparent for background image
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF121212),
        secondary: Color(0xFF2ECC71), // Green accent for buttons
        surface: Colors.white10,
        onSurface: Colors.white70,
      ),
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        headlineSmall: GoogleFonts.roboto(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white70,
        ),
        labelLarge: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2ECC71), // Green accent for buttons
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          elevation: 8,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.15), // Darker glassmorphism effect
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIconColor: Colors.white70,
        suffixIconColor: Colors.white70,
      ),
    );
  }

  // Darker gradient for glassmorphism effect
  static LinearGradient get cardGradient => const LinearGradient(
        colors: [
          Color(0xFF121212),
          Color(0xFF3949AB),
          Color(0xFF303F9F),
          Color(0xFF1A237E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}