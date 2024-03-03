import 'package:flutter/material.dart';
import 'package:journal_app/db/database_manager.dart';
import 'package:journal_app/db/journal_entry_dao.dart';
import 'package:journal_app/models/journal.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/widgets/journal_list.dart';
import 'package:journal_app/widgets/journal_scaffold.dart';

class JournalEntryListScreen extends StatefulWidget {
  const JournalEntryListScreen({super.key});

  static const routeName = '/';

  @override
  State<JournalEntryListScreen> createState() => _JournalEntryListScreenState();
}

class _JournalEntryListScreenState extends State<JournalEntryListScreen> {
  Journal? journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final DatabaseManager databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalEntries = await JournalEntryDAO.journalEntries(databaseManager: databaseManager);
    setState(() {
      journal = Journal(entries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (journal == null) {
      return const JournalScaffold(
          title: 'Loading...',
          fab: true,
          child: Center(child: CircularProgressIndicator()));
    } else {
      return JournalScaffold(
          title: journal!.isEmpty() ? 'Welcome' : 'Journal Entries',
          fab: true,
          child: journal!.isEmpty()
              ? const Placeholder()
              : JournalList(context: context, entries: journal!.entries));
    }
  }
}
