import 'package:flutter/material.dart';
import 'package:app_lock/frontend/createTimerForm/formElems/label.dart';
import 'package:app_lock/frontend/createTimerForm/formElems/timer.dart';

class CreateTimerForm extends StatefulWidget {
  const CreateTimerForm({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CreateTimerForm createState() => _CreateTimerForm();
}

class _CreateTimerForm extends State {
  int _currentStep = 0;
  static const int _totalSteps = 3;

  void _nextStep() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // Factoring in, start index 0
      if (_currentStep < _totalSteps - 1) {
        _currentStep++;
      }
    });
  }

  void _saveForm() {
    // setState(() {
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    // Factoring in, start index 0

    // TODO: save form entry
    // });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Center(
          child: Stepper(
        controlsBuilder: (BuildContext context,
            {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
          return Row();
        },
        currentStep: _currentStep,
        onStepCancel: () {
          if (_currentStep <= 0) return;
          setState(() {
            _currentStep -= 1;
          });
        },
        steps: <Step>[
          Step(
              title: const Text('Step 1: Set a label'),
              content: LabelAdderForm(goToNext: _nextStep)),
          Step(
              title: const Text('Step 2: Set a time limit '),
              content: TimerForm(goToNext: _nextStep)),
          Step(
            title: const Text('Step 3: Save entry'),
            content: RaisedButton(
              onPressed: _saveForm,
              child: const Text('Submit'),
            ),
          )
        ],
      )),
    );
  }
}
