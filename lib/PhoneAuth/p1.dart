// import 'package:flutter/material.dart';
//
// import 'p2.dart';
// import 'p3.dart';
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => AddDataPage()),
//                 );
//               },
//               child: Text('Add Data to Firestore'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => NotificationPage()),
//                 );
//               },
//               child: Text('Receive Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
