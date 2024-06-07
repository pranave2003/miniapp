// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AddDataPage extends StatefulWidget {
//   @override
//   _AddDataPageState createState() => _AddDataPageState();
// }
//
// class _AddDataPageState extends State<AddDataPage> {
//   final TextEditingController _controller = TextEditingController();
//
//   void _addData() async {
//     print("done");
//     String text = _controller.text;
//
//     await FirebaseFirestore.instance.collection('noti').add({
//       'message': text,
//       'timestamp': FieldValue.serverTimestamp(),
//     });
//     print("objlect");
//     _controller.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Data')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(labelText: 'Enter your message'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _addData,
//               child: Text('Add Data to Firestore'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
