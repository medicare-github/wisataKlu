import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AddNotifier with ChangeNotifier {

  List<Tourism> _addList = [];
  Tourism _currentAdd;

  UnmodifiableListView<Tourism> get addList => UnmodifiableListView(_addList);

  Tourism get currentAdd => _currentAdd;

  set addList(List<Tourism> addList) {
    _addList = addList;
    notifyListeners();
  }

  set currentAdd(Tourism tourism) {
    _currentAdd = tourism;
    notifyListeners();
  }

  addTourism(Tourism tourism) {
    _addList.insert(0, tourism);
    notifyListeners();
  }

  deleteTourim(Tourism tourism) {
    _addList.removeWhere((_add) => _add.id == tourism.id);
    notifyListeners();
  }
}
