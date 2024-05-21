import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userdetails extends StatefulWidget {
  const Userdetails({super.key, required this.id});
  final id;

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Details")
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          DocumentSnapshot? userdetails = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userdetails!["matter"])],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userdetails["content"])],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userdetails["Time"])],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(userdetails["date"])],
              )
            ],
          );
        },
      ),
    );
  }
}
