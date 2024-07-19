// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'average_rating_page.dart';
//
// class RatingPage extends StatefulWidget {
//   @override
//   _RatingPageState createState() => _RatingPageState();
// }
//
// class _RatingPageState extends State<RatingPage> {
//   double _rating = 3.0;
//
//   void _submitRating() async {
//     await FirebaseFirestore.instance.collection('ratings').add({
//       'rating': _rating,
//       'timestamp': Timestamp.now(),
//     });
//     Navigator.pushNamed(context, '/average');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(
//             builder: (context) {
//               return AverageRatingPage();
//             },
//           ));
//         },
//       ),
//       appBar: AppBar(
//         title: Text('Rate the Fire'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Rate the fire:',
//               style: TextStyle(fontSize: 24),
//             ),
//             Slider(
//               value: _rating,
//               min: 1,
//               max: 5,
//               divisions: 4,
//               label: _rating.toString(),
//               onChanged: (value) {
//                 setState(() {
//                   _rating = value;
//                 });
//               },
//             ),
//             ElevatedButton(
//               onPressed: _submitRating,
//               child: Text('Submit Rating'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'average_rating_page.dart';

class RatingPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  void addRating(String name, int rating) async {
    await FirebaseFirestore.instance.collection('ratings').add({
      'name': name,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Rating'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                int rating = int.parse(ratingController.text);
                addRating(name, rating);
                nameController.clear();
                ratingController.clear();
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RatingsListPage()),
                );
              },
              child: Text('View Ratings'),
            ),
          ],
        ),
      ),
    );
  }
}
