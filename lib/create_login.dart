import 'package:auth_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateLogin extends StatefulWidget {
  final Function cancelBackToHome;

  CreateLogin({this.cancelBackToHome});

  @override
  _CreateLoginState createState() => _CreateLoginState();
}

class _CreateLoginState extends State<CreateLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email, password, confirmPassword;
  bool _termAgreed = false;
  bool saveAttempt = false;
  final formKey = GlobalKey<FormState>();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _createUser({String email, String pwd}) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pwd)
        .then((authResult) =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return MaterialApp(home: Home());
            })))
        .catchError((err) => {
              print(err.code),
              if (err.code == 'email-already-in-use')
                {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text(
                            'This email already has an account associated with it',
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            'CREATE YOUR ACCOUNT',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          TextFormField(
            autovalidate: saveAttempt,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: (emailValue) {
              if (emailValue.isEmpty) {
                return 'This field is mandatory';
              }

              if (!validateEmail(emailValue)) {
                return 'This is not a valid email';
              }

              return null;
            },
            decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                hintText: 'Enter Email',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                ),
                focusColor: Colors.white),
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          SizedBox(height: 20),
          TextFormField(
            autovalidate: saveAttempt,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            validator: (pwdValue) {
              if (pwdValue.isEmpty) {
                return 'This field is mandatory';
              }
              if (pwdValue.length < 8) {
                return 'Password must be atleast 8 characters';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.white),
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
          TextFormField(
            autovalidate: saveAttempt,
            onChanged: (value) {
              setState(() {
                confirmPassword = value;
              });
            },
            validator: (pwdConfirmValue) {
              if (pwdConfirmValue != password) {
                return 'Password must match';
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                hintText: 'Re-Enter Password',
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
                  value: _termAgreed,
                  onChanged: (newValue) {
                    setState(() {
                      _termAgreed = newValue;
                    });
                  }),
              Text(
                'Agreed to Terms & Conditions',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  widget.cancelBackToHome();
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    saveAttempt = true;
                  });
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    _createUser(email: email, pwd: password);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Agree to Terms & Conditions',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
