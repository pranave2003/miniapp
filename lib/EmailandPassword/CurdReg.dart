import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miniapp/EmailandPassword/Crudlogin.dart';

class CrudReg extends StatefulWidget {
  @override
  _CrudRegState createState() => _CrudRegState();
}

class _CrudRegState extends State<CrudReg> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String name = '', email = '', password = '', place = '';

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore
            .collection('CrudUser')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'place': place,
        });

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Crudlogin();
          },
        ));
      } catch (e) {
        print("Registration Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
                validator: (value) => value!.isEmpty ? 'Enter Name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
                validator: (value) => value!.isEmpty ? 'Enter Email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) =>
                    value!.length < 6 ? 'Enter at least 6 characters' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Place'),
                onChanged: (value) => place = value,
                validator: (value) => value!.isEmpty ? 'Enter Place' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: Text("Register"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Crudlogin();
                      },
                    ));
                  },
                  child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
