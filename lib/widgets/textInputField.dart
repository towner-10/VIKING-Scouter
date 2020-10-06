import 'package:flutter/material.dart';
import 'package:viking_scouter/customColors.dart';
import 'package:viking_scouter/database.dart';

class TextInputField extends StatelessWidget {

  final String hintText;
  final TextInputType type;

  TextEditingController controller;

  TextInputField({@required this.hintText, this.type = TextInputType.text, this.controller, String dbName}) {
    if (controller == null) {
      controller = new TextEditingController();

      controller.addListener(() {
        if (type == TextInputType.number) {
          Database.getInstance().updateWorkingMatchDataValue(dbName, int.tryParse(controller.text));
        }
        else {
          Database.getInstance().updateWorkingMatchDataValue(dbName, controller.text);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 20,
        right: 18,
        bottom: 20
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'TT Norms',
          fontSize: 15,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        keyboardType: type,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black
            )
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.grey
            )
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'TT Norms',
            fontSize: 15,
            color: const Color(0xffd9d3d3),
          ),
        ),
      ),
    );
  }
}