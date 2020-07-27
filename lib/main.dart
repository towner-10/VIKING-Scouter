import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/mainPages/home.dart';
import 'package:viking_scouter/mainPages/onboarding.dart';

void main() async {
  runApp(VIKINGScouter());
}

class VIKINGScouter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    Database _db = Database.getInstance();

    return FutureBuilder(
      future: _db.initializeHive(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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

        return MaterialApp(
          title: 'Loading...',
          home: Container()
        );
      },
    );
  }
}
