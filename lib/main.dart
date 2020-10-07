import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
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
    return MaterialApp(
      title: 'VIKING Scouter',
      home: _db.isFirstLaunch() ? Onboarding() : Home(),
      theme: ThemeData(
        primaryColor: CustomColors.darkBlue
      ),
    );
  }
}
