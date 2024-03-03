import 'package:flutter/material.dart';
import 'package:journal_app/models/journal_entry.dart';

class JournalList extends StatelessWidget {
  const JournalList({super.key, required this.context, required this.entries});
  final BuildContext context;
  final List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const FlutterLogo(),
            trailing: const Icon(Icons.edit),
            title: Text("Journal Entry ${entries[index].title}"),
            subtitle: Text("Example ${entries[index].dateTime}"),
          );
        },
      ),
    );
  }
}
