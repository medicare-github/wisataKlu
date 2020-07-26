import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/accNotifier.dart';
import 'package:newwisataklu/screens/usersScreen/addCulture.dart';
import 'package:newwisataklu/screens/usersScreen/editCulture.dart';
import 'package:newwisataklu/screens/usersScreen/editNatural.dart';
import 'package:provider/provider.dart';

class DetailAccNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccNotifier accNotifier = Provider.of<AccNotifier>(context);

    _onTourismDeleted(Tourism tourism) {
      Navigator.pop(context);
      accNotifier.deleteTourism(tourism);
    }

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
      body: Center(
          child: Column(
        children: <Widget>[
          FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Text(
                  'Details ${accNotifier.currenAccList.name} Tourism',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
          FadeAnimation(
              1.2,
              Text(
                'You can edit this Tourism Site ',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )),
          FadeAnimation(
              1.4,
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: heightn,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        image: NetworkImage(accNotifier.currenAccList.image),
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
                      Text(
                        accNotifier.currenAccList.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 16,
                          ),
                          Text(
                            accNotifier.currenAccList.subDistric,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          FadeAnimation(
              1.4,
              Container(
                margin: EdgeInsets.fromLTRB(5, 5.0, 5, 5.0),
                height: 260,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Latitude",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "longitude",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Ticker",
                                    style: TextStyle(
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                                    accNotifier.currenAccList.name != null
                                        ? ': ' + accNotifier.currenAccList.name
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.kind != null
                                        ? ': ' + accNotifier.currenAccList.kind
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.village != null
                                        ? ': ' +
                                            accNotifier.currenAccList.village
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.lating.latitude
                                                .toString() !=
                                            null
                                        ? ': ' +
                                            accNotifier
                                                .currenAccList.lating.latitude
                                                .toString()
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.lating
                                                .longitude !=
                                            null
                                        ? ': ' +
                                            accNotifier
                                                .currenAccList.lating.longitude
                                                .toString()
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.ticket != 0
                                        ? ': Rp.' +
                                            accNotifier.currenAccList.ticket
                                                .toString()
                                        : ': Free',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNotifier.currenAccList.description !=
                                            null
                                        ? ': ' +
                                            accNotifier
                                                .currenAccList.description
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'button1',
            onPressed: () {
              if (accNotifier.currenAccList.kind == 'natural') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return EditNatural(
                      isUpdating: true,
                    );
                  }),
                );
              } else if (accNotifier.currenAccList.kind == 'culture') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return EditCulture(
                      isUpdating: true,
                    );
                  }),
                );
              }
            },
            child: Icon(
              Icons.edit,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.orange,
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            heroTag: 'button2',
            onPressed: () =>
                deleteTourism(accNotifier.currenAccList, _onTourismDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
