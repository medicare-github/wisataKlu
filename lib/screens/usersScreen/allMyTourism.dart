import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/allMyTourism.dart';
import 'package:newwisataklu/notifier/accNoCulinaryNotifier.dart';
import 'package:newwisataklu/notifier/accNotifier.dart';
import 'package:newwisataklu/notifier/allMyTourismNotifier.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/screens/usersScreen/detailAccNo.dart';
import 'package:newwisataklu/screens/usersScreen/detailCulinaryAccNo.dart';
import 'package:provider/provider.dart';

class AllMyTourism extends StatefulWidget {
  @override
  _AllMyTourismState createState() => _AllMyTourismState();
}

class _AllMyTourismState extends State<AllMyTourism> {
  @override
  void initState() {
    AllMyTourismNotifier allMyTourismNotifier =
        Provider.of<AllMyTourismNotifier>(context, listen: false);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getAllMyTourism(allMyTourismNotifier, authNotifier.user.email);
  }

  @override
  Widget build(BuildContext context) {
    AccNotifier accNotifier = Provider.of<AccNotifier>(context);
    AccNoCulinaryNotifier accNoCulinaryNotifier =
        Provider.of<AccNoCulinaryNotifier>(context, listen: false);
    AllMyTourismNotifier allMyTourismNotifier =
        Provider.of<AllMyTourismNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(
      context,
    );

    Future<void> _refreshList() async {
      getAllMyTourism(allMyTourismNotifier, authNotifier.user.email);
    }

    return Scaffold(
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    height: 60,
                    child: Center(
                      child: Text(
                        " All My Submission Tourism Site",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                    top: 30.0, bottom: 15.0, left: 10, right: 10),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 3, mainAxisSpacing: 3),
                itemCount: allMyTourismNotifier.allMyTourismList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      1.5,
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (allMyTourismNotifier
                                          .allMyTourismList[index].kind ==
                                      'natural' ||
                                  allMyTourismNotifier
                                          .allMyTourismList[index].kind ==
                                      'culture') {
                                accNotifier.currenAccList = allMyTourismNotifier
                                    .allMyTourismList[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailAccNo();
                                }));
                              } else {
                                accNoCulinaryNotifier.currenAccCulinaryList =
                                    allMyTourismNotifier
                                        .allMyTourismList[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailCulinaryAccNo();
                                }));
                              }
                            },
                            child: Container(
                              height: 110,
                              width: 110,
                              child: allTourism(
                                image: allMyTourismNotifier
                                            .allMyTourismList[index].image ==
                                        null
                                    ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'
                                    : allMyTourismNotifier
                                        .allMyTourismList[index].image,
                                title: allMyTourismNotifier
                                    .allMyTourismList[index].name,
                                status: allMyTourismNotifier
                                    .allMyTourismList[index].status,
                                subDistric: allMyTourismNotifier
                                    .allMyTourismList[index].subDistric,
                                color: allMyTourismNotifier
                                            .allMyTourismList[index].status ==
                                        'accepted'
                                    ? Colors.purple
                                    : Colors.red,
                              ),
                            ),
                          )
                        ],
                      ));
                },
              ),
            )
          ],
        ),
        onRefresh: _refreshList,
      ),
    );
  }
}

Widget allTourism({image, title, status, subDistric, color,}) {
  return Container(
    child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  height: 110.0,
                  width: 110.0,
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 5.0,
                top: 5.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 6.0,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          subDistric,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                left: 5.0,
                bottom: 5.0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      status,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
