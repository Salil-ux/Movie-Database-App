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
    // const TextScroll(
    //   'Aloha ',
    //   mode: TextScrollMode.bouncing,
    //   velocity: Velocity(pixelsPerSecond: Offset(150, 0)),
    //   delayBefore: Duration(milliseconds: 500),
    //   numberOfReps: 5,
    //   pauseBetween: Duration(milliseconds: 50),
    //   style: TextStyle(color: Colors.green),
    //   textAlign: TextAlign.right,
    //   selectable: true,
    // ));
  }
}
