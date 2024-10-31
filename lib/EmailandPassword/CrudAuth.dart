import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniapp/EmailandPassword/CrudHome.dart';
import 'package:miniapp/EmailandPassword/Crudlogin.dart';

class Crudauth extends StatefulWidget {
  const Crudauth({super.key});

  @override
  State<Crudauth> createState() => _CrudauthState();
}

class _CrudauthState extends State<Crudauth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //user is logged in
            if (snapshot.hasData) {
              return CrudHome();
            }
            //user is notlogged in
            else {
              return Crudlogin();
            }
          }),
    );
  }
}
