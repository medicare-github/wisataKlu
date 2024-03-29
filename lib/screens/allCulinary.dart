import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/allCulinary.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';
import 'package:newwisataklu/screens/detailCulinary.dart';
import 'package:provider/provider.dart';

class AllCulinary extends StatefulWidget {
  @override
  _AllCulinaryState createState() => _AllCulinaryState();
}

class _AllCulinaryState extends State<AllCulinary> {
  @override
  void initState() {
    CulinaryTourismNotifier culinaryTourismNotifier =
        Provider.of<CulinaryTourismNotifier>(context, listen: false);
    getAllCuliaryTourism(culinaryTourismNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CulinaryTourismNotifier culinaryTourismNotifier =
        Provider.of<CulinaryTourismNotifier>(
      context,
    );

    Future<void> _refreshList() async {
      getAllCuliaryTourism(culinaryTourismNotifier);
    }

    int count;
    double size;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      count = 5;
      size = 120;
    } else {
      count = 3;
      size = 110.0;
    }
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _refreshList,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/pemandangan.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          colors: [
                        Colors.black.withOpacity(.8),
                        Colors.black.withOpacity(.2)
                      ])),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Text(
                            "would you like to find of tourism site?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.3,
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  hintText: "Search for tourism site"),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding:
                  EdgeInsets.only(top: 10.0, bottom: 15.0, left: 10, right: 10),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2),
              itemCount: culinaryTourismNotifier.culinaryTourismList.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeAnimation(
                    1.5,
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            culinaryTourismNotifier.currenCulinarList=
                               culinaryTourismNotifier.culinaryTourismList[index];
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return DetailCulinary();
                            }));
                          },
                          child: Container(
                            height: size,
                            width: size,
                            child: allTourism(
                                image: culinaryTourismNotifier.culinaryTourismList[index].image ==
                                        null
                                    ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'
                                    : culinaryTourismNotifier.culinaryTourismList[index].image,
                                title: culinaryTourismNotifier.culinaryTourismList[index].name,
                                kind: culinaryTourismNotifier.culinaryTourismList[index].kind,
                                subDistric: culinaryTourismNotifier.culinaryTourismList[index].subDistric,
                                color: culinaryTourismNotifier.culinaryTourismList[index].kind ==
                                        'culinary'
                                    ? Colors.orange
                                    : culinaryTourismNotifier.culinaryTourismList[index]
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
    ));
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
