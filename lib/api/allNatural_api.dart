import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/naturalNotifier.dart';

getAllNaturalTourisms(NaturalTourismNotifier naturalTourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('kind', isEqualTo: 'natural').where('status', isEqualTo: 'accepted')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Tourism> _naturetourimsList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _naturetourimsList.add(tourism);
  });
  naturalTourismNotifier.naturaltourismList = _naturetourimsList;
}