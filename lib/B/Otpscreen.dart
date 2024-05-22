import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'Registerpage.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  var otp = "";
  bool isLoading = false;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenForCode();
    checkConnectivity();
  }

  bool _isConnected = true;

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = (connectivityResult != ConnectivityResult.none);
    });

    if (!_isConnected) {
      showNoInternetNotification();
    }
  }

  void showNoInternetNotification() {
    Fluttertoast.showToast(
      msg: "Please check your internet connection.",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<void> verifyOtp() async {
    try {
      setState(() {
        isLoading = true;
      });

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => phoneRegister(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error during OTP validation: $e");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP. Please try again."),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.blue.shade100,
              ))),
      body: _isConnected
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 250,
                          width: 250,
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
                        "Enter Verification code",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 25),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Pinput(
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      length: 6,
                      onChanged: (value) => otp = value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: isLoading ? null : verifyOtp,
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
                              "verify",
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
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("please Check your internet connection."),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      checkConnectivity();
                    },
                    child: const Text('Check Again'),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void codeUpdated() {
    print('SMS code updated:$code');
    if (code != null && code!.isNotEmpty) {
      setState(() {
        otpController.text = code!;
      });
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
}

@override
void codeUpdated() {
  // TODO: implement codeUpdated
}
