import 'dart:async';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  final updateDuration;

  Clock({this.updateDuration = const Duration(seconds: 1)});

  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hour = appendZeroToDateElement(_dateTime.hour);
    final minute = appendZeroToDateElement(_dateTime.minute);

    final day = appendZeroToDateElement(_dateTime.day);
    final month = appendZeroToDateElement(_dateTime.month);

    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                AndroidIntent intent =
                    AndroidIntent(action: 'android.intent.action.SHOW_ALARMS');
                intent.launch();
              },
              child: Text(
                '$hour:$minute',
                style: TextStyle(fontSize: 50.0),
              ),
            ),
            Text(
              '$day.$month',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ));
  }

  String appendZeroToDateElement(int element) {
    return element < 10 ? '0' + element.toString() : element.toString();
  }
}
