import 'package:flutter/material.dart';
import '../commands/theme_commands.dart';
import '../../core/theme/theme_controller.dart';

class ThemeViewModel {
  final ThemeController controller;
  final GetThemeCommand getThemeCommand;
  final ToggleThemeCommand toggleThemeCommand;

  ThemeViewModel(this.controller, this.getThemeCommand, this.toggleThemeCommand);

  ValueNotifier<ThemeMode> get themeMode => controller.themeMode;

  Future<void> loadTheme() async {
    await getThemeCommand.execute(null);
    final isDark = getThemeCommand.resultSignal.value ?? false;
    controller.updateTheme(isDark);
  }

  Future<void> toggleTheme() async {
    final current = controller.themeMode.value == ThemeMode.dark;
    await toggleThemeCommand.execute(current);
    final isDark = toggleThemeCommand.resultSignal.value ?? !current;
    controller.updateTheme(isDark);
  }
}
