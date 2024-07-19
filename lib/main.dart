import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:miniapp/Fav%20using%20provider/Favproovider.dart';
import 'package:miniapp/payment/ListCart.dart';
import 'package:miniapp/rating/rating_page.dart';
import 'package:miniapp/torch/torch.dart';
import 'package:miniapp/video%20secssion/addvideo.dart';
import 'package:provider/provider.dart';
import 'Fav using provider/Homepage.dart';
import 'NEW_WIDGETS/Segmented_button.dart';
import 'NEW_WIDGETS/Slider_widget.dart';
import 'NEW_WIDGETS/Stepper.dart';
import 'firebase_options.dart';
import 'innercollection/view.dart';
import 'media_q.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
      home: FlashlightPage(),
    );
  }
}
