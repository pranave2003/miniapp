import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miniapp/pr/Premium.dart';
import 'package:miniapp/torch/torch.dart';
import 'CRUD/Firebasecrud.dart';
import 'PhoneAuth/pauthgate.dart';
import 'celibration.dart';
import 'components/bu.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (context) => Favoriteprovider(),
    //   child: const MaterialApp(
    //     home: RatingPage(),
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
