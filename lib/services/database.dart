import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x/models/user.dart';
import 'package:x/services/push_notifications.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  dbDownstream(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  dbDownstreamEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  dbUpstream(Map userMap) {
    Firestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String ChatRoomid, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(ChatRoomid)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addMessages(String ChatroomId, MessageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(ChatroomId)
        .collection("chats")
        .add(MessageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getMessages(String ChatroomId) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(ChatroomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatrooms(String username) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: username)
        .snapshots();
  }

  
}
