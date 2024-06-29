import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StepperWork extends StatefulWidget {
  const StepperWork({super.key});

  @override
  State<StepperWork> createState() => _StepperWorkState();
}

class _StepperWorkState extends State<StepperWork> {
  int Currentstep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stepper(
        steps: const [
          Step(title: Text("data"), content: Text("Information 1")),
          Step(title: Text("data"), content: Text("Information 1")),
          Step(title: Text("data"), content: Text("Information 1")),
        ],
        onStepTapped: (int newIndex) {
          setState(() {
            Currentstep = newIndex;
          });
        },
        currentStep: Currentstep,
        onStepContinue: () {
          if (Currentstep != 2) {
            setState(() {
              Currentstep += 1;
            });
          }
        },
        onStepCancel: () {
          if (Currentstep != 0) {
            setState(() {
              Currentstep -= 1;
            });
          }
        },
      ),
    ));
  }
}
