import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x/screens/home/search.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:x/services/database.dart';
import 'package:x/shared/colors.dart';
import 'package:x/shared/loading.dart';
import 'package:x/shared/skeleton.dart';
import 'package:x/screens/home/home.dart';

class ConversationScreen extends StatefulWidget {
  final String ChatRoomId;
  final String secondname;
  bool isDarkmode;
  ConversationScreen({this.ChatRoomId, this.secondname, this.isDarkmode});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  Stream chatMessageStream;
  DatabaseService databaseService = new DatabaseService();
  TextEditingController messageController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    snapshot.data.documents[index].data["message"],
                    snapshot.data.documents[index].data["Sent_by"] ==
                        Constants.myName,
                    snapshot.data.documents[index].data["time"],
                  );
                })
            : Loading();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "Sent_by": Constants.myName,
        "message": messageController.text,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      DatabaseService().addMessages(widget.ChatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseService().getMessages(widget.ChatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 1),
        () => _scrollController.animateTo(
              0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            ));
    return Scaffold(
      appBar: AppBar(
        title: Text(secondname),
        centerTitle: true,
        backgroundColor: Colors.black87,
        actions: [
          FlatButton.icon(
              onPressed: () {
                AlertDialog(actions: [
                  Text('Soon!'),
                ]);
              },
              icon: Icon(FlutterIcons.info_circle_faw, color: Colors.white),
              label: Text(''))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(isDarkMode
                  ? 'assets/images/dm.jpg'
                  : 'assets/images/wallpaper.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 55),
              child: ChatMessageList(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(Asthetic.nightconvobg),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: messageController,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      decoration: InputDecoration(
                          filled: false,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(12.0),
                          hintText: 'Message',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none),
                    )),
                    Container(
                      width: 60,
                      height: 25,
                      child: FlatButton.icon(
                          onPressed: () {
                            sendMessage();
                          },
                          icon: Icon(
                            FlutterIcons.md_send_ion,
                            color: Colors.white,
                          ),
                          label: Text(
                            '',
                            style: TextStyle(fontSize: 0),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  MessageTile(this.message, this.isSentByMe, this.time);
  final bool isSentByMe;
  int time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSentByMe ? 10 : 10, right: isSentByMe ? 8 : 8),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: isSentByMe ? Color(0xFF17706e) : Colors.blue,
            borderRadius: isSentByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
        child: Text(
          message,
          style: TextStyle(
              color: isSentByMe ? Colors.white : Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
