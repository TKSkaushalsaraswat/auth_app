import 'package:auth_app/menu_frame.dart';
import 'package:auth_app/splash.dart';
import 'package:flutter/material.dart';


class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  bool voxt = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (c, s) => s.connectionState != ConnectionState.done
          ? MaterialApp(
              home: Splash()
            )
          :
            MaterialApp(
            home:  MenuFrame()
            )
    );
  }
}
