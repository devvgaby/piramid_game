import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6C5CE7),
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6C5CE7),
    scaffoldBackgroundColor: const Color(0xFF121212),
    useMaterial3: true,
  );
}