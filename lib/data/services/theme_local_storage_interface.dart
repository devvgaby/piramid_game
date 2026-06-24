abstract class IThemeLocalStorage {
  Future<void> saveTheme(bool isDark);
  Future<bool> getTheme();
}