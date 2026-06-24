class ThemeViewModel {
  final ThemeController controller;

  ThemeViewModel(this.controller);

  ThemeMode get themeMode => controller.themeMode.value;

  Future<void> loadTheme() => controller.loadTheme();

  Future<void> toggleTheme() => controller.toggleTheme();
}