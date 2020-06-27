import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:x/services/database.dart';
import 'package:x/shared/skeleton.dart';
import 'package:x/screens/home/conversations.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

String secondname = "";

class _SearchState extends State<Search> {



  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseService databaseService = new DatabaseService();

  QuerySnapshot searchsnapshot;
  bool haveUserSearched = false;


  initiateSearch() async{
    if(searchTextEditingController.text.isNotEmpty){
      await databaseService.dbDownstream(searchTextEditingController.text).then((val){
        setState(() {
          searchsnapshot = val;
          print(searchsnapshot);
          haveUserSearched = true;
        });
      });
    }
  }

  CreateChatRoomandStartconvo (String username){

    List<String> users = [username, Constants.myName];

    String chatRoomId = getChatRoomId(username, Constants.myName);
    Map<String, dynamic> chatRoomMap = {
      "users" : users,
      "chatroomId" : chatRoomId
    };
    DatabaseService().createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push (context, MaterialPageRoute(
        builder: (context) => ConversationScreen(
          ChatRoomId : chatRoomId
        )
    ));
  }



  Widget searchList(){
    return haveUserSearched ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchsnapshot.documents.length,
        itemBuilder: (context, index){
        return SearchTile(
          userName: searchsnapshot.documents[index].data["name"],
          userEmail: searchsnapshot.documents[index].data["email"],
        );
      }) : Container();
  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(userName,
                style: TextStyle(
                  //color: Color(),
                  fontSize: 18,
                ),
              ),
              Text(userEmail)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              setState(() {
                secondname = userName;
              });
              CreateChatRoomandStartconvo(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFa6dcef),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: Text('Message'),
            ),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        backgroundColor: Color(0xFFe36387),
      ),
      backgroundColor: Color(0xFFffd5e5),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              //color: Color(0xFFddf3f5),
              padding: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        decoration: InputDecoration(
                            fillColor: Color(0xFFffd5e5),
                            filled: true,
                            contentPadding: EdgeInsets.all(12.0),
                            hintText: 'Search',
                            hintStyle: TextStyle(color: Colors.black38 ),
                            border: InputBorder.none
                        ),
                      )
                  ),
                  SizedBox(width: 8,),
                  GestureDetector(
                    onTap: (){
                      databaseService.dbDownstream(searchTextEditingController.text).then((val){
                        initiateSearch();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFa6dcef),
                              const Color(0xFFddf3f5)
                            ]
                          ),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Icon(FlutterIcons.search1_ant,)
                    ),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

senduname(){
  return secondname;
}



getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}