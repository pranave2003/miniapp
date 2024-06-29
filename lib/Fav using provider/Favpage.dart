import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Favproovider.dart';

class Favpage extends StatelessWidget {
  const Favpage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Favoriteprovider>(context);
    final word = provider.words;

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final _word = word[index];
          return ListTile(
            title: Text(_word),
            trailing: IconButton(
                onPressed: () {
                  provider.togglefav(_word);
                },
                icon: provider.isExist(_word)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border)),
          );
        },
        itemCount: word.length,
      ),
    );
  }
}
