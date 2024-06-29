
import 'package:flutter/cupertino.dart';

class Favoriteprovider extends ChangeNotifier {
  List<String> _words = [];
  List<String> get words => _words;
  void togglefav(String word) {
    final isExist = _words.contains(word);
    if (isExist) {
      _words.remove(word);
    } else {
      _words.add(word);
    }
    notifyListeners();
  }

  bool isExist(String word){
    final  isExist=_words.contains(word);
    return isExist;
  }

  void clerfav (){
    _words=[];
    notifyListeners();

  }


}
