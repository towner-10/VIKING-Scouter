import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/widgets/bubbleTab.dart';
import 'package:viking_scouter/widgets/counter.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/inputItem.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class InputPage extends StatelessWidget {

  TextEditingController _matchNotes;
  Database _db;

  InputPage() {
    _matchNotes = new TextEditingController();
    _matchNotes.addListener(() {
      _db.updateWorkingMatchDataValue('matchNotes', _matchNotes.text);
    });

    _db = Database.getInstance();

    _db.updateWorkingMatchDataValue('matchNotes', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 20
                ),
                child: Column(
                  children: [
                    Header('Autonomous'),
                    InputItem(
                      title: 'Crossed Auto Line',
                      dataType: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: BubbleTab(onChange: (value) => _db.updateWorkingMatchDataValue('crossedAutoLine', value)),
                      ),
                    ),
                    InputItem(
                      title: "High Goal - Inner", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('autoHighGoalInner', value), minValue: 0)
                    ),
                    InputItem(
                      title: "High Goal - Outer", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('autoHighGoalOuter', value), minValue: 0)
                    ),
                    InputItem(
                      title: "Low Goal", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('autoLowGoal', value), minValue: 0)
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40
                      )
                    ),
                    Header('Tele-op'),
                    InputItem(
                      title: "High Goal - Inner", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('highGoalInner', value), minValue: 0)
                    ),
                    InputItem(
                      title: "High Goal - Outer", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('highGoalOuter', value), minValue: 0)
                    ),
                    InputItem(
                      title: "Low Goal", 
                      dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue('lowGoal', value), minValue: 0)
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40
                      )
                    ),
                    Header('Endgame'),
                    InputItem(
                      title: 'Climb',
                      dataType: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: BubbleTab(onChange: (value) => _db.updateWorkingMatchDataValue('climb', value)),
                      ),
                    ),
                    InputItem(
                      title: 'Balanced',
                      dataType: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: BubbleTab(onChange: (value) => _db.updateWorkingMatchDataValue('balanced', value)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40
                      )
                    ),
                    Header('Match Notes'),
                    TextInputField(
                      hintText: "Enter match notes...", 
                      controller: _matchNotes
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 40
                      )
                    ),
                  ]
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Feedback.forTap(context);
                _db.newMatchData(_db.getValues());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
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