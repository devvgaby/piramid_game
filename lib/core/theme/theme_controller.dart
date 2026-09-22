import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ThemeController {
  final themeMode = signal<ThemeMode>(ThemeMode.light);

  void updateTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}