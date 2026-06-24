import '../services/theme_local_storage_interface.dart';
import 'theme_repository_interface.dart';

class ThemeRepositoryImpl implements IThemeRepository {
  final IThemeLocalStorage local;

  ThemeRepositoryImpl(this.local);

  @override
  Future<bool> getTheme() {
    return local.getThemeMode();
  }

  @override
  Future<void> saveTheme(bool isDark) {
    return local.saveThemeMode(isDark ? 'dark' : 'light');
  }
}