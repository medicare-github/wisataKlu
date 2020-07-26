import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';


getAllCuliaryTourism(CulinaryTourismNotifier culinaryTourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('kind', isEqualTo: 'culinary',).where('status', isEqualTo: 'accepted')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Tourism> _culinaryTourismList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _culinaryTourismList.add(tourism);
  });
  culinaryTourismNotifier.culinaryTourismList = _culinaryTourismList;
}