import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AccNotifier with ChangeNotifier {

  List<Tourism> _accTourismList = [];
  Tourism _currenAccList;

  UnmodifiableListView<Tourism> get accTourismList =>
      UnmodifiableListView(_accTourismList);

  Tourism get currenAccList => _currenAccList;

  set accTourismList(List<Tourism> accTourismList) {
    _accTourismList = accTourismList;
    notifyListeners();
  }

  set currenAccList(Tourism tourism) {
    _currenAccList = tourism;
    notifyListeners();
  }

 deleteTourism(Tourism tourism) {
    _accTourismList.removeWhere((_tourism) => _tourism.id == tourism.id);
    notifyListeners();
  }

}
