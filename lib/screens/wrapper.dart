import 'package:flutter/material.dart';
import 'package:x/screens/authenticate/authenticate.dart';
import 'package:x/screens/home/home.dart';
import 'package:x/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User>(context);

    if(user==null)
      return authenticate();
    else
      return Home();

   /* return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child:InkWell(
                child: FlatButton.icon(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Wrapper()),
                    );
                  },
                  icon: Icon(FlutterIcons.door_open_mco),
                  label: Text('Get in',
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),

                ),
              ),
            )
          ]
      ),

      appBar: AppBar(
        title: Text('X',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.fromLTRB(0.0,0.0,10.0,0.0),
              child: FlatButton.icon(onPressed: (){
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Thanks for helping with the testing!'),
                  action: SnackBarAction(
                    label: 'Source Code',
                    onPressed: () {
                      _launchURL();
                    },
                  ),
                  duration: Duration(seconds: 1),
                ));
              },
                icon: Icon(AntDesign.github,
                  color: Colors.white,
                ),
                label: Text(''),
              ),
            ),
          )],



      ),

    );*/


  }
}