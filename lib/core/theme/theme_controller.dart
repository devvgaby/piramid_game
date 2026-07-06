import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  void updateTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}