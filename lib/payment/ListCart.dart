import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddProduct.dart';
import 'PayScreen.dart';

class ListcartDetails extends StatefulWidget {
  const ListcartDetails({super.key});

  @override
  State<ListcartDetails> createState() => _ListcartDetailsState();
}

class _ListcartDetailsState extends State<ListcartDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.payment),
        title: Text("PAYMENT"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Addproduct();
                  },
                ));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("Payment").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              color: Colors.red,
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
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(Notifi[index]["productname"]),
                            Text(Notifi[index]["Price"])
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UpiPaymentScreen(
                                        price: double.parse(
                                            Notifi[index]["Price"]));
                                  },
                                ));
                              },
                              child: Text(
                                "PAY",
                                style: TextStyle(color: Colors.green),
                              )))
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
