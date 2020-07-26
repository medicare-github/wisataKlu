import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';

getAllTourism(TourismNotifier tourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where("status", isEqualTo: "accepted")
      .orderBy("acceptedAt", descending: true)
      .getDocuments();

  List<Tourism> _tourimsList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _tourimsList.add(tourism);
  });
  tourismNotifier.tourismList = _tourimsList;
}
