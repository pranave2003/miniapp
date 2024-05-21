import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final bool obscureText;
  final String validation;
  const MyTextFields(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 50, right: 50),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return validation;
          }
        },
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.grey[100],
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
