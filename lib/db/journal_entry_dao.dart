import 'package:journal_app/db/database_manager.dart';
import 'package:journal_app/models/journal_entry.dart';

class JournalEntryDAO {
  static Future<List<JournalEntry>> journalEntries(
      {required DatabaseManager databaseManager}) async {
    final List<Map> journalRecords = await databaseManager.journalEntries();
    return journalRecords.map((record) {
      return JournalEntry(
          title: record['title']!,
          body: record['body']!,
          rating: record['rating'],
          dateTime: DateTime.parse(record['date']!));
    }).toList();
  }
}
