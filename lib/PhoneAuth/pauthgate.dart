import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniapp/PhoneAuth/phonenum.dart';

import 'Phonehome.dart';

class Pauth extends StatefulWidget {
  const Pauth({super.key});

  @override
  State<Pauth> createState() => _PauthState();
}

class _PauthState extends State<Pauth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return const PhoneHome();
            }
            //user is notlogged in
            else {
              return SignMobile();
            }
          }),
    );
  }
}
