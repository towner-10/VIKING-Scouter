import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/mainPages/home.dart';
import 'package:viking_scouter/mainPages/onboarding.dart';

Database _db;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _db = Database.getInstance();
  await _db.initializeHive();

  runApp(VIKINGScouter());
}

class VIKINGScouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    if (_db.isFirstLaunch() == true) {
      return MaterialApp(
        title: 'VIKING Scouter',
        home: Onboarding(),
      );
    }
    else {
      return MaterialApp(
        title: 'VIKING Scouter',
        home: Home(),
      );
    }
  }
}
