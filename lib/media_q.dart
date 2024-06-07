import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MediaRes extends StatefulWidget {
  const MediaRes({super.key});

  @override
  State<MediaRes> createState() => _MediaResState();
}

class _MediaResState extends State<MediaRes> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenhight = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue,
            height: screenhight * .2,
            width: screenwidth * .25,
          ),
          Container(
            color: Colors.yellow,
            height: screenhight * .2,
            width: screenwidth * .25,
          ),
          Container(
            color: Colors.grey,
            height: screenhight * .2,
            width: screenwidth * .25,
          ),
          Container(
            color: Colors.yellow,
            height: screenhight * .2,
            width: screenwidth * .25,
          ),
        ],
      ),
    );
  }
}
