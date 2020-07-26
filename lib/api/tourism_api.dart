import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/models/user.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

Future login(User user, AuthNotifier authNotifier) async {
  try {
    FirebaseAuth _auth = FirebaseAuth.instance;

    AuthResult authResult = await _auth.signInWithEmailAndPassword(email: user.email, password: user.password);
    FirebaseUser firebaseUser = authResult.user;
    authNotifier.setUser(firebaseUser);
  } catch (e) {
    print(e.toString());
    return null;
    print("message : "+e.message.toString());
  }
}

 Future signUp(User user, AuthNotifier authNotifier) async {

  FirebaseAuth _auth = FirebaseAuth.instance;

  AuthResult authResult = await _auth
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;
    updateInfo.photoUrl=user.imageProfile;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getTourisms(TourismNotifier tourismNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Tourisms')
      .where('status', isEqualTo: 'accepted')
      .orderBy("acceptedAt", descending: true)
      .limit(10)
      .getDocuments();

  List<Tourism> _tourimsList = [];

  snapshot.documents.forEach((document) {
    Tourism tourism = Tourism.fromMap(document.data);
    _tourimsList.add(tourism);
  });
  tourismNotifier.tourismList = _tourimsList;
}

uploadTourismAndImage(Tourism tourism, bool isUpdating, File localFile,
    Function tourismUploaded) async {
  try {
    if (localFile != null) {
      print("uploading Image");

      var fileExtension = path.extension(localFile.path);
      print(fileExtension);

      var uuid = Uuid().v4();

      final StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('Tourisms/images/$uuid$fileExtension');

      await firebaseStorageRef
          .putFile(localFile)
          .onComplete
          .catchError((onError) {
        print(onError);
        return false;
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print("download url: $url");

      _uploadTourism(tourism, isUpdating, tourismUploaded, imageUrl: url);
    } else {
      print('...skipping image upload');
      _uploadTourism(tourism, isUpdating, tourismUploaded);
    }
  } catch (e){
    return null;
  }
}

_uploadTourism(Tourism tourism, bool isUpdating, Function tourismUploaded,
    {String imageUrl}) async {
  CollectionReference tourismRef = Firestore.instance.collection('Tourisms');

  if (imageUrl != null) {
    tourism.image = imageUrl;
  }

  if (isUpdating) {
    tourism.updatedAt = Timestamp.now();

    // tourism.lating = GeoPoint(tourism.longitude, tourism.latitude);

    await tourismRef.document(tourism.id).updateData(tourism.toMap());

    tourismUploaded(tourism);

    print('updated food with id: ${tourism.id}');
  } else {
    tourism.createdAt = Timestamp.now();

    DocumentReference documentRef = await tourismRef.add(tourism.toMap());

    tourism.id = documentRef.documentID;

    print('uploaded tourism successfully: ${tourism.toString()}');

    await documentRef.setData(tourism.toMap(), merge: true);

    tourismUploaded(tourism);
  }
}

deleteTourism(Tourism tourism, Function tourismDelete) async {
  if (tourism.image != null) {
    StorageReference storageReference =
        await FirebaseStorage.instance.getReferenceFromUrl(tourism.image);

    print(storageReference.path);
    await storageReference.delete();
    print("image deleted");
  }
  await Firestore.instance.collection('Tourisms').document(tourism.id).delete();
  tourismDelete(tourism);
}
