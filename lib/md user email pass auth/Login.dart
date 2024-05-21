import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniapp/md%20user%20email%20pass%20auth/register.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'BNavigationbar.dart';
import 'adddataview.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var id;
  var circular = 0;

  Future<void> login() async {
    try {
      setState(() {
        circular = 1;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      print("done");
      final user = await FirebaseFirestore.instance
          .collection('userregister')
          .where('Email', isEqualTo: email.text)
          .where('passsword', isEqualTo: password.text)
          .get();
      if (user.docs.isNotEmpty) {
        id = user.docs[0].id;

        SharedPreferences data = await SharedPreferences.getInstance();
        data.setString('id', id);
      }

      circular = 2;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Bottomnavi(),
          ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        circular = 2;
      });

      print("error is $e");

      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "The email address is badly formatted",
          style: TextStyle(color: Colors.white),
        )));
        // Handle user not found error
      }
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          " incorrect  username and password ",
          style: TextStyle(color: Colors.red),
        )));
        // Handle user not found error
      } else if (e.code == 'too-many-requests') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "We have blocked all requests from this device due to unusual activity",
          style: TextStyle(color: Colors.white),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MD STORE ',
                    style: GoogleFonts.akronim(
                      textStyle: TextStyle(
                          color: Colors.blue.shade100,
                          letterSpacing: .5,
                          fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images.png"),
                          fit: BoxFit.fill)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty email";
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
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty password";
                  }
                  return null;
                },
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await login();
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
                              ? CircularProgressIndicator()
                              : circular == 2
                                  ? Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          letterSpacing: .5, fontSize: 15),
                                    )
                                  : Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          letterSpacing: .5, fontSize: 15),
                                    )),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.amber.shade50),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  child: Text("Register"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:miniapp/A/register.dart';
// import 'package:miniapp/components/my_Textfield.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'adddataview.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final formkey = GlobalKey<FormState>();
//   var emailctrl = TextEditingController();
//   var passctrl = TextEditingController();
//   var id;
//   Future<dynamic> Login() async {
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailctrl.text, password: passctrl.text);
//
//       final user = await FirebaseFirestore.instance
//           .collection('mechsighn')
//           .where('email', isEqualTo: emailctrl.text)
//           .where('password', isEqualTo: passctrl.text)
//           .get();
//       if (user.docs.isNotEmpty) {
//         id = user.docs[0].id;
//
//         SharedPreferences data = await SharedPreferences.getInstance();
//         data.setString('id', id);
//
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) {
//             return Homescreen();
//           },
//         ));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text(
//           "username and password error",
//           style: TextStyle(color: Colors.red),
//         )));
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
//
// //   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: formkey,
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 100),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'MD STORE ',
//                         style: GoogleFonts.akronim(
//                           textStyle: TextStyle(
//                               color: Colors.blue.shade100,
//                               letterSpacing: .5,
//                               fontSize: 40),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         ' LOGIN',
//                         style: GoogleFonts.aleo(
//                           textStyle: TextStyle(
//                               color: Colors.blue.shade100,
//                               letterSpacing: .5,
//                               fontSize: 30),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     height: 50,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("assets/images.png"),
//                             fit: BoxFit.fill)),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 100),
//                     child: MyTextFields(
//                         controller: emailctrl,
//                         hintText: "Username",
//                         obscureText: false,
//                         validation: "Empty Username"),
//                   ),
//                   MyTextFields(
//                       controller: passctrl,
//                       hintText: "Enter your Password",
//                       obscureText: true,
//                       validation: "Emptyusername"),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 100),
//                     child: Container(
//                       height: 50,
//                       width: 200,
//                       decoration: BoxDecoration(
//                           color: Colors.blue.shade100,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Center(
//                         child: Text(
//                           'LOGIN',
//                           style: GoogleFonts.lato(
//                             textStyle:
//                                 TextStyle(letterSpacing: .5, fontSize: 15),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Create a new account",
//                         style: TextStyle(color: Colors.amber.shade50),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Register(),
//                                 ));
//                           },
//                           child: Text(
//                             "Register",
//                             style: TextStyle(color: Colors.blue.shade100),
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
