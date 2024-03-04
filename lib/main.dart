import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal_app/app.dart';
import 'package:journal_app/db/database_manager.dart';

const SECRET_KEY_PATH = 'assets/schema_1.sql.txt';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  await DatabaseManager.initialize();
  runApp(MyApp(preferences: await SharedPreferences.getInstance()));
}

