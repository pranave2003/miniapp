// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'Phonehome.dart';
// import 'p3.dart';
//
//
// class OTPPage extends StatefulWidget {
//   final String phoneNumber;
//
//   OTPPage({required this.phoneNumber});
//
//   @override
//   _OTPPageState createState() => _OTPPageState();
// }
//
// class _OTPPageState extends State<OTPPage> with CodeAutoFill {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _codeController = TextEditingController();
//   String? _verificationId;
//   bool _codeSent = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _verifyPhoneNumber();
//     listenForCode();
//   }
//
//   @override
//   void codeUpdated() {
//     setState(() {
//       _codeController.text = code!;
//     });
//     if (code != null) {
//       _signInWithPhoneNumber();
//     }
//   }
//
//   @override
//   void dispose() {
//     cancel();
//     super.dispose();
//   }
//
//   void _verifyPhoneNumber() async {
//     await _auth.verifyPhoneNumber(
//       phoneNumber: widget.phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//         _navigateBasedOnUserStatus();
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         _showMessage('Verification failed: ${e.message}');
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         setState(() {
//           _verificationId = verificationId;
//           _codeSent = true;
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         _verificationId = verificationId;
//       },
//     );
//   }
//
//   void _signInWithPhoneNumber() async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId!,
//         smsCode: _codeController.text,
//       );
//       await _auth.signInWithCredential(credential);
//       _navigateBasedOnUserStatus();
//     } catch (e) {
//       _showMessage('Failed to sign in: ${e.toString()}');
//     }
//   }
//
//   void _navigateBasedOnUserStatus() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
//       if (userDoc.exists) {
//         // User is already registered, navigate to HomePage
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => PhoneHome(),
//         ));
//       } else {
//         // New user, navigate to RegistrationPage
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => RegistrationPage(),
//         ));
//       }
//     }
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter OTP')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _codeController,
//               decoration: InputDecoration(labelText: 'Verification code'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _signInWithPhoneNumber,
//               child: Text('Verify'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
