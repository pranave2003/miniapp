import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:miniapp/components/my_Textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ADDdata extends StatefulWidget {
  const ADDdata({super.key});

  @override
  State<ADDdata> createState() => _ADDdataState();
}

class _ADDdataState extends State<ADDdata> {
  var matter = TextEditingController();
  var content = TextEditingController();
  final date = new DateTime.now();
  var link = TextEditingController();
  TimeOfDay time = TimeOfDay.now();
  var ID;
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    setState(() {
      ID = spref.getString("id");

      print(ID.toString());
    });
    print("Updated");
  }

  Adddata() {
    FirebaseFirestore.instance.collection("Details").add({
      "matter": matter.text,
      "content": content.text,
      'Time': time.format(context),
      'date': DateFormat('dd/MM/yyyy').format(date),
      "link": link.text,
      "userid": ID
    });

    matter.clear();
    content.clear();
    link.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          "ADD YOUR DETAILS",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
          ),
          MyTextFields(
              controller: matter,
              hintText: "Matter",
              obscureText: false,
              validation: "EmptyMatter"),
          SizedBox(
            height: 30,
          ),
          MyTextFields(
              controller: content,
              hintText: "Content",
              obscureText: false,
              validation: "EmptyDetails"),
          SizedBox(
            height: 30,
          ),
          MyTextFields(controller: link, hintText: "link", obscureText: false, validation: "emptylink"),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Adddata();
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'ADD',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 15,
                              color: Colors.blue.shade100),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
