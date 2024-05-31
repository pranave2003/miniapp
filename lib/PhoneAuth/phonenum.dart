import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'Otpscreen.dart';

class SignMobile extends StatefulWidget {
  const SignMobile({super.key});

  @override
  State<SignMobile> createState() => _SignMobileState();
}

class _SignMobileState extends State<SignMobile> {
  //

  //
  final TextEditingController phoneController = TextEditingController();

  String formatPhoneNumber(String phoneNumber, String countryCode) {
    String digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return '+$countryCode$digits';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/1111.jpeg"),
                          fit: BoxFit.fill)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter your Mobile Number",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.blue.shade100,
                      letterSpacing: .5,
                      fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "We Will send you a Confirmation Code",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.blue.shade100,
                      letterSpacing: .5,
                      fontSize: 10),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 50, right: 50),
            child: IntlPhoneField(
              style: TextStyle(color: Colors.blue.shade100),
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                if (kDebugMode) {
                  print(phone.completeNumber);
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    String phoneNumber = phoneController.text;
                    String formattedPhoneNumber =
                        formatPhoneNumber(phoneNumber, '91');
                    print("data send$formattedPhoneNumber");
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return OTPpage(phoneNumber: formattedPhoneNumber);
                      },
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5.0,
                              offset: const Offset(0.0, 3.0)),
                        ]),
                    child: Center(
                        child: Text(
                      "Sent code",
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade900),
                    )),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
