import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingGps extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 300),
          child: Container(
            child: SpinKitCircle(
              color:  Colors.greenAccent,
              size: 80.0,
            ),
          ),
        ),
        Text("Please wait.. Check your Gps", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      ],
      ),
    );
  }
}