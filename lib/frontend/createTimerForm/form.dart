import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Center(
          child: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep >= 2) return;
          setState(() {
            _currentStep += 1;
          });
        },
        onStepCancel: () {
          if (_currentStep <= 0) return;
          setState(() {
            _currentStep -= 1;
          });
        },
        steps: const <Step>[
          Step(
            title: Text('Step 1'),
            content: SizedBox(
              width: 100.0,
              height: 100.0,
            ),
          ),
          Step(
            title: Text('Set a daily timer'),
            content: SizedBox(
              width: 100.0,
              height: 100.0,
            ),
          ),
          Step(
            title: Text('Step 3'),
            content: SizedBox(
              width: 100.0,
              height: 100.0,
            ),
          )
        ],
      )),
    );
  }
}
