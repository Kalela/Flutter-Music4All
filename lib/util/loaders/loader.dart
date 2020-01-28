import 'dart:math';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  final double initialRadius = 30;
  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animationRadiusOut = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.25, curve: Curves.elasticInOut)));
    
    _animationController.addListener((){
      setState(() {
        if(_animationController.value >= 0.75 && _animationController.value <= 1.0) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (_animationController.value >= 0.0 && _animationController.value <= 0.25) {
          radius = animationRadiusOut.value * initialRadius;
        }
      });
    });

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Center(
        child: Stack(
          children: <Widget>[
            Dot(30, Colors.blueGrey),
            Transform.translate(
              offset:
                  Offset(radius * cos(1 * pi / 4), radius * sin(1 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
            Transform.translate(
              offset:
                  Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
              child: Dot(5, Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot(this.radius, this.color);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
