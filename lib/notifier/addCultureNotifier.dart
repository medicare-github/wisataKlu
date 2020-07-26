import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class AddCultureNotifier with ChangeNotifier {

  List<Tourism> _addCultureList = [];
  Tourism _currentAddCulture;

  UnmodifiableListView<Tourism> get addCultureList => UnmodifiableListView(_addCultureList);

  Tourism get currentAddCulture => _currentAddCulture;

  set addCultureList(List<Tourism> addCultureList) {
    _addCultureList = addCultureList;
    notifyListeners();
  }

  set currentAddCulture(Tourism tourism) {
    _currentAddCulture = tourism;
    notifyListeners();
  }

  addCultureTourism(Tourism tourism) {
    _addCultureList.insert(0, tourism);
    notifyListeners();
  }

  deleteTourim(Tourism tourism) {
    _addCultureList.removeWhere((_addCulture) => _addCulture.id == tourism.id);
    notifyListeners();
  }
}
