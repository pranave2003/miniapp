import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniapp/md%20user%20email%20pass%20auth/userdetails.dart';
import 'package:miniapp/md%20user%20email%20pass%20auth/where.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ADDdata.dart';
import 'Login.dart';
import 'profile.dart';
import 'package:url_launcher/link.dart';

class Addview extends StatefulWidget {
  const Addview({super.key});

  @override
  State<Addview> createState() => _AddviewState();
}

class _AddviewState extends State<Addview> {
  late Future<void> _dataFuture;
  String? sid;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _dataFuture = getData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      sid = spref.getString("id");
    });
    print("Updated");
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  Stream<QuerySnapshot> getFilteredStream() {
    if (_searchQuery.isEmpty) {
      return FirebaseFirestore.instance
          .collection("Details")
          .where("userid", isEqualTo: sid)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("Details")
          .where("userid", isEqualTo: sid)
          // For testing purposes, only check if the content starts with the search query.
          .where("content", isGreaterThanOrEqualTo: _searchQuery)
          .where("content", isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            child: Text("ADD"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ADDdata();
                },
              ));
            },
          ),
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return GetWhere();
                  },
                ));
              },
              icon: Icon(
                Icons.person_rounded,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.red,
                ),
              )
            ],
            title: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mdprofile(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'MD',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.blue.shade100,
                        letterSpacing: .5,
                        fontSize: 30),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search by content',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              Text("VIEW"),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: getFilteredStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }
                    final data = snapshot.data?.docs ?? [];
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var document = data[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Userdetails(id: document.id),
                                  ));
                            },
                            child: Card(
                              color: Colors.blue.shade100,
                              shadowColor: Colors.black,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("Details")
                                                  .doc(document.id)
                                                  .delete();
                                            },
                                            icon: Icon(Icons.delete))
                                      ],
                                    ),
                                    Text(document['content'] ?? 'No details'),
                                    Text(document['matter'] ?? 'No matter'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: 350,
                                              child: Column(
                                                children: [
                                                  Link(
                                                    uri: Uri.parse(
                                                        document["link"]),
                                                    builder:
                                                        (context, followLink) =>
                                                            TextButton(
                                                                onPressed:
                                                                    followLink,
                                                                child: Text(
                                                                  "click to view",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue),
                                                                )),
                                                  )
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(document['Time'] ?? 'No matter'),
                                        Text(document['date'] ?? 'No matter'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
