import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/accNotifier.dart';


getAllAcc(AccNotifier accNotifier, String emailUser, String statusAcc) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('emailUser', isEqualTo: emailUser,).where('status', isEqualTo: statusAcc)
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Tourism> _accTourismList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _accTourismList.add(tourism);
  });
  accNotifier.accTourismList = _accTourismList;
}