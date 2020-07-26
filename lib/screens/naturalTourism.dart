import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/notifier/naturalNotifier.dart';
import 'package:newwisataklu/screens/allNatural.dart';
import 'package:newwisataklu/screens/detailNatural.dart';
import 'package:provider/provider.dart';

class NaturalTourisms extends StatefulWidget {
  @override
  _NaturalTourismsState createState() => _NaturalTourismsState();
}

class _NaturalTourismsState extends State<NaturalTourisms> {
  @override
  Widget build(BuildContext context) {
    NaturalTourismNotifier naturalTourismNotifier =
        Provider.of<NaturalTourismNotifier>(context);

    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children: <Widget>[
          FadeAnimation(
              1,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Natural Tourism",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllNatural()),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
          FadeAnimation(
              1.4,
              Container(
                height: 140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: naturalTourismNotifier.naturaltourismList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          naturalTourismNotifier.currentNaturalTourism =
                              naturalTourismNotifier.naturaltourismList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return DetailNatural();
                          }));
                          print(naturalTourismNotifier
                              .naturaltourismList[index].name);
                        },
                        child: makeItem(
                            image: naturalTourismNotifier
                                        .naturaltourismList[index].image !=
                                    null
                                ? naturalTourismNotifier
                                    .naturaltourismList[index].image
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                            title: naturalTourismNotifier
                                .naturaltourismList[index].name,
                            subDistric: naturalTourismNotifier
                                .naturaltourismList[index].subDistric),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}

Widget makeItem({image, title, subDistric}) {
  return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          Positioned(
              bottom: 10.0,
              left: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.navigation,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        subDistric,
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
