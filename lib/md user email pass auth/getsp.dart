import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pro extends StatefulWidget {
  const Pro({Key? key}) : super(key: key);

  @override
  _ProState createState() => _ProState();
}

class _ProState extends State<Pro> {
  late Stream<String> idStream;
  late String id;

  @override
  void initState() {
    super.initState();
    idStream = getIdStream();
  }

  Stream<String> getIdStream() async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Listen to changes in the value of 'id' in SharedPreferences
    yield* Stream.periodic(const Duration(seconds: 1), (_) {
      return prefs.getString('id') ??
          ''; // Provide a default value if 'id' is null
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getfb'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: idStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              id = snapshot.data ?? ''; // Get the latest value from the stream
              return Column(
                children: [
                  Text('ID: $id'),
                  Text("xhXcxT6ob9dil7vR78VMvPCxuP53")
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
