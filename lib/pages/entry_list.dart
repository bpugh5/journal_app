import 'package:flutter/material.dart';
import 'package:journal_app/db/database_manager.dart';
import 'package:journal_app/db/journal_entry_dao.dart';
import 'package:journal_app/models/journal.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/widgets/journal_list.dart';
import 'package:journal_app/widgets/journal_scaffold.dart';

// This page displays all journal entries

class EntryListScreen extends StatefulWidget {
  const EntryListScreen({super.key});

  static const routeName = '/';

  @override
  State<EntryListScreen> createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
  Journal? journal;

  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final DatabaseManager databaseManager = DatabaseManager.getInstance();
    List<JournalEntry> journalEntries =
        await JournalEntryDAO.journalEntries(databaseManager: databaseManager);
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
              ? welcomeScreen()
              : JournalList(context: context, entries: journal!.entries));
    }
  }

  Widget welcomeScreen() {
    return const Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.edit_document,
              size: 100,
            ),
            Text("Journal")
          ]),
    );
  }
}