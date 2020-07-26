import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class NaturalTourismNotifier with ChangeNotifier {

  List<Tourism> _naturaltourismList = [];
  Tourism _currentNaturalTourism;

  UnmodifiableListView<Tourism> get naturaltourismList =>
      UnmodifiableListView(_naturaltourismList);

  Tourism get currentNaturalTourism => _currentNaturalTourism;

  set naturaltourismList(List<Tourism> naturaltourismList) {
    _naturaltourismList = naturaltourismList;
    notifyListeners();
  }

  set currentNaturalTourism(Tourism tourism) {
    _currentNaturalTourism = tourism;
    notifyListeners();
  }
}
