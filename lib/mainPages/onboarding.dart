import 'package:flutter/material.dart';
import 'package:viking_scouter/inputPages/newMatch.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141333),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      'Welcome to\nVIKING Scouter',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 40,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      'Track what is important\nto you and your team.',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 20,
                        color: const Color(0xffd9d3d3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: GestureDetector(
                onTap: () {
                  Feedback.forTap(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewMatchPage()));
                },
                child: Container(
                  width: 224.0,
                  height: 74.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: const Color(0xffffffff),
                  ),
                  child: Center(
                    child: Text(
                      'Let\'s Get Started',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 20,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}