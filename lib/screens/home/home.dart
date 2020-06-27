import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:x/screens/home/search.dart';
import 'package:x/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:x/shared/skeleton.dart';
import 'package:x/services/sp.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth=AuthService();

  @override
  void initState() {
    getuserinfo();
    super.initState();
  }
  getuserinfo() async{
    await Sp.getUsernamesharedpreference().then((value){
      setState(() {
        Constants.myName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf2aaaa),
      appBar: AppBar(
        title: Text('X'),
        centerTitle: true,
        backgroundColor: Color(0xFFe36387),
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
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFa6dcef),
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
      ),
      body: Center(
        child: Text('Hello '+Constants.myName+"!",
        style: TextStyle(fontSize: 30,
        color: Color(0xFF222831),),
      ),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          print(Constants.myName);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Search()
          )
          );
        },
      ),
      /*Image(
        image: AssetImage("assets/wallp.jpg"),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),*/
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