import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/widgets/subHeader.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class Settings extends StatefulWidget {

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  final List<String> defaultCompetitions = [
    'Miami Valley Regional',
    'Greater Kansas City Regional'
  ];

  final String defaultSelectedCompetition = 'Miami Valley Regional';

  final TextEditingController _scoutNameController = new TextEditingController();
  final GlobalKey dropdownKey = new GlobalKey();
  final Database _db = Database.getInstance();

  String _selectedCompetition;

  List<DropdownMenuItem> items = new List<DropdownMenuItem>();

  @override
  void initState() { 
    super.initState();
    
    _scoutNameController.text = _db.getPreference('scoutName');

    List<String> competitions = _db.getPreferenceDefault('competitions', defaultCompetitions);

    if (competitions == defaultCompetitions) {
      _db.updatePreference('competitions', competitions);
    }

    _selectedCompetition = _db.getPreferenceDefault('selectedCompetition', 'Miami Valley Regional');

    for(int i = 0; i < competitions.length; i++) {
      items.add(
        new DropdownMenuItem(
          child: Text(competitions[i]),
          value: competitions[i],
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - 81,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: TextStyle(
                          fontFamily: 'TT Norms',
                          fontSize: 30,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    SubHeader('Scout Name'),
                    TextInputField(hintText: 'Enter name...', controller: _scoutNameController),
                    Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                    SubHeader('Competition'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    DropdownButton(
                      key: dropdownKey,
                      items: items + [
                        new DropdownMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text(' Add Competition')
                            ],
                          ), 
                          value: 'add'
                        ),
                        new DropdownMenuItem(
                          child: Row(
                            children: [
                              Icon(Icons.remove),
                              Text(' Remove Competition')
                            ],
                          ), 
                          value: 'remove'
                        )
                      ],
                      value: _selectedCompetition,
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 15,
                        color: Colors.black
                      ),
                      onChanged: (value) {
                        if (value == 'add') {
                          _newCompetition(context);
                          return;
                        }
                        else if (value == 'remove') {
                          _deleteCompetition(context);
                          return;
                        }

                        setState(() {
                          _selectedCompetition = value;
                        });
                      }
                    ),
                  ],
                )
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 30)),
          GestureDetector(
            onTap: () {
              Feedback.forTap(context);

              List<String> competitions = new List<String>();

              for (int i = 0; i < items.length; i++) {
                competitions.add(items[i].value);
              }

              _db.updatePreference('competitions', competitions);
              _db.updatePreference('selectedCompetition', _selectedCompetition);

              if (_scoutNameController.text.length != 0) {
                _db.updatePreference('scoutName', _scoutNameController.text);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 81.0,
              decoration: BoxDecoration(
                color: const Color(0xff141333),
              ),
              child: Center(
                child: Text(
                  'Save',
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
      ),
    );
  }

  Future<void> _newCompetition(BuildContext context) async {
    final TextEditingController newCompetitionController = new TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'New Competition',
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff141333)
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextInputField(hintText: 'Enter competition name...', controller: newCompetitionController)
              ],
            ),
          ),
          actions: <Widget> [
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 15,
                  color: const Color(0xff141333)
                ),
              ),
              onPressed: () {
                newCompetitionController.clear();

                Navigator.of(context).pop();
              },
            ),
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
                if (newCompetitionController.text.length == 0) {
                  return;
                }

                setState(() {
                  items.add(new DropdownMenuItem(child: Text(newCompetitionController.text), value: newCompetitionController.text));
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteCompetition(BuildContext context) async {
    String _deleteCompetitionValue;
    
    final GlobalKey _dropdownKey = new GlobalKey();
    final SnackBar snackBar = SnackBar(content: Text('Not Enough Elements in the Dropdown to delete!'));

    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Competition',
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff141333)
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Pick a competition to delete.',
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                    DropdownButton(
                      key: _dropdownKey,
                      items: items,
                      value: _deleteCompetitionValue,
                      isExpanded: true,
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 15,
                        color: Colors.black
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deleteCompetitionValue = value;
                        });
                      }
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5), 
                      child: Text(
                        'Can\'t delete a competition if there are 2 or less.',
                        style: TextStyle(
                          fontFamily: 'TT Norms',
                          fontSize: 12,
                          color: Colors.black
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          ),
          actions: <Widget> [
            FlatButton(
              child: Text(
                'Cancel',
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
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 15,
                  color: const Color(0xff141333)
                ),
              ),
              onPressed: () {
                if (items.length <= 2) {
                  Scaffold.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                  return;
                }

                setState(() {
                  if (_deleteCompetitionValue == _selectedCompetition) {
                    _selectedCompetition = items.first.value;
                  }

                  items.removeWhere((element) => element.value == _deleteCompetitionValue);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}