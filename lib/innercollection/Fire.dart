import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firestore extends StatefulWidget {
  const Firestore({super.key});

  @override
  State<Firestore> createState() => _FirestoreState();
}

class _FirestoreState extends State<Firestore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("data").add({"data": 1});
            },
            child: Text("Add data")),
        ElevatedButton(
            onPressed: () {
              // Adding a document to the "data" collection with a known ID
              FirebaseFirestore.instance
                  .collection("data")
                  .doc("knownDocumentId")
                  .set({"data": 1}).then((_) {
                // Adding a subcollection "user" to that document
                FirebaseFirestore.instance
                    .collection("data")
                    .doc("knownDocumentId")
                    .collection("user")
                    .add({"userData": "value"});
              });
            },
            child: Text("Add inner add"))
      ],
    ));
  }
}
