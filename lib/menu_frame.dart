import 'package:auth_app/create_login.dart';
import 'package:auth_app/home_signin_widget.dart';
import 'package:auth_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MenuFrame extends StatelessWidget {
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
                Icon(
                  FontAwesomeIcons.tripadvisor,
                  size: 60,
                  color: Color.fromRGBO(245, 48, 111, 1.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TRAV',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(245, 48, 111, 1.0)),
                    ),
                    Text(
                      'ELLER',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  'The world is a book & those who do not travel read only a page.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60.0,
                ),
                Expanded(
                    child: PageView(
                  // physics: NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    HomeSignIn(
                      goToSignIn: () {
                        pageController.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      goToSignUp: () {
                        pageController.animateToPage(2,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    ),
                    SignIn(),
                    CreateLogin(
                      cancelBackToHome: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/tr.png"),
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
