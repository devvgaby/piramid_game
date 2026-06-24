import 'package:shared_preferences/shared_preferences.dart';
import 'theme_local_storage_interface.dart';

class ThemeSharedPreferences implements IThemeLocalStorage {
  static const _key = 'isDarkTheme';

  @override
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
  }
}