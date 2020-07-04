import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:x/models/user.dart';

class Notifications {
  final FirebaseMessaging fcm = FirebaseMessaging();
  final String uid;

  Notifications({this.uid});

  Future initialise() async {
    if (Platform.isIOS) {
      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
    );

    fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    fcm.getToken().then((token) async {
      print(token);
      //await updatetoken(token);
      return token;
    }).catchError((onError) {
      print(onError);
    });
  }
}

// Future updatetoken(String token) async {
//   print(User().getuid());
//   await Firestore.instance
//       .collection('users')
//       .document(User().getuid())
//       .updateData({'pushToken': token}).catchError((onError) {
//     print(onError);
//   });
// }
