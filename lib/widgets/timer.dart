import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {

  final Function(List<int>) onChange;

  TimerWidget({this.onChange});

  @override
  TimerState createState() => TimerState(onChange);
}

class TimerState extends State<TimerWidget> with SingleTickerProviderStateMixin {

  final Function(List<int>) onChange;

  final Stopwatch _stopwatch = new Stopwatch();

  TimerState(this.onChange);

  Timer _timer;
  String timeString = '0:00';

  List<int> times = new List<int>();
  int currentIndex = 0;

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
        if (currentIndex >= times.length) {
          times.insert(currentIndex, _stopwatch.elapsed.inMilliseconds);
        }

        times[currentIndex] = _stopwatch.elapsed.inMilliseconds;

        timeString = format(_stopwatch.elapsed);

        onChange(times);
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
    List<Widget> timesWidgets = times.length >= 1 ? times.map((e) {
      return Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              times.indexOf(e).toString() + ': ',
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 14
              ),
              textAlign: TextAlign.right,
            ),
            Text(
              format(Duration(milliseconds: e)).toString(),
              style: TextStyle(
                fontFamily: 'TT Norms',
                fontSize: 14
              )
            ),
          ],
        )
      );  
    }).toList() : [];

    if (timesWidgets.length != 0) {
      timesWidgets.remove(timesWidgets.last);
    }

    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
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
              IconButton(
                icon: Icon(
                  Icons.save
                ),
                onPressed: () {
                  setState(() {
                    currentIndex++;
                    _stopwatch.reset();
                  });
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
          ),
          Column(
            children: timesWidgets
          )
        ], 
      )
    );
  }
}