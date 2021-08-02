import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                Text(
                  'Home Screen'
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
