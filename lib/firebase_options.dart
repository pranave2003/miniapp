// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3Qr67lKWrAZsdnsJTa9W44YJtm_KMOV8',
    appId: '1:314292371786:web:d6b7ea2180a975e3c5c1b3',
    messagingSenderId: '314292371786',
    projectId: 'miniapp-9113d',
    authDomain: 'miniapp-9113d.firebaseapp.com',
    storageBucket: 'miniapp-9113d.appspot.com',
    measurementId: 'G-87QKXJGG4S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNg0EE-KWhZZ4eThpbThCVIAb7zZS8CBo',
    appId: '1:314292371786:android:2ae2830bf1527e7ac5c1b3',
    messagingSenderId: '314292371786',
    projectId: 'miniapp-9113d',
    storageBucket: 'miniapp-9113d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqY9Q3-0lRUar7uUByUGsEVkP7-mhhTd0',
    appId: '1:314292371786:ios:ac71f2234dada4c4c5c1b3',
    messagingSenderId: '314292371786',
    projectId: 'miniapp-9113d',
    storageBucket: 'miniapp-9113d.appspot.com',
    iosBundleId: 'com.example.miniapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAqY9Q3-0lRUar7uUByUGsEVkP7-mhhTd0',
    appId: '1:314292371786:ios:ac71f2234dada4c4c5c1b3',
    messagingSenderId: '314292371786',
    projectId: 'miniapp-9113d',
    storageBucket: 'miniapp-9113d.appspot.com',
    iosBundleId: 'com.example.miniapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD3Qr67lKWrAZsdnsJTa9W44YJtm_KMOV8',
    appId: '1:314292371786:web:9cf70e67f5f5e8a3c5c1b3',
    messagingSenderId: '314292371786',
    projectId: 'miniapp-9113d',
    authDomain: 'miniapp-9113d.firebaseapp.com',
    storageBucket: 'miniapp-9113d.appspot.com',
    measurementId: 'G-JDKK08EQKH',
  );
}
