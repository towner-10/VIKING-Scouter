import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/models/templateData.dart';
import 'package:viking_scouter/widgets/bubbleTab.dart';
import 'package:viking_scouter/widgets/counter.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/inputItem.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class TemplateDesigner extends StatefulWidget {

  @override
  TemplateDesignerState createState() => TemplateDesignerState();
}

class TemplateDesignerState extends State<TemplateDesigner> {

  Database _db;

  List<TemplateData> items = new List<TemplateData>();

  @override
  void initState() { 
    super.initState();

    _db = Database.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 15),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ReorderableListView(
              header: Header(_db.getWorkingTemplateDataValue('name')),
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
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    setState(() {
                      items.remove(e);
                    });
                  },
                  child: ListTile(title: Text(e.title), subtitle: Text(type)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItemWindow(context).then((value) => setState(() {})),
        backgroundColor: CustomColors.darkBlue,
        child: Icon(Icons.add),
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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                                size: 50,
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
                                size: 50,
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
                                size: 50,
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
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                                size: 50,
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
                                size: 50,
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
                                size: 50,
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
          ],
        );
      },
    );
  }

  Future<void> _addNewItemTitleWindow(BuildContext context, TemplateDataType type) async {
    TextEditingController _nameController = new TextEditingController();
    TextEditingController _dbController = new TextEditingController();

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
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget> [
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
                    items.add(new TemplateData(title: _nameController.text, dbName: _dbController.text, type: type));
                    Navigator.of(context).pop();
                  });
                }
                else if (_nameController.text.length != 0 && _dbController.text.length == 0) {
                  setState(() {
                    items.add(new TemplateData(title: _nameController.text, type: type));
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
      },
    );
  }
}