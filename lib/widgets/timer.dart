import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {

  final Function(Duration) onChange;

  TimerWidget({this.onChange});

  @override
  TimerState createState() => TimerState(onChange);
}

class TimerState extends State<TimerWidget> with SingleTickerProviderStateMixin {

  final Function(Duration) onChange;

  final Stopwatch _stopwatch = new Stopwatch();

  TimerState(this.onChange);

  Timer _timer;
  String timeString = '0m 0s';

  format(Duration d) {
    if (d.inHours < 1) {
      return d.toString().split('.').first.replaceFirst('0:', '');
    }
    
    return d.toString().split('.').first.padLeft(8, "0");
  }

  @override
  void initState() {
    super.initState();

    _timer = new Timer.periodic(new Duration(milliseconds: 30), (Timer timer) {
      setState(() {
        onChange(_stopwatch.elapsed);
        timeString = format(_stopwatch.elapsed);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stopwatch.stop();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              Icons.restore
            ),
            onPressed: () {
              _stopwatch.reset();
            },
          ),
          Text(
            timeString,
            style: TextStyle(
              fontFamily: 'TT Norms',
              fontSize: 20
            )
          ),
          IconButton(
            icon: Icon(
              _stopwatch.isRunning == true ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: () {
              setState(() {
                if (_stopwatch.isRunning == true) {
                  _stopwatch.stop();
                }
                else {
                  _stopwatch.start();
                }
              });  
            },
          ),
        ],
      )
    );
  }
}