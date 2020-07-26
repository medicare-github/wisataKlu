import 'dart:math';

import 'package:flutter/material.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  AnimationController loadcontroller;

  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initialRadius = 30.0;
  double radius = 0.0;

  @override
  void initState() {
    super.initState();
    loadcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: loadcontroller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: loadcontroller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: loadcontroller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticInOut)));

    loadcontroller.addListener(() {
      setState(() {
        if (loadcontroller.value >= 0.75 && loadcontroller.value <= 1.0) {
          radius = animation_radius_in.value * initialRadius;
        } else if (loadcontroller.value >= 0.0 && loadcontroller.value <= 0.25) {
          radius = animation_radius_out.value * initialRadius;
        }
      });
    });
    loadcontroller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                color: Colors.black12,
                radius: 30.0,
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                child: Dot(
                  color: Colors.greenAccent,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                child: Dot(
                  color: Colors.redAccent,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                child: Dot(
                  color: Colors.blueAccent,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                child: Dot(
                  color: Colors.purple,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                child: Dot(
                  color: Colors.amberAccent,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                child: Dot(
                  color: Colors.blue,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                child: Dot(
                  color: Colors.orange,
                  radius: 5.0,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                child: Dot(
                  color: Colors.lightBlue,
                  radius: 5.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
