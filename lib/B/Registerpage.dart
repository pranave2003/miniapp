import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../components/my_Textfield.dart';
import 'Phonehome.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController namename = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController place = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkUserExists();
  }

  Future<void> _checkUserExists() async {
    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        // User is already registered, navigate to HomePage
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PhoneHome(),
        ));
      }
    }
  }

  void _register() async {
    User? user = _auth.currentUser;

    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': namename.text,
        'place': place.text,
        'phone': user.phoneNumber,
        "email": email.text
      });

      _showMessage('Registration successful');
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PhoneHome(),
      ));
    } else {
      _showMessage('User not signed in');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  var circular = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'MD WORLD',
                      style: GoogleFonts.akronim(
                        textStyle: TextStyle(
                            color: Colors.blue.shade100,
                            letterSpacing: .5,
                            fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/1111.jpeg"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: MyTextFields(
                    validation: "Empty Username",
                    controller: namename,
                    hintText: "Name",
                    obscureText: false),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, bottom: 10, top: 10),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "empty email";
                    }
                    // if (!value.contains(
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')) {
                    //   return 'Invalid Email';
                    // }
                    // return null;
                  },
                  controller: email,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue.shade100),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              MyTextFields(
                validation: "empty place",
                controller: place,
                hintText: "place",
                obscureText: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            _register();
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: circular == 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'REGISTER',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          height: 50,
                                          width: 50,
                                          child: Lottie.asset(
                                            "assets/Animation - 1716349219172.json",
                                          )),
                                    ],
                                  )
                                : circular == 2
                                    ? Text(
                                        'REGISTER',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'REGISTER',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue.shade900,
                                            fontWeight: FontWeight.bold),
                                      ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
