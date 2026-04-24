import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/provider/settng-provider/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'Setting',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.orangeAccent),
            ),
            Text(
              's',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.brown),
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        children: [

          // Theme Switch
          Card(
            child: SwitchListTile(
              title: const Text("Switch Mode"),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),

          // About Section
          const Card(
            child: ListTile(
              title: Text('About'),
              subtitle: Text('version 1.0'),
            ),
          ),
        ],
      ),
    );
  }
}