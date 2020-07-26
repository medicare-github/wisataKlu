import 'package:flutter/material.dart';
import 'package:newwisataklu/notifier/accNoCulinaryNotifier.dart';
import 'package:newwisataklu/notifier/accNotifier.dart';
import 'package:newwisataklu/notifier/addCulinaryNotifier.dart';
import 'package:newwisataklu/notifier/addCultureNotifier.dart';
import 'package:newwisataklu/notifier/addNotifier.dart';
import 'package:newwisataklu/notifier/allMyTourismNotifier.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/notifier/culinaryNotifier.dart';
import 'package:newwisataklu/notifier/cultureNotifier.dart';
import 'package:newwisataklu/notifier/naturalNotifier.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';
import 'package:newwisataklu/screens/feedScreen.dart';
import 'package:newwisataklu/screens/loginPage.dart';
import 'package:newwisataklu/screens/usersScreen/allMyTourism.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => TourismNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => NaturalTourismNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CultureTourismNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CulinaryTourismNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddCultureNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddCulinaryeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AccNoCulinaryNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllMyTourismNotifier(),
        ),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Lombok Utara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7)),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? FeedScreen() : Login();
        },
      ),
    );
  }
}
