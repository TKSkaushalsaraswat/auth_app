import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                ),
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 360,
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF02AAB0),
                Color(0xff00CDAC),
              ]),
        ),
      ),
    );
  }
}
