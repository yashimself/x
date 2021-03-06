import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:x/services/database.dart';
import 'package:x/shared/loading.dart';
import 'package:x/shared/constants.dart';
import 'package:x/services/auth.dart';
import 'package:x/services/sp.dart';
import 'package:x/screens/authenticate/signinwithphonenumber.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  DatabaseService databaseService = new DatabaseService();

  //text field state

  String email = '';
  String password = '';
  String error = '';
  QuerySnapshot Userinfo;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/homebg.jpg'),
              fit: BoxFit.cover,
            )),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black87,
                elevation: 0.0,
                title: Text('Sign in', style: TextStyle(color: Colors.white)),
                actions: [
                  FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person, color: Colors.white),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'X',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40.0,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                hintText: 'Email',
                              ),
                              validator: (val) {
                                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(val) ||
                                        val.isNotEmpty
                                    ? null
                                    : 'Enter an email';
                              },
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              validator: (val) => val.length < 6
                                  ? 'Enter a password with more than 6 characters'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: FlatButton(
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (email != '') {
                                      setState(() {
                                        loading = true;
                                      });

                                      dynamic result =
                                          await _auth.forgotpass(email);

                                      if (result == 1) {
                                        setState(() {
                                          error =
                                              'Something went wrong. Please try again.';
                                          loading = false;
                                        });
                                      } else {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            RaisedButton(
                                splashColor: Colors.white,
                                color: Colors.black87,
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });

                                    await databaseService
                                        .dbDownstreamEmail(email)
                                        .then((val) {
                                      Userinfo = val;
                                      Sp.saveUsernamesharedpreference(
                                          Userinfo.documents[0].data["name"]);
                                      Sp.saveUserEmailsharedpreference(email);
                                    });
                                    dynamic result =
                                        await _auth.SigninwithEmailandPass(
                                            email, password);
                                    if (result == null) {
                                      if (this.mounted) {
                                        setState(() {
                                          error =
                                              ' Please use valid email and password ';
                                          loading = false;
                                        });
                                      }
                                      loading = false;
                                    } else {
                                      Sp.saveUserLoggedinpreference(true);
                                      loading = false;
                                    }
                                  }
                                }),
                            SizedBox(
                              height: 8,
                            ),
                            // RaisedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       PageRouteBuilder(
                            //         pageBuilder: (context, animation,
                            //         secondaryAnimation) =>signinwithphonenumber(),
                            //         transitionsBuilder: (context, animation,
                            //             secondaryAnimation, child) {
                            //           var begin = Offset(0.0, 1.0);
                            //           var end = Offset.zero;
                            //           var curve = Curves.ease;

                            //           var tween = Tween(begin: begin, end: end)
                            //               .chain(CurveTween(curve: curve));

                            //           return SlideTransition(
                            //             position: animation.drive(tween),
                            //             child: child,
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   },
                            //   splashColor: Color(0xFFc7e2b2),
                            //   color: Color(0xFFe1ffc2),
                            //   child: Text(
                            //     'Sign in with Phone number',
                            //     style: TextStyle(
                            //       color: Color(0xFF222831),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(error,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ))
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
