// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'Video List Page.dart';
//
// class AddVideoPage extends StatefulWidget {
//   @override
//   _AddVideoPageState createState() => _AddVideoPageState();
// }
//
// class _AddVideoPageState extends State<AddVideoPage> {
//   bool _isLoading = false;
//
//   Future<void> _pickAndUploadVideo() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.video);
//     if (result != null) {
//       final file = result.files.first;
//       print("file is $file");
//       final fileName = file.name;
//       print("file name : ////////////// $fileName");
//       final fileBytes = file.bytes;
//       print("Filebyte//////$fileBytes");
//
//       if (fileBytes != null) {
//         print("domne");
//         final ref = FirebaseStorage.instance.ref().child('videos/$fileName');
//         final uploadTask = ref.putData(fileBytes);
//
//         final snapshot = await uploadTask.whenComplete(() => {});
//         final downloadUrl = await snapshot.ref.getDownloadURL();
//
//         print("done");
//
//         await FirebaseFirestore.instance.collection('videos').add({
//           'url': downloadUrl,
//           'name': fileName,
//           'uploaded_at': Timestamp.now(),
//         });
//         print("object");
//
//         setState(() {
//           _isLoading = false;
//         });
//
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Video uploaded successfully!')));
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Video'),
//       ),
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : ElevatedButton(
//                 onPressed: _pickAndUploadVideo,
//                 child: Text('Upload Video'),
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => VideoListPage(),
//               ));
//         },
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Video List Page.dart';

class AddVideoPage extends StatefulWidget {
  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  bool _isLoading = false;

  Future<void> _pickAndUploadVideo() async {
    setState(() {
      _isLoading = true;
    });

    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      final file = result.files.first;
      final filePath = file.path;

      if (filePath != null) {
        final fileName = file.name;
        final fileRef =
            FirebaseStorage.instance.ref().child('videos/$fileName');
        final uploadTask = fileRef.putFile(File(filePath));

        final snapshot = await uploadTask.whenComplete(() => {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('videos').add({
          'url': downloadUrl,
          'name': fileName,
          'uploaded_at': Timestamp.now(),
        });

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Video uploaded successfully!')));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Video'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _pickAndUploadVideo,
                child: Text('Upload Video'),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoListPage(),
              ));
        },
        child: Icon(Icons.video_library),
      ),
    );
  }
}
