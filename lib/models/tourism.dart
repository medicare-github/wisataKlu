import 'package:cloud_firestore/cloud_firestore.dart';

class Tourism {
  String id;
  String idUser;
  String emailUser;
  String name;
  String country = "North Lombok";
  String subDistric;
  String village;
  String description;
  String status;
  String kind;
  String image;
  double longitude;
  double latitude;
  Timestamp createdAt;
  Timestamp updatedAt;
  GeoPoint lating;
  String open;
  String close;
  int priceStart;
  int priceEnd;
  int ticket;

  Tourism();

  Tourism.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    idUser = data['idUser'];
    emailUser = data['emailUser'];
    name = data['name'];
    country = data['country'];
    subDistric = data['subDistric'];
    village = data['village'];
    description = data['description'];
    status = data['status'];
    kind = data['kind'];
    image = data['image'];
    createdAt = data['createAt'];
    updatedAt = data['updateAt'];
    lating = data['lating'];
    open = data['open'];
    close = data['close'];
    priceStart = data['priceStart'];
    priceEnd = data['priceEnd'];
    ticket = data['ticket'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'emailUser': emailUser,
      'name': name,
      'country': country,
      'subDistric': subDistric,
      'village': village,
      'description': description,
      'status': status,
      'kind': kind,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'lating': lating,
      'open': open,
      'close': close,
      'priceStart': priceStart,
      'priceEnd': priceEnd,
      'ticket': ticket,
    };
  }
}
