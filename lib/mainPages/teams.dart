import 'package:flutter/material.dart';

class Teams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Teams',
                    style: TextStyle(
                      fontFamily: 'TT Norms',
                      fontSize: 30,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  )
                )
              ],
            )
          )
        ],
      ),
    );
  }
}