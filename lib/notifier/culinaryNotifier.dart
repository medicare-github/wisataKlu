import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:newwisataklu/models/tourism.dart';

class CulinaryTourismNotifier with ChangeNotifier {

  List<Tourism> _culinaryTourismList = [];
  Tourism _currenCulinarList;

  UnmodifiableListView<Tourism> get culinaryTourismList =>
      UnmodifiableListView(_culinaryTourismList);

  Tourism get currenCulinarList => _currenCulinarList;

  set culinaryTourismList(List<Tourism> culinaryTourismList) {
    _culinaryTourismList = culinaryTourismList;
    notifyListeners();
  }

  set currenCulinarList(Tourism tourism) {
    _currenCulinarList = tourism;
    notifyListeners();
  }
}
