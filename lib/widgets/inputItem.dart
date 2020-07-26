import 'package:flutter/material.dart';

class InputItem extends StatelessWidget {
  
  final String title;
  final Widget dataType;

  InputItem({this.title, this.dataType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 25,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 60.0,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: const Color(0xfff8f8f8),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: dataType,
        ),
      ],
    );
  }
}