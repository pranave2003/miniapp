import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SegmentedButtonDemo extends StatefulWidget {
  @override
  _SegmentedButtonDemoState createState() => _SegmentedButtonDemoState();
}

class _SegmentedButtonDemoState extends State<SegmentedButtonDemo> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ToggleButtons(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('A'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('B'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('C'),
          ),
        ],
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                isSelected[buttonIndex] = true;
              } else {
                isSelected[buttonIndex] = false;
              }
            }
          });
        },
      ),
    );
  }
}
