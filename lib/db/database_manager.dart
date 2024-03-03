import 'package:flutter/services.dart';
import 'package:journal_app/db/journal_entry_dto.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const String DATABASE_FILENAME = 'journal.sqlite3.db';
  static const String SQL_CREATE_SCHEMA = 'assets/schema_1.sql.txt';
  static const String SQL_INSERT = 'INSERT INTO journal_entries(title, body, rating, date) VALUES(?, ?, ?, ?)';
  static const String SQL_SELECT = 'SELECT * FROM journal_entries';

  static DatabaseManager? _instance;

  final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance!;
  }

  static Future initialize() async {
    final db = await openDatabase(DATABASE_FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      createTables(db, await rootBundle.loadString(SQL_CREATE_SCHEMA));
    });
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({required JournalEntryDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT,
          [dto.title, dto.body, dto.rating, dto.dateTime.toString()]);
    });
  }

  Future<List<Map>> journalEntries() async {
    return db.rawQuery(SQL_SELECT);
  }
}
