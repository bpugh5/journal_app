import 'package:flutter/material.dart';

class JournalAppBar extends StatelessWidget {
  const JournalAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: Center(child: Text(title, style: const TextStyle(color: Colors.black))),
    );
  }
}
