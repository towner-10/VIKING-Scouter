import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/inputPages/newTemplate.dart';
import 'package:viking_scouter/widgets/subHeader.dart';
import 'package:viking_scouter/widgets/textInputField.dart';
import 'package:viking_scouter/models/templateData.dart';

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
  final Database _db = Database.getInstance();

  final GlobalKey competitionDropdownKey = new GlobalKey();
  final GlobalKey templateDropdownKey = new GlobalKey();

  String _selectedCompetition;
  String _selectedTemplate;

  List<String> competitions = new List<String>();
  List<Template> templates = new List<Template>();

  @override
  void initState() { 
    super.initState();
    
    _scoutNameController.text = _db.getPreference('scoutName');

    _scoutNameController.addListener(() {
      _db.updatePreference('scoutName', _scoutNameController.text);
    });

    if (competitions == defaultCompetitions) {
      _db.updatePreference('competitions', competitions);
    }

    competitions = _db.getPreferenceDefault('competitions', defaultCompetitions);
    templates = _db.getTemplates();

    _selectedCompetition = _db.getPreferenceDefault('selectedCompetition', 'Miami Valley Regional');
    _selectedTemplate = _db.getPreferenceDefault('selectedTemplate', defaultTemplate.name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
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
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 18),
                  child: DropdownButton(
                    key: competitionDropdownKey,
                    isExpanded: true,
                    underline: Container(
                      color: CustomColors.grey,
                      height: 1.0
                    ),
                    items: buildCompetitionsMenuItems(false),
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

                      _db.updatePreference('selectedCompetition', _selectedCompetition);
                    }
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                SubHeader('Template'),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 18),
                  child: DropdownButton(
                    key: templateDropdownKey,
                    isExpanded: true,
                    underline: Container(
                      color: CustomColors.grey,
                      height: 1.0
                    ),
                    items: buildTemplatesMenuItems(false),
                    value: _selectedTemplate,
                    style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 15,
                        color: Colors.black
                    ),
                    onChanged: (value) {
                      if (value == 'add') {
                        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => NewTemplatePage())).then((value) => setState(() {
                          templates = _db.getTemplates();
                        }));
                        return;
                      }
                      else if (value == 'remove') {
                        _deleteTemplate(context);
                        return;
                      }

                      setState(() {
                        _selectedTemplate = value;
                      });

                      _db.updatePreference('selectedTemplate', _selectedTemplate);
                    }
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> buildCompetitionsMenuItems(bool popup) {
    List<DropdownMenuItem> items = new List<DropdownMenuItem>();

    for (int i = 0; i < competitions.length; i++) {
      items.add(new DropdownMenuItem(
        child: Text(competitions[i]),
        value: competitions[i],
      ));
    }

    if (popup == false) {
      items.add(new DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.add),
            Text(' Add Competition')
          ],
        ),
        value: 'add'
      ));
      items.add(new DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.remove),
            Text(' Remove Competition')
          ],
        ),
        value: 'remove'
      ));
    }

    return items;
  }

  List<DropdownMenuItem> buildTemplatesMenuItems(bool popup) {
    List<DropdownMenuItem> items = new List<DropdownMenuItem>();

    for (int i = 0; i < templates.length; i++) {
      items.add(new DropdownMenuItem(
        child: Text(templates[i].name),
        value: templates[i].name,
      ));
    }

    if (popup == false) {
      items.add(new DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.add),
            Text(' Add Template')
          ],
        ),
        value: 'add'
      ));
      items.add(new DropdownMenuItem(
        child: Row(
          children: [
            Icon(Icons.remove),
            Text(' Remove Template')
          ],
        ),
        value: 'remove'
      ));
    }
    
    return items;
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
                  competitions.add(newCompetitionController.text);
                });

                _db.updatePreference('competitions', competitions);

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
                      items: buildCompetitionsMenuItems(true),
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
                if (competitions.length <= 2) {
                  Navigator.of(context).pop();
                  return;
                }

                for (int i = 0; i < competitions.length; i++) {
                  if (competitions[i] == _deleteCompetitionValue) {
                    _db.removeCompetition(i);
                  }
                }

                setState(() {
                  competitions = _db.getPreferenceDefault('competitions', defaultCompetitions);

                  if (_deleteCompetitionValue == _selectedCompetition) {
                    _selectedCompetition = competitions.first;
                  }
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteTemplate(BuildContext context) async {
    String _deleteTemplateValue;
    
    final GlobalKey _dropdownKey = new GlobalKey();

    return await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Template',
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
                      items: buildTemplatesMenuItems(true),
                      value: _deleteTemplateValue,
                      isExpanded: true,
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                        fontSize: 15,
                        color: Colors.black
                      ),
                      onChanged: (value) {
                        setState(() {
                          _deleteTemplateValue = value;
                        });
                      }
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5), 
                      child: Text(
                        'Can\'t delete a template if there are 2 or less.',
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
                if (_deleteTemplateValue == defaultTemplate.name) {
                  Navigator.of(context).pop();
                  return;
                }

                if (templates.length <= 2) {
                  Navigator.of(context).pop();
                  return;
                }

                for (int i = 0; i < templates.length; i++) {
                  if (templates[i].name == _deleteTemplateValue) {
                    _db.removeTemplate(i);
                  }
                }

                setState(() {
                  templates = _db.getTemplates();

                  if (_deleteTemplateValue == _selectedTemplate) {
                    _selectedTemplate = templates.first.name;
                  }
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