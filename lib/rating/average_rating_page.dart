// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AverageRatingPage extends StatelessWidget {
//   Future<double> _getAverageRating() async {
//     QuerySnapshot querySnapshot =
//         await FirebaseFirestore.instance.collection('ratings').get();
//     if (querySnapshot.docs.isEmpty) {
//       return 0.0;
//     }
//     double total = 0.0;
//     int count = querySnapshot.docs.length;
//     querySnapshot.docs.forEach((doc) {
//       total += doc['rating'];
//     });
//     return total / count;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Average Rating'),
//       ),
//       body: Center(
//         child: FutureBuilder<double>(
//           future: _getAverageRating(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return Text(
//                 'Average Rating: ${snapshot.data?.toStringAsFixed(2) ?? 'N/A'}',
//                 style: TextStyle(fontSize: 24),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ratings')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No ratings found'));
          }

          final ratings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final rating = ratings[index];
              return ListTile(
                title: Text(rating['name']),
                subtitle: Text('Rating: ${rating['rating']}'),
              );
            },
          );
        },
      ),
    );
  }
}
