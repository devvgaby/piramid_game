import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AppDatabase {
  AppDatabase._internal();

  static final AppDatabase instance = AppDatabase._internal();

  static const String _dbName = 'piramid_game.db';
  static const int _dbVersion = 1;

  static const String studentsTable = 'students';
  static const String settingsTable = 'settings';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    _setDatabaseFactory();

    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  void _setDatabaseFactory() {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return;
    }

    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $studentsTable (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        course TEXT NOT NULL,
        classYear INTEGER NOT NULL,
        nickname TEXT NOT NULL,
        birthDate TEXT NOT NULL,
        resenha INTEGER NOT NULL,
        presencaVip INTEGER NOT NULL,
        aura INTEGER NOT NULL,
        modoParceiro INTEGER NOT NULL,
        carismaNatural INTEGER NOT NULL,
        humorMilhoes INTEGER NOT NULL,
        energiaGrupo INTEGER NOT NULL,
        criatividadeCaotica INTEGER NOT NULL,
        modoAtleta INTEGER NOT NULL,
        talentoPalco INTEGER NOT NULL,
        dripEscolar INTEGER NOT NULL,
        coracaoDorama INTEGER NOT NULL,
        queridinhoProfessores INTEGER NOT NULL,
        cerebroTurbo INTEGER NOT NULL,
        caosControlado INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $settingsTable (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> close() async {
    final db = _database;

    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}