import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viking_scouter/database.dart';
import 'package:viking_scouter/models/templateData.dart';
import 'package:viking_scouter/widgets/bubbleTab.dart';
import 'package:viking_scouter/widgets/counter.dart';
import 'package:viking_scouter/widgets/header.dart';
import 'package:viking_scouter/widgets/inputItem.dart';
import 'package:viking_scouter/widgets/textInputField.dart';

class InputPage extends StatelessWidget {

  Database _db;

  Template _template;
  List<Widget> widgets = new List<Widget>();

  InputPage() {
    _db = Database.getInstance();

    List<Template> templates = _db.getTemplates();
    String _selectedTemplate = _db.getPreferenceDefault('selectedTemplate', defaultTemplate.name);

    for (int i = 0; i < templates.length; i++) {
      if (templates[i].name == _selectedTemplate) {
        _template = templates[i];
      }
    }

    if (_template != null) {
      for (int i = 0; i < _template.data.length; i++) {
        switch (_template.data[i].type) {
          case TemplateDataType.BubbleTab:
            widgets.add(InputItem(
              title: _template.data[i].title,
              dataType: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: BubbleTab(onChange: (value) => _db.updateWorkingMatchDataValue(_template.data[i].dbName, value)),
              ),
            ));
            break;
          case TemplateDataType.Counter:
            widgets.add(InputItem(
              title: _template.data[i].title,
              dataType: Counter(onChange: (value) => _db.updateWorkingMatchDataValue(_template.data[i].dbName, value), minValue: 0)
            ));
            break;
          case TemplateDataType.Header:
            if (i == 0) {
              widgets.add(Header(_template.data[i].title));
            } else {
              widgets.add(
                Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 40
                    )
                  ),
                  Header(_template.data[i].title),
                ])
              );
            }
            break;
          case TemplateDataType.NumberInput:
            widgets.add(InputItem(
              title: _template.data[i].title,
              dataType: TextInputField(
                hintText: "Enter number...", 
                dbName: _template.data[i].dbName,
                type: TextInputType.number,
              ),
            ));
            break;
          case TemplateDataType.TextInput:
            widgets.add(TextInputField(
              hintText: "Enter text...", 
              dbName: _template.data[i].dbName
            ));
            break;
          case TemplateDataType.Timer:
            widgets.add(
              Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40
                  )
                ),
                Header(_template.data[i].title),
              ])
            );
            break;
        }
      }

      widgets.add(Padding(
        padding: EdgeInsets.symmetric(
          vertical: 40
        )
      ));
    }
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
                  children: widgets
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Feedback.forTap(context);
                _db.newMatchData(_db.getWorkingMatchDataValues());
                Navigator.of(context).pop();
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