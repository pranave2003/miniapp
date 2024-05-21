import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Settings.dart';
import 'adddataview.dart';

class Bottomnavi extends StatefulWidget {
  const Bottomnavi({super.key});

  @override
  State<Bottomnavi> createState() => _BottomnaviState();
}

class _BottomnaviState extends State<Bottomnavi> {
  List page = [Home(), Addview(), Settings()];
  int indexNum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: indexNum,
        selectedIconTheme: IconThemeData(color: Colors.blue.shade100),
        unselectedIconTheme: IconThemeData(color: Colors.amberAccent),
        onTap: (int Index) {
          setState(() {
            indexNum = Index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: page[indexNum],
    );
  }
}
