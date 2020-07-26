import 'package:flutter/material.dart';
import 'package:newwisataklu/screens/feedScreen.dart';

class ResultUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 240, 10, 0),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/send.png"),
                              fit: BoxFit.fill)),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Submision Success",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Your tourism will be check for accepted",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedScreen()),
                    );
                  },
                  highlightElevation: 0,
                  focusElevation: 0,
                  splashColor: Colors.white.withOpacity(0.1),
                  padding: EdgeInsets.fromLTRB(20, 17, 20, 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue[700],
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
