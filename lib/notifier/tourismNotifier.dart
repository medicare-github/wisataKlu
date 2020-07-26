import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class TourismNotifier with ChangeNotifier {

  List<Tourism> _tourismList = [];
  Tourism _currentTourism;

  UnmodifiableListView<Tourism> get tourismList => UnmodifiableListView(_tourismList);

  Tourism get currentTourism => _currentTourism;

  set tourismList(List<Tourism> tourismList) {
    _tourismList = tourismList;
    notifyListeners();
  }

  set currentTourism(Tourism tourism) {
    _currentTourism = tourism;
    notifyListeners();
  }

  addTourism(Tourism tourism) {
    _tourismList.insert(0, tourism);
    notifyListeners();
  }

  deleteTourim(Tourism tourism) {
    _tourismList.removeWhere((_tourism) => _tourism.id == tourism.id);
    notifyListeners();
  }
}
