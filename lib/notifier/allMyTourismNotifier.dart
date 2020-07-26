import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AllMyTourismNotifier with ChangeNotifier {

  List<Tourism> _allMyTourismList = [];
  Tourism _currenAllMyTourismList;

  UnmodifiableListView<Tourism> get allMyTourismList =>
      UnmodifiableListView(_allMyTourismList);

  Tourism get currenAllMyTourismList => _currenAllMyTourismList;

  set allMyTourismList(List<Tourism> allMyTourismList) {
    _allMyTourismList = allMyTourismList;
    notifyListeners();
  }

  set currenAllMyTourismList(Tourism tourism) {
    _currenAllMyTourismList = tourism;
    notifyListeners();
  }

 deleteTourism(Tourism tourism) {
    _allMyTourismList.removeWhere((_tourism) => _tourism.id == tourism.id);
    notifyListeners();
  }

}
