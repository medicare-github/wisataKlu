import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/culinaryTourism_api.dart';
import 'package:newwisataklu/api/cultuteTourism_api.dart';
import 'package:newwisataklu/api/naturalTourism_api.dart';
import 'package:newwisataklu/api/searchApi.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';
import 'package:newwisataklu/notifier/naturalNotifier.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';
import 'package:newwisataklu/screens/allTourism.dart';
import 'package:newwisataklu/screens/culinaryTourism.dart';
import 'package:newwisataklu/screens/cultureTourism.dart';
import 'package:newwisataklu/screens/detailTourism.dart';
import 'package:newwisataklu/screens/naturalTourism.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var tourisms = [];
  bool resulSearch = false;
  String _cari = '';

  @override
  void initState() {
    TourismNotifier tourismNotifier =
        Provider.of<TourismNotifier>(context, listen: false);
    NaturalTourismNotifier naturalTourismNotifier =
        Provider.of<NaturalTourismNotifier>(context, listen: false);
    CultureTourismNotifier cultureTourismNotifier =
        Provider.of<CultureTourismNotifier>(context, listen: false);
    CulinaryTourismNotifier culinaryTourismNotifier =
        Provider.of<CulinaryTourismNotifier>(context, listen: false);

    getTourisms(tourismNotifier);
    getNaturalTourisms(naturalTourismNotifier);
    getCultureTourisms(cultureTourismNotifier);
    getCulinaryTourism(culinaryTourismNotifier);

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TourismNotifier tourismNotifier = Provider.of<TourismNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    NaturalTourismNotifier naturalTourismNotifier =
        Provider.of<NaturalTourismNotifier>(context);
    CultureTourismNotifier cultureTourismNotifier =
        Provider.of<CultureTourismNotifier>(context);
    CulinaryTourismNotifier culinaryTourismNotifier =
        Provider.of<CulinaryTourismNotifier>(context);

    Future<void> _refreshList() async {
      getTourisms(tourismNotifier);
      getNaturalTourisms(naturalTourismNotifier);
      getCultureTourisms(cultureTourismNotifier);
      getCulinaryTourism(culinaryTourismNotifier);
    }

    _search() {
//       var result = _searchApi.searchGo(_cari);
//       if (result==null){
//
//       }else{
//         print("hasil");
//       }
      if (_cari != null) {
        tourisms = [];
        Firestore.instance
            .collection('Tourisms')
            .orderBy('name')
            .where(
              "name",isGreaterThanOrEqualTo: _cari
            )
            .getDocuments()
            .then((docs) {
          if (docs.documents.isNotEmpty) {
            for (int i = 0; i < docs.documents.length; i++) {
              tourisms.add(docs.documents[i].data);
            }
            setState(() {
              resulSearch = true;
            });

            print('hasil : '+tourisms[1].toString());
          }
        });
      }
    }

    return Scaffold(
      body: new RefreshIndicator(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: <Widget>[
              FadeAnimation(
                  1,
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 100.0),
                    child: Text(
                      'What would you like to find ? ${authNotifier.user != null ? authNotifier.user.displayName : 'no user'}',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                  )),
              FadeAnimation(
                  1.3,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 2.0, bottom: 2.0),
                        child: TextField(
                          decoration: InputDecoration(
                            icon: SvgPicture.asset(
                              'assets/icons/search.svg',
                              height: 20.0,
                              width: 20.0,
                            ),
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.search,
//                          onChanged: (String value) {
//                            setState(() {
//                              _cari = value;
//                            });
//                          },
//                          onSubmitted: _search(),
                        ),
                      ),
                    ),
                  )),
              Column(
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'New Tourism Spot',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllTourism()),
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
                    height: 10.0,
                  ),
                  FadeAnimation(
                      1.3,
                      Container(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: tourismNotifier.tourismList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                // tourismNotifier.currentTourism=tourismNotifier.tourismList[index];
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return DetailTourism();
                                // }));
                                tourismNotifier.currentTourism =
                                    tourismNotifier.tourismList[index];
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailTourism();
                                }));
                                print("tap" +
                                    tourismNotifier.tourismList[index].name);
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                width: 120.0,
                                // color: Colors.red,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: <Widget>[
                                    Positioned(
                                      bottom: 26.0,
                                      child: Container(
                                        height: 60.0,
                                        width: 120.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(2.0),
                                                width: 70.0,
                                                decoration: BoxDecoration(
                                                    color: tourismNotifier
                                                                .tourismList[
                                                                    index]
                                                                .kind ==
                                                            null
                                                        ? Colors.grey
                                                        : tourismNotifier
                                                                    .tourismList[
                                                                        index]
                                                                    .kind !=
                                                                "culinary"
                                                            ? tourismNotifier
                                                                        .tourismList[
                                                                            index]
                                                                        .kind ==
                                                                    "natural"
                                                                ? Colors.green
                                                                : Colors.blue
                                                            : Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  tourismNotifier
                                                              .tourismList[
                                                                  index]
                                                              .kind ==
                                                          null
                                                      ? 'no type'
                                                      : tourismNotifier
                                                          .tourismList[index]
                                                          .kind,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                tourismNotifier
                                                    .tourismList[index]
                                                    .description,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(0.0, 2.0),
                                                blurRadius: 6.0)
                                          ]),
                                      child: Stack(
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image(
                                              height: 100.0,
                                              width: 110.0,
                                              image: NetworkImage(
                                                tourismNotifier
                                                            .tourismList[index]
                                                            .image !=
                                                        null
                                                    ? tourismNotifier
                                                        .tourismList[index]
                                                        .image
                                                    : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            left: 5.0,
                                            bottom: 5.0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  tourismNotifier
                                                      .tourismList[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1.2),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .locationArrow,
                                                      size: 6.0,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 3.0,
                                                    ),
                                                    Text(
                                                      tourismNotifier
                                                          .tourismList[index]
                                                          .subDistric,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                  NaturalTourisms(),
                  SizedBox(
                    height: 15,
                  ),
                  CultureTourism(),
                  SizedBox(
                    height: 15,
                  ),
                  CulinaryTourism(),
                ],
              ),
            ],
          ),
        ),
        onRefresh: _refreshList,
      ),
    );
  }
}
