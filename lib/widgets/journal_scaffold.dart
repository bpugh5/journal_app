import 'package:flutter/material.dart';
import 'package:journal_app/pages/new_entry.dart';
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
        centerTitle: true,
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
        title: Text(title),
      ),
      body: child,
      endDrawer: const Drawer(
        child: EndDrawer(),
      ),
      floatingActionButton: fab
          ? FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(NewEntryPage.routeName),
              tooltip: 'Add New Journal Entry',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
