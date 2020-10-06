import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/models/templateData.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class TemplateDesigner extends StatefulWidget {

  @override
  TemplateDesignerState createState() => TemplateDesignerState();
}

class TemplateDesignerState extends State<TemplateDesigner> {

  Database _db;

  List<TemplateData> items = new List<TemplateData>();

  List<SpeedDialChild> childButtons = List<SpeedDialChild>();

  @override
  void initState() { 
    super.initState();

    _db = Database.getInstance();

    childButtons.add(SpeedDialChild(
      child: Icon(Icons.add_circle),
      backgroundColor: CustomColors.darkBlue,
      label: 'Default Items',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => _addDefaultItemWindow(context).then((value) => setState(() {}))
    ));

    childButtons.add(SpeedDialChild(
      child: Icon(Icons.add_circle_outline),
      backgroundColor: CustomColors.darkBlue,
      label: 'Custom Item',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () => _addNewItemWindow(context).then((value) => setState(() {}))
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ReorderableListView(
              header: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop()),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Header(_db.getWorkingTemplateDataValue('name')),
                  )
                ],
              ),
              children: items.map((e) {
                String type;

                switch(e.type) {
                  case TemplateDataType.BubbleTab:
                    type = "True/False";
                    break;
                  case TemplateDataType.Counter:
                    type = "Counter";
                    break;
                  case TemplateDataType.Header:
                    type = "Header";
                    break;
                  case TemplateDataType.NumberInput:
                    type = "Number Input";
                    break;
                  case TemplateDataType.TextInput:
                    type = "Text Input";
                    break;
                  case TemplateDataType.Timer:
                    type = "Timer";
                    break;
                }

                return Dismissible(
                  key: ValueKey(e),
                  background: Container(
                    color: Colors.red,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    )
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      items.remove(e);
                    });
                  },
                  child: ListTile(
                    title: Text(
                      e.title,
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                      ),
                    ), 
                    subtitle: Text(
                      type,
                      style: TextStyle(
                        fontFamily: 'TT Norms',
                      ),
                    ), 
                    trailing: Icon(Icons.menu)
                  ),
                );
              }).toList().cast<Widget>(),
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }

                  items.insert(newIndex, items.removeAt(oldIndex));
                });
              }
            ),
          )
        ),
      ),
      /*floatingActionButton: UnicornDialer(
        parentButtonBackground: CustomColors.darkBlue,
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons,
      ),*/
      floatingActionButton: SpeedDial(
        shape: CircleBorder(),
        curve: Curves.easeIn,
        children: childButtons,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        elevation: 10.0,
        backgroundColor: CustomColors.darkBlue,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _db.newTemplate(new Template(
            name: _db.getWorkingTemplateDataValue('name'),
            data: items
          ));
          
          Navigator.of(context).pop();
        },
        child: Container(
          width: MediaQuery. of(context).size.width,
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
    );
  }

  Future<void> _addNewItemWindow(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add New Item',
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff141333)
            ),
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 8,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.BubbleTab);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_box,
                          size: 40,
                        ),
                        Text(
                          "True/False",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.Counter);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: 40,
                        ),
                        Text(
                          "Counter",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.TextInput);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.short_text,
                          size: 40,
                        ),
                        Text(
                          "Text Input",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.NumberInput);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.score,
                          size: 40,
                        ),
                        Text(
                          "Number Input",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.Timer);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 40,
                        ),
                        Text(
                          "Timer",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _addNewItemTitleWindow(context, TemplateDataType.Header);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.view_headline,
                          size: 40,
                        ),
                        Text(
                          "Header",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
            ],
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
          ],
        );
      },
    );
  }

  Future<void> _addDefaultItemWindow(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Default Item',
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff141333)
            ),
          ),
          content: Wrap(
            spacing: 5,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    items.add(new TemplateData(title: "Alliance Score", dbName: "score", type: TemplateDataType.NumberInput));
                    Navigator.of(context).pop();
                  });
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.flag,
                          size: 40,
                        ),
                        Text(
                          "Alliance Score",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    items.add(new TemplateData(title: "Match Notes", type: TemplateDataType.Header));
                    items.add(new TemplateData(title: "Match Notes Input", dbName: "matchNotes", type: TemplateDataType.TextInput));
                    Navigator.of(context).pop();
                  });
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.speaker_notes,
                          size: 40,
                        ),
                        Text(
                          "Match Notes",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    items.add(new TemplateData(title: "Ranking Points", dbName: "rp", type: TemplateDataType.Counter));
                    Navigator.of(context).pop();
                  });
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Icon(
                          Icons.short_text,
                          size: 40,
                        ),
                        Text(
                          "Ranking Points",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: Colors.black
                          ),
                        )
                      ]
                    )
                  )
                ),
              ),
            ],
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
          ],
        );
      },
    );
  }

  Future<void> _addNewItemTitleWindow(BuildContext context, TemplateDataType type) async {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _dbController = new TextEditingController();

    bool displayBool = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                'Add New Item',
                style: TextStyle(
                  fontFamily: 'TT Norms',
                  fontSize: 25,
                  color: const Color(0xff141333)
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Switch(
                          activeColor: CustomColors.darkBlue,
                          value: displayBool, 
                          onChanged: (value) {
                            setState(() {
                              displayBool = value;
                            });
                          }
                        ),
                        Text(
                          "Show on Match Data Card",
                          style: TextStyle(
                            fontFamily: 'TT Norms',
                            fontSize: 15,
                            color: CustomColors.grey
                          ),
                        )
                      ],
                    ),
                    TextInputField(hintText: "Enter name..", controller: _nameController),
                    TextInputField(hintText: "Enter database name...", controller: _dbController),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Database name can be empty if type is a header",
                        style: TextStyle(
                          fontFamily: 'TT Norms',
                          fontSize: 15,
                          color: CustomColors.grey
                        ),
                      ),
                    )
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
                    if (_nameController.text.length != 0 && _dbController.text.length != 0) {
                      setState(() {
                        items.add(new TemplateData(title: _nameController.text, display: displayBool, dbName: _dbController.text, type: type));
                        Navigator.of(context).pop();
                      });
                    }
                    else if (_nameController.text.length != 0 && _dbController.text.length == 0) {
                      setState(() {
                        items.add(new TemplateData(title: _nameController.text, display: displayBool, type: type));
                        Navigator.of(context).pop();
                      });
                    } 
                    else {
                      return;
                    }
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }
}