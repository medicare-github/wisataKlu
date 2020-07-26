import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';

getAllCultureTourisms(CultureTourismNotifier cultureTourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('kind', isEqualTo: 'culture').where('status', isEqualTo: 'accepted')
      .orderBy("acceptedAt", descending: true)
      .getDocuments();

  List<Tourism> _naturetourimsList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _naturetourimsList.add(tourism);
  });
  cultureTourismNotifier.culturetourismList = _naturetourimsList;
}