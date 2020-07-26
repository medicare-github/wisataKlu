import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';
getCulinaryTourism(CulinaryTourismNotifier culinaryTourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('kind', isEqualTo: 'culinary').where('status', isEqualTo: 'accepted')
      .orderBy("acceptedAt", descending: true).limit(5)
      .getDocuments();

  List<Tourism> _culinaryTourismList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _culinaryTourismList.add(tourism);
  });
  culinaryTourismNotifier.culinaryTourismList = _culinaryTourismList;
}
