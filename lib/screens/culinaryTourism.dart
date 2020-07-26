import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';
import 'package:newwisataklu/screens/allCulinary.dart';
import 'package:newwisataklu/screens/detailCulinary.dart';
import 'package:provider/provider.dart';

class CulinaryTourism extends StatefulWidget {
  @override
  _CulinaryTourismState createState() => _CulinaryTourismState();
}

class _CulinaryTourismState extends State<CulinaryTourism> {
  @override
  Widget build(BuildContext context) {
    CulinaryTourismNotifier culinaryTourismNotifier =
        Provider.of<CulinaryTourismNotifier>(context);

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
                      "Culinary Tourism",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                          fontSize: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllCulinary()),
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
                height: 210,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        culinaryTourismNotifier.culinaryTourismList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          culinaryTourismNotifier.currenCulinarList =
                              culinaryTourismNotifier
                                  .culinaryTourismList[index];
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return DetailCulinary();
                          }));
                        },
                        child: makeItem(
                            image: culinaryTourismNotifier
                                        .culinaryTourismList[index].image !=
                                    null
                                ? culinaryTourismNotifier
                                    .culinaryTourismList[index].image
                                : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                            title: culinaryTourismNotifier
                                .culinaryTourismList[index].name,
                            subDistric: culinaryTourismNotifier
                                .culinaryTourismList[index].subDistric,
                          priceStart: culinaryTourismNotifier.culinaryTourismList[index].priceStart,
                          priceEnd: culinaryTourismNotifier.culinaryTourismList[index].priceEnd,
                                ),
                         
                            
                      );
                    }),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget makeItem({
  image,
  title,
  subDistric,
  priceStart,
  priceEnd,
}) {
  return Container(
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            height: 145,
            width: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              color: Colors.white,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[300],
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(left: 8, right: 8),
          width: 142,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w800),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        priceStart.toString()+'-'+priceEnd.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 8),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.orange,
                      size: 10,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      subDistric,
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
