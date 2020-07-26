import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AddCulinaryeNotifier with ChangeNotifier {

  List<Tourism> _addCulinaryList = [];
  Tourism _currentAddCulinary;

  UnmodifiableListView<Tourism> get addCulinaryList => UnmodifiableListView(_addCulinaryList);

  Tourism get currentAddCulinary => _currentAddCulinary;

  set addCulinaryList(List<Tourism> addCulinaryList) {
    _addCulinaryList = addCulinaryList;
    notifyListeners();
  }

  set currentAddCulinary(Tourism tourism) {
    _currentAddCulinary = tourism;
    notifyListeners();
  }

  addCulinaryTourism(Tourism tourism) {
    _addCulinaryList.insert(0, tourism);
    notifyListeners();
  }

  deleteTourim(Tourism tourism) {
    _addCulinaryList.removeWhere((_addCulinary) => _addCulinary.id == tourism.id);
    notifyListeners();
  }
}
