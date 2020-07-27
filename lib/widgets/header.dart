import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final String title;

  Header(this.title);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        this.title,
        style: TextStyle(
          fontFamily: 'TT Norms',
          fontSize: 30,
          color: const Color(0xff000000),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}