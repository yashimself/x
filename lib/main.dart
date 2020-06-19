import 'package:flutter/material.dart';
import 'package:x/shared/loading.dart';
import 'services/sigin.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));


class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int i=5;

  @override
  Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: Colors.grey[600],
         appBar:AppBar(
           title: Text('Project X'),
           backgroundColor: Colors.grey[800],
           centerTitle: true,
           ),
             body: Center(
               child: Container(
           child:  RaisedButton(
             onPressed: ()  {
               Loading();
               entry();
               },
               child:
               Text('Enter'),
                 color: Colors.redAccent[100],
       ),
             ),
           ),
       );
  }
}
