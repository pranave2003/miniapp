import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:torch_light/torch_light.dart';

class FlashlightPage extends StatefulWidget {
  @override
  _FlashlightPageState createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  bool isTorchOn = false;

  void _toggleTorch() async {
    try {
      if (isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      print("Could not toggle torch: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            isTorchOn
                ? Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Abed.jpg"),
                            fit: BoxFit.cover)),
                  )
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/bbed.jpg"),
                            fit: BoxFit.cover)),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 600, right: BorderSide.strokeAlignCenter),
              child: Center(
                child: SizedBox(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white),
                    child: Center(
                      child: InkWell(
                        onTap: _toggleTorch,
                        child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: isTorchOn
                                  ? Color.fromRGBO(255, 190, 152, 1)
                                  : Colors
                                      .black, // Corrected the alpha value to 1
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.5), // Shadow color with opacity
                                  spreadRadius: 1, // The spread radius
                                  blurRadius: 10, // The blur radius
                                  offset: Offset(0, 3),
                                  // The shadow offset (horizontal, vertical)
                                ),
                              ],
                            ),
                            child: isTorchOn
                                ? Icon(
                                    Icons.fingerprint,
                                    size: 50,
                                  )
                                : Icon(
                                    Icons.fingerprint,
                                    color: Color.fromRGBO(255, 190, 152, 1),
                                    size: 50,
                                  )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 40, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Color.fromRGBO(
                                  255, 190, 152, 1), // Set the text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Smartphone",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 40, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Colors.grey.shade100, // Set the text color
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Is",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 40, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Color.fromRGBO(
                                  255, 190, 152, 1), // Set the text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "The",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 30, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Color.fromRGBO(
                                  255, 190, 152, 1), // Set the text color
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "new",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            fontSize: 30, // Set the font size
                            fontWeight: FontWeight.bold, // Set the font weight
                            color: Color.fromRGBO(
                                255, 190, 152, 1), // Set the text color
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Flashlight",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 30, // Set the font size
                              fontWeight:
                                  FontWeight.bold, // Set the font weight
                              color: Colors.white, // Set the text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
