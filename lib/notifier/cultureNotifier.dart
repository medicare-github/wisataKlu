import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class CultureTourismNotifier with ChangeNotifier {

  List<Tourism> _culturetourismList = [];
  Tourism _currentCultureTourism;

  UnmodifiableListView<Tourism> get culturetourismList =>
      UnmodifiableListView(_culturetourismList);

  Tourism get currentCultureTourism => _currentCultureTourism;

  set culturetourismList(List<Tourism> culturetourismList) {
    _culturetourismList = culturetourismList;
    notifyListeners();
  }

  set currentCultureTourism(Tourism tourism) {
    _currentCultureTourism = tourism;
    notifyListeners();
  }
}
