import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final double padding;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color,
    this.borderRadius = 8.0,
    this.padding = 16.0,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Center(
              child: Text(
            text,
          )),
        ),
      ),
    );
  }
}
