// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'Phonehome.dart';
//
// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }
//
// class _RegistrationPageState extends State<RegistrationPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _placeController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkUserExists();
//   }
//
//   Future<void> _checkUserExists() async {
//     User? user = _auth.currentUser;
//
//     if (user != null) {
//       DocumentSnapshot userDoc =
//           await _firestore.collection('users').doc(user.uid).get();
//
//       if (userDoc.exists) {
//         // User is already registered, navigate to HomePage
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => PhoneHome(),
//         ));
//       }
//     }
//   }
//
//   void _register() async {
//     User? user = _auth.currentUser;
//
//     if (user != null) {
//       await _firestore.collection('users').doc(user.uid).set({
//         'name': _nameController.text,
//         'place': _placeController.text,
//         'phone': user.phoneNumber,
//       });
//
//       _showMessage('Registration successful');
//       Navigator.of(context).pushReplacement(MaterialPageRoute(
//         builder: (context) => PhoneHome(),
//       ));
//     } else {
//       _showMessage('User not signed in');
//     }
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Registration')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _placeController,
//               decoration: InputDecoration(labelText: 'Place'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _register,
//               child: Text('Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
