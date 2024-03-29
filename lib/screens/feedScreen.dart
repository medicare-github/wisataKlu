import 'package:flutter/material.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/notifier/tourismNotifier.dart';
import 'package:newwisataklu/screens/NavigationScreen,.dart';
import 'package:newwisataklu/screens/homeScreen.dart';
import 'package:newwisataklu/screens/usersScreen/profileUser.dart';
import 'package:newwisataklu/screens/usersScreen/submision.dart';
import 'package:newwisataklu/screens/usersScreen/tourismUser.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _currentIndex = 0;
  bool currentLocation = false;

  @override
  void initState() {
    TourismNotifier tourismNotifier =
        Provider.of<TourismNotifier>(context, listen: false);
    getTourisms(tourismNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    String urlprof;
    String name = authNotifier.user.displayName;
    String firstCha = name[0];
    if (authNotifier.user.photoUrl != null) {
      urlprof = authNotifier.user.photoUrl;
    } else {
      urlprof =
          "https://png.pngtree.com/element_our/png_detail/20181102/avatar-profile-logo-vector-emblem-illustration-modern-illustration-png_227484.jpg";
    }

    print("building Feed");

    final tabs = [
      HomeScreen(),
      // Center(child: Text("navigation")),
      NavigationScreen(),
      // AddTourism(isUpdating: false),
      SubmisionScreen(),
      TourismUser(),
      ProfileUser(),
    ];

    return  Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        // fixedColor: Colors.blue,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.navigation,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.filter_hdr,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 2.0,
                  )
                ],
                color: Colors.amber,
              ),
              child: Center(
                child: Text(
                  firstCha.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            title: SizedBox.shrink(),
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    ) ;
  }
}
