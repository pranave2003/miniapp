// // import 'package:flutter/material.dart';
// //
// // class Picker extends StatefulWidget {
// //   const Picker({Key? key}) : super(key: key);
// //
// //   @override
// //   State<Picker> createState() => _PickerState();
// // }
// //
// // class _PickerState extends State<Picker> {
// //   DateTime? _selectedDate;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Select Date and Time',
// //               style: TextStyle(fontSize: 24),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 DateTime? datepick = await showDatePicker(
// //                   context: context,
// //                   initialDate: DateTime.now(),
// //                   firstDate: DateTime(2000),
// //                   lastDate: DateTime(2025),
// //                 );
// //                 if (datepick != null) {
// //                   setState(() {
// //                     _selectedDate = datepick;
// //                   });
// //                 }
// //               },
// //               child: Text('Date'),
// //             ),
// //             SizedBox(height: 20),
// //             if (_selectedDate != null)
// //               // Text("$_selectedDate"),
// //               Text(
// //                 'Selected Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
// //                 style: TextStyle(fontSize: 18),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Picker extends StatefulWidget {
//   const Picker({Key? key}) : super(key: key);
//
//   @override
//   State<Picker> createState() => _PickerState();
// }
//
// class _PickerState extends State<Picker> {
//   DateTime? _selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Select Date and Time',
//               style: TextStyle(fontSize: 24),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 DateTime? datepick = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2025),
//                 );
//                 if (datepick != null) {
//                   setState(() {
//                     _selectedDate = datepick;
//                     _saveDateToFirestore(datepick);
//                   });
//                 }
//               },
//               child: Text('Date'),
//             ),
//             SizedBox(height: 20),
//             if (_selectedDate != null)
//               Text(
//                 'Selected Date: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
//                 style: TextStyle(fontSize: 18),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _saveDateToFirestore(DateTime date) async {
//     print("object");
//     String formattedDate =
//         '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
//
//     await FirebaseFirestore.instance.collection('dates').add({
//       'date': formattedDate,
//     });
//     print("done");
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Picker(),
    );
  }
}

class Picker extends StatefulWidget {
  const Picker({Key? key}) : super(key: key);

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Date and Time',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                DateTime? datepick = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2025),
                );
                if (datepick != null) {
                  setState(() {
                    _selectedDate = datepick;
                  });
                }
              },
              child: Text('Pick Date'),
            ),
            SizedBox(height: 20),
            if (_selectedDate != null)
              Text(
                'Selected Date: ${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedDate == null
                  ? null
                  : () async {
                      String formattedDate =
                          '${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year}';

                      try {
                        await FirebaseFirestore.instance
                            .collection('dates')
                            .add({
                          'date': formattedDate,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Date saved successfully')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to save date: $e')));
                      }
                    },
              child: Text('Add Date'),
            ),
          ],
        ),
      ),
    );
  }
}
