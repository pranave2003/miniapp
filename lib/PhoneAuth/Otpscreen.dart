import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Phonehome.dart';
import 'Registerpage.dart';

class OTPpage extends StatefulWidget {
  final String phoneNumber;

  OTPpage({required this.phoneNumber});

  @override
  _OTPpageState createState() => _OTPpageState();
}

class _OTPpageState extends State<OTPpage> with CodeAutoFill {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;
  bool _codeSent = false;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
    listenForCode();
  }

  @override
  void codeUpdated() {
    setState(() {
      _codeController.text = code!;
    });
    if (code != null) {
      _signInWithPhoneNumber();
    }
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        _navigateBasedOnUserStatus();
      },
      verificationFailed: (FirebaseAuthException e) {
        _showMessage('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _codeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void _signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _codeController.text,
      );
      await _auth.signInWithCredential(credential);
      _navigateBasedOnUserStatus();
    } catch (e) {
      _showMessage('Failed to sign in: ${e.toString()}');
    }
  }

  void _navigateBasedOnUserStatus() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        // User is already registered, navigate to HomePage
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PhoneHome(),
        ));
      } else {
        // New user, navigate to RegistrationPage
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        ));
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
        body: SingleChildScrollView(
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
                        textStyle: TextStyle(
                            color: Colors.blue.shade100,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Pinput(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  length: 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _signInWithPhoneNumber();
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
        ));
  }
}
