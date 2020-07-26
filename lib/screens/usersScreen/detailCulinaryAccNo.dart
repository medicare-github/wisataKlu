import 'package:flutter/material.dart';
import 'package:newwisataklu/animation/animation.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/models/tourism.dart';
import 'package:newwisataklu/notifier/accNoCulinaryNotifier.dart';
// import 'package:newwisataklu/notifier/accNoCulinaryNotifier.dart';
import 'package:newwisataklu/screens/usersScreen/editCulinary.dart';
import 'package:provider/provider.dart';

class DetailCulinaryAccNo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccNoCulinaryNotifier accNoCulinaryNotifier = Provider.of<AccNoCulinaryNotifier>(context);

    _onTourismDeleted(Tourism tourism) {
      Navigator.pop(context);
      accNoCulinaryNotifier.deleteTourism(tourism);
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
                  'Details ${accNoCulinaryNotifier.currenAccCulinaryList.name} Tourism',
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
                        image: NetworkImage(accNoCulinaryNotifier.currenAccCulinaryList.image),
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
                        accNoCulinaryNotifier.currenAccCulinaryList.name,
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
                            accNoCulinaryNotifier.currenAccCulinaryList.subDistric,
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
                height: 240,
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
                        height: 240,
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
                                    "Start - close time",
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
                                    "Price",
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
                        height: 240,
                        width: MediaQuery.of(context).size.width * 0.5,
                        // color: Colors.blue,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNoCulinaryNotifier.currenAccCulinaryList.name != null
                                        ? ': ' + accNoCulinaryNotifier.currenAccCulinaryList.name
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
                                    accNoCulinaryNotifier.currenAccCulinaryList.kind != null
                                        ? ': ' + accNoCulinaryNotifier.currenAccCulinaryList.kind
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
                                    accNoCulinaryNotifier.currenAccCulinaryList.village != null
                                        ? ': ' +
                                            accNoCulinaryNotifier.currenAccCulinaryList.village
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
                                    accNoCulinaryNotifier.currenAccCulinaryList.lating.latitude
                                                .toString() !=
                                            null
                                        ? ': ' +
                                            accNoCulinaryNotifier
                                                .currenAccCulinaryList.lating.latitude
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
                                    accNoCulinaryNotifier.currenAccCulinaryList.lating
                                                .longitude !=
                                            null
                                        ? ': ' +
                                            accNoCulinaryNotifier
                                                .currenAccCulinaryList.lating.longitude
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
                                  child: Container(
                                    height: 16,
                                    width: 200,
                                    // color: Colors.red,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(":",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              height: 16,
                                              width: 40,
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text(
                                                accNoCulinaryNotifier.currenAccCulinaryList.open,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("-"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 16,
                                          width: 40,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            accNoCulinaryNotifier.currenAccCulinaryList.close,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    height: 16,
                                    width: 200,
                                    // color: Colors.red,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(":",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              height: 16,
                                              width: 70,
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Text(
                                                'Rp. '+accNoCulinaryNotifier.currenAccCulinaryList.priceStart.toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("-"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 16,
                                          width: 70,
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                              child: Text(
                                            'Rp. '+accNoCulinaryNotifier.currenAccCulinaryList.priceEnd.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    accNoCulinaryNotifier.currenAccCulinaryList.description !=
                                            null
                                        ? ': ' +
                                            accNoCulinaryNotifier
                                                .currenAccCulinaryList.description
                                        : ': -',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold ),
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return EditCulinary(
                      isUpdating: true,
                    );
                  }),
                );
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
                deleteTourism(accNoCulinaryNotifier.currenAccCulinaryList, _onTourismDeleted),
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
