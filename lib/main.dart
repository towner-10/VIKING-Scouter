import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viking_scouter/mainPages/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'VIKING Scouter',
      home: Onboarding(),
    );
  }
}
