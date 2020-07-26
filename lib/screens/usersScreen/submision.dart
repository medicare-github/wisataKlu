import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';
import 'package:newwisataklu/screens/detailTourism.dart';
import 'package:newwisataklu/screens/usersScreen/addCulinary.dart';
import 'package:newwisataklu/screens/usersScreen/addCulture.dart';
import 'package:newwisataklu/screens/usersScreen/addNatural.dart';
import 'package:provider/provider.dart';

class SubmisionScreen extends StatefulWidget {
  @override
  _SubmisionScreenState createState() => _SubmisionScreenState();
}

class _SubmisionScreenState extends State<SubmisionScreen> {
  @override
  void initState() {
    TourismNotifier tourismNotifier =
        Provider.of<TourismNotifier>(context, listen: false);
    getTourisms(tourismNotifier);
  }

  @override
  Widget build(BuildContext context) {
    TourismNotifier tourismNotifier = Provider.of<TourismNotifier>(context);

    double size;
    double heightn;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      size = 180;
      heightn = 180;
    } else {
      size = 130.0;
      heightn = 150.0;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 480,
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.2, 
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(
                        'Submision',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                    FadeAnimation(1.2,
                    Text(
                      'submision your tourism sites',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )),
                    FadeAnimation(1.3, 
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCulinary(
                                          isUpdating: false,
                                        )),
                              );
                            },
                            child: Container(
                              // color: Colors.blue,
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: size,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0.0, 2.0),
                                        blurRadius: 6.0)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/culinary.jpg"),
                                      fit: BoxFit.cover)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    size: 60,
                                    color: Colors.white.withOpacity(1),
                                  ),
                                  Text(
                                    "Add Culinary Tourism",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCulture(
                                          isUpdating: false,
                                        )),
                              );
                            },
                            child: Container(
                              // color: Colors.blue,
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: size,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/culture.jpg"),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0)
                                ],
                              ),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Add Culture Tourism",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(1.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    FadeAnimation(1.4, 
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNatural(
                                      isUpdating: false,
                                    )),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: heightn,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                                image: AssetImage("assets/images/natural.jpg"),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 6.0)
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 60,
                                color: Colors.white,
                              ),
                              Text(
                                "Add Natural Tourism",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 10,),
                    FadeAnimation(1.3, 
                    Center(
                      child: Text(
                        "New Tourism accepted submision", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: GridView.builder(
              padding:
                  EdgeInsets.only(top: 10.0, bottom: 15.0, left: 10, right: 10),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: tourismNotifier.tourismList.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeAnimation(
                    1.5,
                    Column(
                      children: <Widget>[
                        GestureDetector(
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
                            height: 80,
                            width: 80,
                            child: allTourism(
                                image: tourismNotifier
                                            .tourismList[index].image ==
                                        null
                                    ? 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg'
                                    : tourismNotifier.tourismList[index].image,
                                title: tourismNotifier.tourismList[index].name,
                                kind: tourismNotifier.tourismList[index].kind,
                                subDistric: tourismNotifier
                                    .tourismList[index].subDistric,
                                color: tourismNotifier
                                            .tourismList[index].kind ==
                                        'culinary'
                                    ? Colors.orange
                                    : tourismNotifier.tourismList[index].kind ==
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
