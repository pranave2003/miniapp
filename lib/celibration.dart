import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class CelebrationPage extends StatefulWidget {
  @override
  _CelebrationPageState createState() => _CelebrationPageState();
}

class _CelebrationPageState extends State<CelebrationPage> {
  ConfettiController? _confettiController;
  bool _isScaled = true;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController?.dispose();
    super.dispose();
  }

  void _onButtonPressed() {
    _confettiController?.play(); // Start the confetti animation
    setState(() {
      _isScaled = !_isScaled; // Toggle scale animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celebration Example'),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ConfettiWidget(
            confettiController: _confettiController!,
            blastDirectionality:
                BlastDirectionality.explosive, // Shoot in all directions
            shouldLoop: false, // Stop after the duration ends
            colors: [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.orange,
              Colors.purple,
              Colors.amberAccent,
              Colors.indigoAccent
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                  scale: _isScaled ? .5 : 5.0,
                  duration: const Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap: _onButtonPressed,
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/md.jpg"),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 50),
            
            ],
          ),
        ],
      ),
    );
  }
}
