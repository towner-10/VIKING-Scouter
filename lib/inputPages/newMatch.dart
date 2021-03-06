import 'package:flutter/material.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/input.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class NewMatchPage extends StatelessWidget {

  final TextEditingController _teamNumberController = new TextEditingController();
  final TextEditingController _matchNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 81,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop()),
                    )
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 135)),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Team Number',
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
                                hintText: "Enter team number...",
                                controller: _teamNumberController,
                                type: TextInputType.number,
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Match Number',
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
                                hintText: "Enter match number...",
                                controller: _matchNumberController,
                                type: TextInputType.number,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 150)),
                ],
              )
            )
          )
        )
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Feedback.forTap(context);

          if (_teamNumberController.text.length != 0 || _matchNumberController.text.length != 0) {
            Database.getInstance().initNewMatch(int.parse(_teamNumberController.text), int.parse(_matchNumberController.text));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => InputPage())).then((value) => Navigator.of(context).pop());
          }
          else {
            _teamNumberController.clear();
            _matchNumberController.clear();

            _emptyInput(context);
          }
        },
        child: Container(
          width: MediaQuery. of(context).size.width,
          height: 81.0 + (MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: const Color(0xff141333),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Center(
              child: Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 30,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          )
        ),
      )
    );
  }

  Future<void> _emptyInput(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Empty Input',
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff141333)
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'One of the input fields was empty. Please complete the form before continuing.',
                  style: TextStyle(
                    fontFamily: 'TT Norms',
                    fontSize: 15,
                    color: const Color(0xff141333)
                  ),
                )
              ],
            ),
          ),
          actions: <Widget> [
            FlatButton(
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 15,
                  color: const Color(0xff141333)
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}