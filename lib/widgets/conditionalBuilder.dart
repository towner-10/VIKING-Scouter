import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {

  final Widget builder;
  final bool condition;

  ConditionalBuilder({this.builder, this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? builder : Container();
  }
}

class ConditionalBuilderMultiple extends StatelessWidget {

  final Widget trueBuilder;
  final Widget falseBuilder;

  final bool condition;

  ConditionalBuilderMultiple({this.trueBuilder, this.falseBuilder, this.condition});

  @override
  Widget build(BuildContext context) {
    return condition ? trueBuilder : falseBuilder;
  }
}