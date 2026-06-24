abstract class IThemeRepository {
  Future<bool> getTheme();
  Future<void> saveTheme(bool isDark);
}