import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetWhere extends StatefulWidget {
  const GetWhere({Key? key}) : super(key: key);

  @override
  _GetWhereState createState() => _GetWhereState();
}

class _GetWhereState extends State<GetWhere> {
  late Stream<QuerySnapshot> userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = FirebaseFirestore.instance
        .collection('userregister')
        .where('Email', isEqualTo: 'pranav2003a10@gmail.com')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GET'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No data found.'),
              );
            }
            // Data is ready
            var userData = snapshot.data!.docs;
            // Accessing the first document in the list
            var document = userData.first;
            // Accessing the 'Name' field from the document
            var name = document['Name'];
            var pass = document["passsword"];
            // Displaying the name
            return Center(
              child: Column(
                children: [Text('Name: $name'), Text("pass:$pass")],
              ),
            );
          }
        },
      ),
    );
  }
}
