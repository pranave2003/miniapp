import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:miniapp/components/my_Textfield.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var place = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();
  var confirmpass = TextEditingController();

  Future<dynamic> register() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await FirebaseFirestore.instance
          .collection('userregister')
          .doc(credential.user!.uid)
          .set({
        "Name": name.text,
        "Email": email.text,
        "passsword": password.text,
        "phone": phone.text,
        "path": "1"
      });
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Login();
        },
      ));
      print("Added success");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "The password provided is too weak",
          style: TextStyle(color: Colors.amberAccent),
        )));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "he account already exists for that email.",
          style: TextStyle(color: Colors.red),
        )));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "empty email";
                    }
                    if (!value.contains(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                  controller: email,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.grey[100],
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
              MyTextFields(
                  validation: "Emptypassword",
                  controller: password,
                  hintText: "password",
                  obscureText: true),
              MyTextFields(
                  validation: "Empty Pass",
                  controller: confirmpass,
                  hintText: "Confirm pass",
                  obscureText: true),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (formkey.currentState!.validate()) ;
                        {
                          if (password.text == confirmpass.text) {
                            register();
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "those password are donot match",
                              style: TextStyle(color: Colors.red),
                            )));
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'REGISTER',
                            style: GoogleFonts.lato(
                              textStyle:
                                  TextStyle(letterSpacing: .5, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: Text("Login"))
                ],
              )
            ],
          )),
    );
  }
}
