import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputPage extends StatelessWidget {
  
  InputPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Autonomous',
                  style: TextStyle(
                    fontFamily: 'TT Norms',
                    fontSize: 30,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Crossed Auto Line',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 25,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    width: 246.0,
                    height: 54.0,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xfff8f8f8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 88.0,
                          height: 28.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11.0),
                            color: const Color(0xff141333),
                          ),
                          child: Center(
                            child: Text(
                              'True',
                              style: TextStyle(
                                fontFamily: 'TT Norms',
                                fontSize: 16,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            ), 
                          ),
                        ),
                        Text(
                          'False',
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'High Goal - Inner',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 25,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Container(
                    width: 246.0,
                    height: 54.0,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: const Color(0xfff8f8f8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: <Widget>[
                            Transform.translate(
                              offset: Offset(89.0, 226.0),
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.elliptical(18.0, 18.0)),
                                  color: const Color(0xff141333),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(100.5, 244.33),
                              child: Icon(
                                Icons.remove
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'False',
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ]
          ),
        )
      ),
    );
  }
}