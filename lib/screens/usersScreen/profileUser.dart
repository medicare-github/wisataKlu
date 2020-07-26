import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newwisataklu/api/tourism_api.dart';
import 'package:newwisataklu/notifier/authNotifier.dart';
import 'package:newwisataklu/screens/usersScreen/aboutApp.dart';
import 'package:newwisataklu/screens/usersScreen/allMyTourism.dart';
import 'package:provider/provider.dart';

class ProfileUser extends StatefulWidget {
  ProfileUser({Key key}) : super(key: key);

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    // String urlprof;
    // if (authNotifier.user.photoUrl != null) {
    //   urlprof = authNotifier.user.photoUrl;
    // } else {
    //   urlprof =
    //       "https://png.pngtree.com/element_our/png_detail/20181102/avatar-profile-logo-vector-emblem-illustration-modern-illustration-png_227484.jpg";
    // }
    String name = authNotifier.user.displayName;
    String firstCha = name[0].toUpperCase();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 120,
                      width: 120,
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
                          firstCha,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 80,
                          ),
                        ),
                      ),
                      // child: CircleAvatar(
                      //   radius: 70,

                      //   backgroundImage: NetworkImage(
                      //       authNotifier.user.photoUrl == null
                      //           ? urlprof
                      //           : authNotifier.user.photoUrl),
                      //   backgroundColor: Colors.black54,
                      //   child: Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Container(
                      //       height: 40,
                      //       width: 30,
                      //       decoration: BoxDecoration(
                      //         color: Colors.orange,
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.edit,
                      //         color: Colors.white,
                      //         size: 16,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      authNotifier.user.displayName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 0.5,
                    ),
                    Text(
                      authNotifier.user.email,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange),
                      child: GestureDetector(
                        onTap: () {
                          _showDialog(context);
                        },
                        child: Center(
                          child: Text(
                            "My Profile",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 15.0, left: 25, right: 25),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AllMyTourism();
                    }));
                  },
                  child: profileListItem(
                      icon: Icons.person_outline,
                      title: "All My Tourism",
                      color: Colors.white,
                      navigation: true),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AboutApp();
                    }));
                  },
                  child: profileListItem(
                      icon: Icons.info_outline,
                      title: "About App",
                      color: Colors.white,
                      navigation: true),
                ),
                GestureDetector(
                    onTap: () {
                      _showDialogLogout(context);
                    },
                    child: profileListItem(
                        icon: FontAwesomeIcons.powerOff,
                        title: "Logout",
                        color: Colors.white,
                        navigation: false)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _showDialog(BuildContext context) {
  AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('comming soon',style: TextStyle(color: Colors.grey,fontSize: 14),),
          ),
        );
      });
}

Future<void> _showDialogLogout(BuildContext context) {
  AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Center(child: Text('Are you Sure to Logout')),
            content: Container(
              height: 100,
              width: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      signout(authNotifier);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Click outside for cancel",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 11),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ));
      });
}

Widget profileListItem({icon, title, icon2, color, bool navigation = true}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(1, 72, 164, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  size: 24,
                  color: color,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: color,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          if (navigation)
            Icon(
              Icons.arrow_forward_ios,
              color: color,
            )
        ],
      ),
    ),
  );
}
