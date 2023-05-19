import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../models/spender.dart';

class FavoritesRepository extends ChangeNotifier{
  List<Spender> _list = [];

  UnmodifiableListView<Spender> get list => UnmodifiableListView(_list);

  saveAll(List<Spender> spenders){
    spenders.forEach((spender) {
      if(!_list.contains(spender)) _list.add(spender);
    });

    notifyListeners();
  }

  remove(Spender spender){
    _list.remove(spender);
    notifyListeners();
  }
}