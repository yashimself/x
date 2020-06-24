import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:x/models/user.dart';
import 'package:x/screens/wrapper.dart';
import 'package:x/services/auth.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));


class MyApp extends StatelessWidget {

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

