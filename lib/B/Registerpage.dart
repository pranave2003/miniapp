import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:miniapp/components/my_Textfield.dart';

import 'Phonehome.dart';

class phoneRegister extends StatefulWidget {
  const phoneRegister({super.key});

  @override
  State<phoneRegister> createState() => _phoneRegisterState();
}

class _phoneRegisterState extends State<phoneRegister> {
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var place = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var confirmpass = TextEditingController();
  var circular = 0;

  reg() async {
    circular = 1;
    print("Done");
    await FirebaseFirestore.instance.collection("phoneauthregister").add({
      "Name": name.text,
      "Email": email.text,
      "phone": phone.text,
      "path": "1"
    });
    circular = 2;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PhoneHome();
      },
    ));
  }
  // Future<dynamic> register() async {
  //   print("aaaaaa");
  //   setState(() {
  //     circular = 1;
  //   });
  //   try {
  //     final credential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email.text,
  //       password: password.text,
  //     );
  //
  //     await FirebaseFirestore.instance
  //         .collection('phoneauthregister')
  //         .doc(credential.user!.uid)
  //         .set({
  //       "Name": name.text,
  //       "Email": email.text,
  //       "phone": phone.text,
  //       "path": "1"
  //     });
  //     circular = 2;
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) {
  //         return PhoneHome();
  //       },
  //     ));
  //     print("Added success");
  //   } on FirebaseAuthException catch (e) {
  //     circular = 2;
  //     if (e.code == 'weak-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text(
  //         "The password provided is too weak",
  //         style: TextStyle(color: Colors.amberAccent),
  //       )));
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text(
  //         "he account already exists for that email.",
  //         style: TextStyle(color: Colors.red),
  //       )));
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
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
                    controller: name,
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
                validation: "empty phonenumber",
                controller: phone,
                hintText: "Phone",
                obscureText: false,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            reg();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.amber.shade50),
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => Login(),
                        //     ));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.blue.shade50),
                      ))
                ],
              )
            ],
          )),
    );
  }
}
