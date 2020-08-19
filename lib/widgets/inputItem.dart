import 'package:flutter/material.dart';
import 'package:viking_scouter/widgets/subHeader.dart';

class InputItem extends StatelessWidget {
  
  final String title;
  final Widget dataType;

  InputItem({this.title, this.dataType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        SubHeader(title),
        Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Container(
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
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 60.0),
              child: dataType,
            )
          ),
        )
      ],
    );
  }
}