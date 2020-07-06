import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:x/models/user.dart';
import 'package:x/services/auth.dart';

class Notifications {
  final String uid;
  final FirebaseMessaging fcm = FirebaseMessaging();
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
      await updatetoken(token,uid);
      return token;
    }).catchError((onError) {
      print(onError);
    });
  }
}

Future updatetoken(String token, String uid) async {
  await Firestore.instance
      .collection('users')
      .document(uid)
      .updateData({'pushToken': token}).catchError((onError) {
    print(onError);
  });
}
