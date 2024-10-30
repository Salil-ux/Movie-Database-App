import 'package:flutter/material.dart';

import '../constants/constant_color.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 120.0),
            child: Icon(
              Icons.settings,
              size: 35,
            ),
          )
        ],
        title: const Text('Settings'),
      ),
      body: SizedBox(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("About"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.red,
                        foregroundColor: Appcolor.white),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
