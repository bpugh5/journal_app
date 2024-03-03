import 'package:flutter/material.dart';
import 'package:journal_app/db/database_manager.dart';
import 'package:journal_app/db/journal_entry_dto.dart';
import 'package:journal_app/widgets/journal_scaffold.dart';

class JournalEntryFormPage extends StatefulWidget {
  const JournalEntryFormPage({super.key});

  static const routeName = 'new';

  @override
  State<JournalEntryFormPage> createState() => _JournalEntryFormPageState();
}

class _JournalEntryFormPageState extends State<JournalEntryFormPage> {
  final formKey = GlobalKey<FormState>();
  final journalEntryValues = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return JournalScaffold(
      title: 'New Journal Entry',
      fab: false,
      child: formContent(context),
    );
  }

  Widget formContent(context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            titleTextField(),
            const SizedBox(height: 10),
            bodyTextField(),
            const SizedBox(height: 10),
            ratingDropdown(),
            const SizedBox(height: 10),
            buttons(context),
          ],
        ),
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          journalEntryValues.title = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a title';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget bodyTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: const InputDecoration(
          labelText: 'Body',
          border: OutlineInputBorder(),
        ),
        onSaved: (value) {
          journalEntryValues.body = value;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a body';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget ratingDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Rating',
          border: OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem<int>(value: 1, child: Text('1')),
          DropdownMenuItem<int>(value: 2, child: Text('2')),
          DropdownMenuItem<int>(value: 3, child: Text('3')),
          DropdownMenuItem<int>(value: 4, child: Text('4')),
        ],
        onChanged: (value) {},
        onSaved: (value) {
          journalEntryValues.rating = value;
        },
        validator: (value) {
          if (value == null) {
            return 'Please choose a rating';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget buttons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cancelButton(context),
        saveButton(context),
      ],
    );
  }

  Widget cancelButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[400]),
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }

  Widget saveButton(context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          addDateToJournalEntryValues();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryValues);
          Navigator.of(context).pop();
        }
      },
      child: const Text('Save Entry'),
    );
  }

  void addDateToJournalEntryValues() {
    journalEntryValues.dateTime = DateTime.now();
  }
}
