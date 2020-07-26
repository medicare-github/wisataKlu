import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/allMyTourismNotifier.dart';


getAllMyTourism(AllMyTourismNotifier allMyTourismNotifier, String emailUser) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('emailUser', isEqualTo: emailUser,)
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Tourism> _allMyTourismList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _allMyTourismList.add(tourism);
  });
 allMyTourismNotifier.allMyTourismList= _allMyTourismList;
}