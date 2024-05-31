import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniapp/md%20user%20email%20pass%20auth/Home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/CustomButton.dart';

class Vieew extends StatefulWidget {
  const Vieew({super.key});

  @override
  State<Vieew> createState() => _VieewState();
}

class _VieewState extends State<Vieew> {
  void makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("data")
            .doc("knownDocumentId")
            .collection("user")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          final Notifi = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: Notifi.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.blue.shade100,
                child: Column(
                  children: [
                    Text(Notifi[index]["userData"]),
                    Text("dataas"),
                    CustomButton(
                      color: Colors.white,
                      text: "send",
                      onPressed: () {
                        makePhoneCall(Notifi[index]["userData"]);
                      },
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
