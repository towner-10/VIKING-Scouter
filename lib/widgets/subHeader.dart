import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {

  final String title;

  SubHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        this.title,
        style: TextStyle(
          fontFamily: 'TT Norms',
          fontSize: 25,
          color: const Color(0xff000000),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}