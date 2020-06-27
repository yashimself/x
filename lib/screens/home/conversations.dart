import 'package:flutter/material.dart';
import 'package:x/screens/home/search.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:x/services/database.dart';
import 'package:x/shared/skeleton.dart';


class ConversationScreen extends StatefulWidget {
  final String ChatRoomId;
  ConversationScreen({this.ChatRoomId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DatabaseService databaseService = new DatabaseService();
  TextEditingController messageController = new TextEditingController();

  String secondname = "";
  @override
  void initState() {
    getsecondname();
    super.initState();
  }
  getsecondname (){
    setState(() {
      secondname = senduname();
    });
  }

  Widget ChatMessageList(){

  }

  sendMessage(){

    if(messageController.text.isNotEmpty){
      Map<String,String> messageMap = {
        "message" : messageController.text,
        "Sent by" : Constants.myName
      };
      databaseService.getMessages(widget.ChatRoomId, messageMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(secondname,),
        backgroundColor: Color(0xFF222831),
      ),
      backgroundColor: Color(0xFFa6dcef),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xFFddf3f5),
                padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              fillColor: Color(0xFFddf3f5),
                              filled: false,
                              contentPadding: EdgeInsets.all(12.0),
                              hintText: 'Message',
                              hintStyle: TextStyle(color: Colors.black38 ),
                            border: InputBorder.none
                          ),
                        )
                    ),
                    SizedBox(width: 8,),
                    Container(
                      width: 60,
                      height: 25,
                      child: FlatButton.icon(onPressed: (){
                        sendMessage();
                      },
                          icon: Icon(FlutterIcons.md_send_ion),
                          label: Text('',
                            style: TextStyle(
                                fontSize: 0
                            ),
                          )
                      ),
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
