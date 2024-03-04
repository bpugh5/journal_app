import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/widgets/entry_details.dart';

class JournalList extends StatelessWidget {
  const JournalList({super.key, required this.context, required this.entries});
  final BuildContext context;
  final List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth < 500
          ? VerticalLayout(context: context, entries: entries)
          : HorizontalLayout(context: context, entries: entries);
    });
  }
}

class VerticalLayout extends StatelessWidget {
  const VerticalLayout(
      {super.key, required this.context, required this.entries});
  final BuildContext context;
  final List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              showModalBottomSheet(
                context: context,
                constraints: const BoxConstraints.expand(),
                builder: (BuildContext context) {
                  return EntryDetails(entry: entries[index]);
                },
                isDismissible: true,
              );
            },
            title: Text(entries[index].title),
            subtitle: Text(
                DateFormat('EEEE, MMMM d, y').format(entries[index].dateTime)),
          );
        },
      ),
    );
  }
}

class HorizontalLayout extends StatelessWidget {
  const HorizontalLayout(
      {super.key, required this.context, required this.entries});
  final BuildContext context;
  final List<JournalEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(entries[index].title),
                  subtitle: Text(DateFormat('EEEE, MMMM d, y')
                      .format(entries[index].dateTime)),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return EntryDetails(entry: entries[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
