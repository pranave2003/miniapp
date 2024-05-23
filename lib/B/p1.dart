// import 'package:flutter/material.dart';
//
// import 'p2.dart';
//
//
// class PhoneNumberPage extends StatelessWidget {
//   final TextEditingController _phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter Phone Number')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Phone number'),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => OTPPage(phoneNumber: _phoneController.text),
//                 ));
//               },
//               child: Text('Next'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
