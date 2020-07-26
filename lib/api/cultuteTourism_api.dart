import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';

getCultureTourisms(CultureTourismNotifier cultureTourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('kind', isEqualTo: 'culture').where('status', isEqualTo: 'accepted')
      .orderBy("createdAt", descending: true).limit(5)
      .getDocuments();

  List<Tourism> _culturetourimsList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _culturetourimsList.add(tourism);
  });
  cultureTourismNotifier.culturetourismList = _culturetourimsList;
}
