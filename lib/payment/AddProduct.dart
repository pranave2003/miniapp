import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ListCart.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  final formkey = GlobalKey<FormState>();
  var name = TextEditingController();
  var price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty name";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Product name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Empty price";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Product price"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    FirebaseFirestore.instance
                        .collection("Payment")
                        .add({"productname": name.text, "Price": price.text});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListcartDetails(),
                        ));
                  }
                },
                child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
