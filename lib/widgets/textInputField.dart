import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {

  final String hintText;
  final TextEditingController controller;
  final TextInputType type;

  TextInputField({@required this.hintText, @required this.controller, this.type = TextInputType.text});

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