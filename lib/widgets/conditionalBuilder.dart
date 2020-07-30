import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {

  final Widget builder;
  final bool condition;

  ConditionalBuilder({this.builder, this.condition});

  @override
  Widget build(BuildContext context) {
    if (condition == true) {
      return builder;
    }

    return Container();
  }
}