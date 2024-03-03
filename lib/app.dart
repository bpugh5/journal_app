import 'package:flutter/material.dart';
import 'package:journal_app/pages/journal_entry_list.dart';
import 'package:journal_app/pages/journal_entry_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.preferences});

  final SharedPreferences preferences;

  static final routes = {
    JournalEntryListScreen.routeName: (context) => const JournalEntryListScreen(),
    JournalEntryFormPage.routeName: (context) => const JournalEntryFormPage(),
  };

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  static const LIGHT_MODE_KEY = 'lightMode';

  bool get lightMode => widget.preferences.getBool(LIGHT_MODE_KEY) ?? true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: lightMode ? ThemeData.light() : ThemeData.dark(),
      routes: MyApp.routes,
      initialRoute: JournalEntryListScreen.routeName,
    );
  }

  void toggleLightMode(value) {
    setState(() {
      widget.preferences.setBool(LIGHT_MODE_KEY, value);
    });
  }
}
