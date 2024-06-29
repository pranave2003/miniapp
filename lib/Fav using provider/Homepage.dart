import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Favpage.dart';
import 'Favproovider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favoriteprovider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("notifications").get(),
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
          final fav = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: fav.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(fav[index].id),
                trailing: IconButton(
                    onPressed: () {
                      provider.togglefav(fav[index]["message"]);
                    },
                    icon: provider.isExist(fav[index]["message"])
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Favpage();
            },
          ));
        },
        child: Text("Fav"),
      ),
    );
  }
}
