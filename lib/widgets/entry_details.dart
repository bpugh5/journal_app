import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal_app/models/journal_entry.dart';

class EntryDetails extends StatelessWidget {
  const EntryDetails({super.key, required this.entry});
  final JournalEntry entry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            entry.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            entry.body,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Date Created: ${DateFormat('EEEE, MMMM d, y').format(entry.dateTime)}",
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Rating: ${entry.rating}",
            style: Theme.of(context).textTheme.bodyLarge
          ),
        ),
      ],
    );
  }
}
