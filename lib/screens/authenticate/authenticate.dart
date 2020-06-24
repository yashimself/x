import 'package:flutter/material.dart';
import 'package:x/screens/authenticate/register.dart';
import 'package:x/screens/authenticate/signin.dart';

// ignore: camel_case_types
class authenticate extends StatefulWidget {
  @override
  _authenticateState createState() => _authenticateState();
}

// ignore: camel_case_types
class _authenticateState extends State<authenticate> {

  bool showsignin = true;

  void toggleView()
  {
    setState(() {
      showsignin = !showsignin;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(showsignin)
      return SignIn(toggleView: toggleView,);
    else
      return Register(toggleView: toggleView);
  }
}
