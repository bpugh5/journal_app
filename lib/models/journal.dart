import 'package:journal_app/models/journal_entry.dart';

class Journal {
  Journal({required this.entries});

  List<JournalEntry> entries = [];

  bool isEmpty() {
    return entries.isEmpty;
  }
}
