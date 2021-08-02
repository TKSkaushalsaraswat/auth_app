import 'package:auth_app/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password;
  bool _rememberPassword = false;

  void _signIn({String email, String pwd}) {
    _auth
        .signInWithEmailAndPassword(email: email, password: pwd)
        .then(
          (authResult) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MaterialApp(home: Home());
              },
            ),
          ),
        )
        .catchError((err) => {
              print(err.code),
              if (err.code == 'wrong-password')
                {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'The password or email are wrong please try again!',
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      })
                },
              if (err.code == 'user-not-found')
                {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'The password or email are wrong please try again!',
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'LOG IN',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          TextFormField(
            onChanged: (value) {
              email = value;
            },
            validator: (emailValue) {
              if (emailValue.isEmpty) {
                return 'This Field is mandatory';
              }
              return null;
            },
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Enter Username',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
                focusColor: Colors.white),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          SizedBox(height: 20),
          TextFormField(
            onChanged: (value) {
              password = value;
            },
            validator: (passwordValue) {
              if (passwordValue.isEmpty) {
                return 'This Field is mandatory';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
                focusColor: Colors.white),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  activeColor: Colors.orange,
                  value: _rememberPassword,
                  onChanged: (newValue) {
                    setState(() {
                      _rememberPassword = newValue;
                    });
                  }),
              Text(
                'Remember Password',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              _signIn(email: email, pwd: password);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.red,
                  )),
              SizedBox(
                width: 40,
              ),
              Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.red,
                  )),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'FORGOT PASSWORD?',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }
}
