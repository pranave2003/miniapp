import 'package:flutter/material.dart';
import 'package:miniapp/components/CustomButton.dart';

class Buttonsssss extends StatefulWidget {
  const Buttonsssss({super.key});

  @override
  State<Buttonsssss> createState() => _ButtonsssssState();
}

class _ButtonsssssState extends State<Buttonsssss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomButton(
            color: Colors.orange,
            text: "Submit",
            onPressed: () {},
          ),
          CustomButton(
            text: "athul",
            onPressed: () {},
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
