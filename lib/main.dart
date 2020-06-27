import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:x/models/user.dart';
import 'package:x/screens/wrapper.dart';
import 'package:x/services/auth.dart';
import 'package:x/services/sp.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //bool isLoggedin = ;

  @override
  void initState() {

    super.initState();
  }

  getUserLoggedinsharedpreference() async {
    await Sp.getUserLoggedinpreference().then((val){

    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
      );

  }
}

