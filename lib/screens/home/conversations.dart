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

  Stream chatMessageStream;
  DatabaseService databaseService = new DatabaseService();
  TextEditingController messageController = new TextEditingController();

  String secondname = "";

  getsecondname () {
     setState(() {
      secondname = senduname();
    });
  }

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(snapshot.data.documents[index].data["message"],
                  snapshot.data.documents[index].data["Sent_by"]==Constants.myName);
            }) : Container();
      },
    );
  }

  sendMessage(){

    if(messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap = {
        "Sent_by" : Constants.myName,
        "message" : messageController.text,
        "time" : DateTime.now().millisecondsSinceEpoch
      };
      DatabaseService().addMessages(widget.ChatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    DatabaseService().getMessages(widget.ChatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    getsecondname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(secondname,),
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Color(0xFF222831),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color.fromRGBO(0xFFdd,0xFFf3,0xFFf5,0.5),
                padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              fillColor: Color.fromRGBO(0xFFdd,0xFFf3,0xFFf5,0.5),
                              filled: false,
                              contentPadding: EdgeInsets.all(12.0),
                              hintText: 'Message',
                              hintStyle: TextStyle(color: Colors.black38 ),
                            border: InputBorder.none
                          ),
                        )
                    ),

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

class MessageTile extends StatelessWidget {

  final String message;
  MessageTile(this.message,this.isSentByMe);
  final bool isSentByMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSentByMe ? 0 : 20, right: isSentByMe ? 20 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.amberAccent : Colors.blue,
          borderRadius: isSentByMe ? BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)
          ) : BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          )
        ),
        child: Text(message,
        style: TextStyle(
          color: isSentByMe ? Colors.black87 : Colors.white,
          fontSize: 15
        ),
        ),
      ),
    );
  }
}

