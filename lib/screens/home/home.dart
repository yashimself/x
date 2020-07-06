import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:x/models/user.dart';
import 'package:x/screens/home/conversations.dart';
import 'package:x/screens/home/search.dart';
import 'package:x/services/auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:x/services/database.dart';
import 'package:x/services/push_notifications.dart';
import 'package:x/services/urllauncher.dart';
import 'package:x/shared/loading.dart';
import 'package:x/shared/skeleton.dart';
import 'package:x/services/sp.dart';
import 'package:x/shared/colors.dart';

bool isDarkMode = false;
String _secondname;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  DatabaseService databaseService = new DatabaseService();
  Stream chatRoomStream;
  String secondname;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomStream,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                      snapshot.data.documents[index].data["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data["chatroomId"],
                    );
                  }) : Container();
        });
  }

  @override
  void initState() {
    getuserinfo();
    
    super.initState();
  }

  getuserinfo() async {
    await Sp.getUsernamesharedpreference().then((value) {
      setState(() {
        Constants.myName = value;
      });
      databaseService.getChatrooms(Constants.myName).then((value) {
        setState(() {
          chatRoomStream = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
            isDarkMode ? 'assets/images/homebg.jpg' : 'assets/images/72.jpg'),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('X'),
          centerTitle: true,
          backgroundColor: isDarkMode ? Colors.black : Colors.black87,
          elevation: 5.0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: CircleAvatar(
                      radius: 80,
                      child: Text('IN PRODUCTION',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),),
                    )
                    
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        isDarkMode ? isDarkMode = false : isDarkMode = true;
                      });
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: isDarkMode
                            ? Text('Dark Mode Activated')
                            : Text('Dark Mode deactivated'),
                        duration: Duration(seconds: 1),
                      ));
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FlutterIcons.theme_light_dark_mco,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    label: Text(''),
                  ),
                  ListTile(
                    onTap: () {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Thanks for helping with the testing!'),
                        action: SnackBarAction(
                          label: 'Source Code',
                          onPressed: () {
                            launchURL();
                          },
                        ),
                        duration: Duration(seconds: 2),
                      ));
                      Navigator.pop(context);
                    },
                    title: Icon(
                      AntDesign.github,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: chatRoomList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            print(Constants.myName);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Search()));
          },
        ),
        /*Image(
      image: AssetImage("assets/wallp.jpg"),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),*/
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String chatRoomId;
  ChatRoomTile(this.username, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        secondname = username;
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ConversationScreen(
                ChatRoomId: chatRoomId,
                secondname: username,
                isDarkmode: isDarkMode,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Text(
                username.substring(0, 1).toUpperCase(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              username,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
