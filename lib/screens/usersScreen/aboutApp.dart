import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 180, 10, 30),
              child: Center(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 40,
                  child: Image.asset(
                    "assets/icon.png",
                    width: 300,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text("nort lombok tourism application", style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),),
                  SizedBox(height: 20,),
                  Text("Developer by Medicare", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.blue[300]),),
                  SizedBox(height: 4,),
                  Text("Email : Mcareducation@gmail.com", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.black87),),
                  SizedBox(height: 30,),
                  Text("framework flutter user dart" ,style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.black87)),
                  SizedBox(height: 2,),
                  Image.asset("assets/dart.jpg", width: 100,)
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
