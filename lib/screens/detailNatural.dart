import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/allNatural_api.dart';
import 'package:newwisataklu/notifier/naturalNotifier.dart';
import 'package:newwisataklu/screens/MapScreen/directionMap.dart';
import 'package:newwisataklu/screens/currentCulinary.dart';
import 'package:provider/provider.dart';

class DetailNatural extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   NaturalTourismNotifier naturalTourismNotifier =
        Provider.of<NaturalTourismNotifier>(context);
    Future<void> _refreshList() async {
      getAllNaturalTourisms(naturalTourismNotifier);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshList,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 2.0,
                          )
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(24.0),
                          bottomRight: Radius.circular(24.0)),
                      child: Image(
                        // width: 250,
                        image: NetworkImage(naturalTourismNotifier
                                    .currentNaturalTourism.image !=
                                null
                            ? naturalTourismNotifier
                                    .currentNaturalTourism.image
                            : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20.0,
                    bottom: 20.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          naturalTourismNotifier
                                    .currentNaturalTourism.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2),
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 18.0,
                              color: Colors.white70,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              naturalTourismNotifier.currentNaturalTourism.subDistric,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 18.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20.0,
                    bottom: 20.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DirectionMap(
                                id: naturalTourismNotifier.currentNaturalTourism.image,
                                kind: naturalTourismNotifier.currentNaturalTourism.kind,
                                subD: naturalTourismNotifier.currentNaturalTourism.subDistric,
                              );
                            }));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).primaryColor,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 2.0)
                            ]),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              color: Theme.of(context).primaryColor,
                              size: 20.0,
                            ),
                            Text(
                              "Go!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 5.0, 5, 5.0),
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width * 0.4,
                            // color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Type",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Village",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "publish by",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width * 0.5,
                            // color: Colors.blue,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        " : ${naturalTourismNotifier.currentNaturalTourism.name}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        " : ${naturalTourismNotifier.currentNaturalTourism.kind}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        " : ${naturalTourismNotifier.currentNaturalTourism.village}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        " : ${naturalTourismNotifier.currentNaturalTourism.description}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        " : ${naturalTourismNotifier.currentNaturalTourism.emailUser}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.left,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Tourism on ${naturalTourismNotifier.currentNaturalTourism.subDistric}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Stack(
                 children: <Widget>[
                   CurrentCulinary(subDistric: naturalTourismNotifier.currentNaturalTourism.subDistric)
                 ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
