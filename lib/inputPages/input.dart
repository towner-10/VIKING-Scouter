import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/widgets/bubbleTab.dart';
import 'package:viking_scouter/widgets/counter.dart';
import 'package:viking_scouter/widgets/inputItem.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class InputPage extends StatelessWidget {

  _printBool(bool i) => print(i);
  _printNumber(int i) => print(i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: 20
              ),
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
                  InputItem(
                    title: 'Crossed Auto Line',
                    dataType: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: BubbleTab(onChange: _printBool),
                    ),
                  ),
                  InputItem(
                    title: "High Goal - Inner", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  InputItem(
                    title: "High Goal - Outer", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  InputItem(
                    title: "Low Goal", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 40
                    )
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tele-op',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 30,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InputItem(
                    title: "High Goal - Inner", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  InputItem(
                    title: "High Goal - Outer", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  InputItem(
                    title: "Low Goal", 
                    dataType: Counter(onChange: _printNumber, minValue: 0)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 40
                    )
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Endgame',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 30,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InputItem(
                    title: 'Climb',
                    dataType: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: BubbleTab(onChange: _printBool),
                    ),
                  ),
                  InputItem(
                    title: 'Balanced',
                    dataType: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: BubbleTab(onChange: _printBool),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 40
                    )
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Match Notes',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 30,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextInputField(
                    hintText: "Enter match notes...", 
                    controller: new TextEditingController()
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 40
                    )
                  ), 
                ]
              ),
            ),
            GestureDetector(
              onTap: () {
                Feedback.forTap(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage()));
              },
              child: Container(
                width: MediaQuery. of(context).size.width,
                height: 81.0,
                decoration: BoxDecoration(
                  color: const Color(0xff141333),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontFamily: 'TT Norms',
                      fontSize: 30,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}