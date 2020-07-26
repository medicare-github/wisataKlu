import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/allAccTourismUser.dart';
import 'package:newwisataklu/notifier/accNoCulinaryNotifier.dart';
import 'package:newwisataklu/notifier/accNotifier.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/screens/detailTourism.dart';
import 'package:newwisataklu/screens/usersScreen/detailAccNo.dart';
import 'package:newwisataklu/screens/usersScreen/detailCulinaryAccNo.dart';
import 'package:newwisataklu/screens/usersScreen/noAccScreen.dart';
import 'package:provider/provider.dart';

class TourismUser extends StatefulWidget {
  @override
  _TourismUserState createState() => _TourismUserState();
}

class _TourismUserState extends State<TourismUser> {
  @override
  void initState() {
    AccNotifier accNotifier = Provider.of<AccNotifier>(context, listen: false);

    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    getAllAcc(accNotifier, authNotifier.user.email, 'accepted');
  }

  @override
  Widget build(BuildContext context) {
    // TourismNotifier tourismNotifier = Provider.of<TourismNotifier>(context);
    AccNoCulinaryNotifier accNoCulinaryNotifier =
        Provider.of<AccNoCulinaryNotifier>(context, listen: false);
    AccNotifier accNotifier = Provider.of<AccNotifier>(context);
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    Future<void> _refreshList() async {
      getAllAcc(accNotifier, authNotifier.user.email,'accepted');
    }

    return Scaffold(
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(
                          "My Tourism Site",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                                child: RawMaterialButton(
                              onPressed: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.green[300],
                                    border: Border.all(
                                        width: 2, color: Colors.green[300]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'Accepted Tourism',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoAccTourism()),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.green[300]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'not Yet accept Tourism',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.green),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 15.0, left: 10, right: 10),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemCount: accNotifier.accTourismList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      1.5,
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (accNotifier.accTourismList[index].kind == 'natural' || accNotifier.accTourismList[index].kind == 'culture') {
                                accNotifier.currenAccList =
                                  accNotifier.accTourismList[index];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return DetailAccNo();
                              }));
                              } else {
                                accNoCulinaryNotifier.currenAccCulinaryList =
                                    accNotifier.accTourismList[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailCulinaryAccNo();
                                }));
                              }
                             
                              print("tap" +
                                  accNotifier.accTourismList[index].name);
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              child: allTourism(
                                  image: accNotifier
                                              .accTourismList[index].image ==
                                          null
                                      ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'
                                      : accNotifier.accTourismList[index].image,
                                  title: accNotifier.accTourismList[index].name,
                                  kind: accNotifier.accTourismList[index].kind,
                                  subDistric: accNotifier
                                      .accTourismList[index].subDistric,
                                  color:
                                      accNotifier.accTourismList[index].kind ==
                                              'culinary'
                                          ? Colors.orange
                                          : accNotifier.accTourismList[index]
                                                      .kind ==
                                                  'natural'
                                              ? Colors.green
                                              : Colors.blue),
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

Widget allTourism({image, title, kind, subDistric, color}) {
  return Container(
    child: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  height: 110.0,
                  width: 110.0,
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 5.0,
                bottom: 5.0,
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
                top: 5.0,
                right: 5.0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  width: 60,
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Text(
                    kind,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2),
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
