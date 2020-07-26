import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AccNoCulinaryNotifier with ChangeNotifier {

  List<Tourism> _accCulinaryList = [];
  Tourism _currenAccCulinaryList;

  UnmodifiableListView<Tourism> get accCulinaryList =>
      UnmodifiableListView(_accCulinaryList);

  Tourism get currenAccCulinaryList => _currenAccCulinaryList;

  set accCulinaryList(List<Tourism> accCulinaryList) {
    _accCulinaryList = accCulinaryList;
    notifyListeners();
  }

  set currenAccCulinaryList(Tourism tourism) {
    _currenAccCulinaryList = tourism;
    notifyListeners();
  }

 deleteTourism(Tourism tourism) {
    _accCulinaryList.removeWhere((_tourism) => _tourism.id == tourism.id);
    notifyListeners();
  }

}
