import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';
import 'package:newwisataklu/screens/allCulture.dart';
import 'package:newwisataklu/screens/detailCulture.dart';
import 'package:provider/provider.dart';

class CultureTourism extends StatefulWidget {
  @override
  _CultureTourismState createState() => _CultureTourismState();
}

class _CultureTourismState extends State<CultureTourism> {
  @override
  Widget build(BuildContext context) {
    CultureTourismNotifier cultureTourismNotifier =
        Provider.of<CultureTourismNotifier>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          FadeAnimation(
              1,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Culture Tourism",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AllCulture()),
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
                    itemCount: cultureTourismNotifier.culturetourismList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                         onTap: () {
                          cultureTourismNotifier.currentCultureTourism =
                              cultureTourismNotifier.culturetourismList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return DetailCulture();
                          }));
                          print(cultureTourismNotifier
                              .culturetourismList[index].name);
                        },
                        child: makeItem(
                            image: cultureTourismNotifier
                                        .culturetourismList[index].image !=
                                    null
                                ? cultureTourismNotifier
                                    .culturetourismList[index].image
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                            title: cultureTourismNotifier
                                .culturetourismList[index].name),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}

Widget makeItem({image, title}) {
  return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.2)
              ])),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ));
}
