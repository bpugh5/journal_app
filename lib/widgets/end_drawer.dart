import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:journal_app/app.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  bool _light = true;

  @override
  void initState() {
    super.initState();
    initLightMode();
  }

  void initLightMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _light = prefs.getBool('lightMode') ?? true;
    });
  }

  void toggleLight(value) {
    setState(() {
      _light = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyAppState appState = context.findAncestorStateOfType<MyAppState>()!;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppBar().preferredSize.height,
            child: const Column(
              children: [
                Text("Settings", style: TextStyle(fontSize: 20)),
                Spacer(),
                Divider(thickness: 0.25),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Light Mode:"),
              Switch.adaptive(
                value: _light,
                onChanged: (value) {
                  toggleLight(value);
                  appState.toggleLightMode(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
