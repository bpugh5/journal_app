import 'package:flutter/material.dart';
import 'package:journal_app/pages/journal_entry_form.dart';
import 'package:journal_app/widgets/end_drawer.dart';

class JournalScaffold extends StatelessWidget {
  const JournalScaffold(
      {super.key, required this.child, required this.title, required this.fab});
  final Widget child;
  final String title;
  final bool fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(title)),
      ),
      body: child,
      endDrawer: Drawer(
        child: EndDrawer(),
      ),
      floatingActionButton: fab
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(JournalEntryFormPage.routeName),
              tooltip: 'Add New Journal Entry',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
