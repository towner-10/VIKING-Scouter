import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final Function(int) onChange;
  final int startingValue;
  final int minValue;

  Counter({@required this.onChange, this.startingValue = 0, this.minValue});

  @override
  CounterState createState() => CounterState(onChange, startingValue, minValue);
}

class CounterState extends State<Counter> {

  final Function(int) onChange;
  final int minValue;

  int value;

  CounterState(this.onChange, this.value, this.minValue) {
    onChange(value);
  }

  _updateValue(int value) {
    setState(() {
      this.value += value;

      if (minValue != null) {
        if (this.value <= minValue) {
          this.value = minValue;
          onChange(this.value);
          return;
        }
      }

      onChange(this.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Feedback.forTap(context);
            _updateValue(-1);
          },
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0)),
              color: const Color(0xff141333),
            ),
            child: Center(child: Icon(Icons.remove, color: Colors.white)),
          ),
        ),
        Text(
          this.value.toString(),
          style: TextStyle(
            fontFamily: 'TT Norms',
            fontSize: 28,
            color: const Color(0xff000000),
          ),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () {
            Feedback.forTap(context);
            _updateValue(1);
          },
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(20.0, 20.0)),
              color: const Color(0xff141333),
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white)),
          ),
        ),
      ],
    );
  }
}