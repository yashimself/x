import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:x/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';


class Home extends StatelessWidget {
  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('X'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 5.0,
        actions: [
          FlatButton.icon(
            onPressed: () async{
              await _auth.signOut();
            },
            icon: Icon(Icons.person,color: Colors.white,),
            label: Text('Logout',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
          ),



          /*FlatButton.icon(
              icon: Icon(Icons.edit),
              onPressed: (){
                return _showSettingsPanel();
              },
              label: Text('Edit'),
          ),*/




        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
         Builder(
        builder:(context) => FlatButton.icon(
      icon: Icon(
      AntDesign.github,
        color: Colors.black,
      ),
      label: Text(''),
      onPressed: (){
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
      Navigator.pop(context);
      },

    )
        ),

        ]
        ),
      ),
      body: Image(
        image: AssetImage("assets/wallp.jpg"),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://github.com/yashimself/x';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}