import 'package:flutter/material.dart';
import 'package:journal_app/db/database_manager.dart';
import 'package:journal_app/db/journal_entry_dto.dart';
import 'package:journal_app/pages/entry_list.dart';
import 'package:journal_app/widgets/journal_scaffold.dart';

// This page displays the form to create a new journal entry

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  static const routeName = 'new';

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
      ),
    );
  }

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
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
    return TextFormField(
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
    );
  }

  Widget ratingDropdown() {
    return DropdownButtonFormField(
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
    );
  }

  Widget buttons(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cancelButton(context),
        const SizedBox(width: 50),
        saveButton(context),
      ],
    );
  }

  Widget cancelButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          backgroundColor: Colors.red[100],
          foregroundColor: Theme.of(context).primaryColor),
      onPressed: () => Navigator.of(context)
          .pushNamedAndRemoveUntil(EntryListScreen.routeName, (route) => false),
      child: const Text('Cancel'),
    );
  }

  Widget saveButton(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        backgroundColor: Colors.green[200],
        foregroundColor: Theme.of(context).primaryColor
      ),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          addDateToJournalEntryValues();
          final databaseManager = DatabaseManager.getInstance();
          databaseManager.saveJournalEntry(dto: journalEntryValues);
          Navigator.of(context).pushNamedAndRemoveUntil(
              EntryListScreen.routeName, (route) => false);
        }
      },
      child: const Text('Save Entry'),
    );
  }

  void addDateToJournalEntryValues() {
    journalEntryValues.dateTime = DateTime.now();
  }
}
