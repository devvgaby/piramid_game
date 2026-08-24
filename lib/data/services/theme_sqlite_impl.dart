import 'package:sqflite/sqflite.dart';

import 'database/app_database.dart';
import 'theme_local_storage_interface.dart';

class ThemeSqliteService implements IThemeLocalStorage {
  static const _key = 'isDarkTheme';

  final AppDatabase _appDatabase;

  ThemeSqliteService({AppDatabase? appDatabase})
      : _appDatabase = appDatabase ?? AppDatabase.instance;

  @override
  Future<bool> getTheme() async {
    final db = await _appDatabase.database;

    final rows = await db.query(
      AppDatabase.settingsTable,
      where: 'key = ?',
      whereArgs: [_key],
      limit: 1,
    );

    if (rows.isEmpty) return false;

    return rows.first['value'] == '1';
  }

  @override
  Future<void> saveTheme(bool isDark) async {
    final db = await _appDatabase.database;

    await db.insert(
      AppDatabase.settingsTable,
      {
        'key': _key,
        'value': isDark ? '1' : '0',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
