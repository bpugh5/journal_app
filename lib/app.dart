import 'package:flutter/material.dart';
import 'package:journal_app/pages/entry_list.dart';
import 'package:journal_app/pages/new_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.preferences});

  final SharedPreferences preferences;

  static final routes = {
    EntryListScreen.routeName: (context) => const EntryListScreen(),
    NewEntryPage.routeName: (context) => const NewEntryPage(),
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
      theme: lightMode ? lightModeTheme() : darkModeTheme(),
      routes: MyApp.routes,
      initialRoute: EntryListScreen.routeName,
    );
  }

  void toggleLightMode(value) {
    setState(() {
      widget.preferences.setBool(LIGHT_MODE_KEY, value);
    });
  }

  ThemeData lightModeTheme() {
    return ThemeData.light().copyWith(
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.lightBlue[200],
      ),
    );
  }

  ThemeData darkModeTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.purple[600],
      ),
    );
  }
}
