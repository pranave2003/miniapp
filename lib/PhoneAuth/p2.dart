// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
// //
// class _NotificationPageState extends State<NotificationPage> {
//   late FirebaseMessaging _messaging;
//   String _notificationMessage = 'No notification received yet.';
//
//   @override
//   void initState() {
//     super.initState();
//     _messaging = FirebaseMessaging.instance;
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       setState(() {
//         _notificationMessage = message.notification?.body ?? 'No message body';
//       });
//     });
//
//     _subscribeToTopic();
//     _requestPermission();
//   }
//
//   void _subscribeToTopic() {
//     _messaging.subscribeToTopic('all');
//   }
//
//   void _requestPermission() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Notifications')),
//       body: Center(
//         child: Text(
//           _notificationMessage,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
