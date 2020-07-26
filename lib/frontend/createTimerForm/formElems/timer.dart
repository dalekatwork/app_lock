import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerForm extends StatefulWidget {
  const TimerForm({Key key, this.goToNext}) : super(key: key);
  final Function goToNext;

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TimerForm> {
  int _hourValue = 0;
  int _minuteValue = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <NumberPicker>[
              NumberPicker.integer(
                  initialValue: _hourValue,
                  minValue: 0,
                  maxValue: 12,
                  onChanged: (num newValue1) =>
                      setState(() => _hourValue = newValue1 as int)),
              NumberPicker.integer(
                  initialValue: _minuteValue,
                  minValue: 0,
                  maxValue: 60,
                  onChanged: (num newValue2) =>
                      setState(() => _minuteValue = newValue2 as int)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_hourValue > 0 && _minuteValue > 0) {
                  widget.goToNext();
                }
              },
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
