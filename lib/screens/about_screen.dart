import 'package:flutter/material.dart';
import 'package:text_scroll/text_scroll.dart';

import '../constants/constant_color.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About"),
          backgroundColor: Appcolor.red,
        ),
        body: Text("data"));
  }
}
