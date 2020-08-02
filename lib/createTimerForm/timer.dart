import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    Key key,
    this.title,
    this.fetchValues,
  }) : super(key: key);

  final Function fetchValues;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TimePicker createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  int _hourCounter = 0;
  int _minuteCounter = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Row(children: <Widget>[
      Row(children: <Widget>[
        Column(
          children: <Widget>[
            NumberPicker.integer(
                initialValue: _hourCounter,
                minValue: 00,
                maxValue: 24,
                onChanged: (num newValue) {
                  setState(() => _hourCounter = newValue as int);
                  widget.fetchValues(_hourCounter, _minuteCounter);
                }),
            const Text('HH')
          ],
        ),
        Column(
          children: <Widget>[
            NumberPicker.integer(
                initialValue: _minuteCounter,
                minValue: 00,
                maxValue: 60,
                onChanged: (num newValue) {
                  setState(() => _minuteCounter = newValue as int);
                  widget.fetchValues(_hourCounter, _minuteCounter);
                }),
            const Text('MM')
          ],
        ),
      ]),
    ]);
  }
}
