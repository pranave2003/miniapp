import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Slider_wid extends StatefulWidget {
  const Slider_wid({super.key});

  @override
  State<Slider_wid> createState() => _Slider_widState();
}

class _Slider_widState extends State<Slider_wid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Slider.adaptive(
              value: 1,
              onChanged: (double newValue) {},
            ),
            SwitchListTile.adaptive(
              value: true,
              title: Text("Switch List Tile"),
              onChanged: (bool newvalue) {},
            ),
            Switch.adaptive(
              value: true,
              onChanged: (bool newValue) {},
            ),
            Icon(Icons.adaptive.share),
            const CircularProgressIndicator.adaptive()
          ],
        ),
      ),
    );
  }
}
