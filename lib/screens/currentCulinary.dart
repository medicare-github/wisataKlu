import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/screens/MapScreen/directionMap.dart';

class CurrentCulinary extends StatefulWidget {
  CurrentCulinary({this.subDistric});
  final String subDistric;
  @override
  _CurrentCulinaryState createState() => _CurrentCulinaryState();
}

class _CurrentCulinaryState extends State<CurrentCulinary> {
  var tourisms = [];
  bool clientToggle = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentTourism(widget.subDistric);
    });
  }

  currentTourism(subDistric) {
    tourisms = [];
    Firestore.instance
        .collection('Tourisms')
        .where('subDistric', isEqualTo: subDistric).where('status', isEqualTo: "accepted")
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          clientToggle = true;
        });
        for (int i = 0; i < docs.documents.length; i++) {
          tourisms.add(docs.documents[i].data);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.3,
      Container(
        height: 110,
        width: MediaQuery.of(context).size.width - 10,
        child: clientToggle
            ? ListView(
                scrollDirection: Axis.horizontal,
                children: tourisms.map((element) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return DirectionMap(
                          id: element['image'],
                          kind: element['kind'],
                          subD: element['subDistric'],
                        );
                      }));
                    },
                    child: makeItem(element),
                  );
                }).toList(),
              )
            : Text("Loading"),
      ),
    );
  }
}

Widget makeItem(element) {
  return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: NetworkImage(element['image']), fit: BoxFit.cover),
            ),
          ),
          Positioned(
              bottom: 10.0,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    element['name'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        element['kind'] == 'natural'
                            ? Icons.filter_hdr
                            : element['kind'] == 'culinary'
                                ? Icons.local_pizza
                                : Icons.ac_unit,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        element['subDistric'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ))
        ],
      ));
}
