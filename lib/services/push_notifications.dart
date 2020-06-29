import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:x/services/urllauncher.dart';


class Notifications {
 final FirebaseMessaging _fcm = FirebaseMessaging();

 Future initialise() async{
   if(Platform.isIOS){
     _fcm.requestNotificationPermissions(IosNotificationSettings());
   }

   _fcm.configure(
     onMessage: (Map<String, dynamic> message)async{
       print('onMessage: $message');
     },

     onLaunch: (Map<String, dynamic> message)async{
       print('onMessage: $message');
     },

     onResume: (Map<String, dynamic> message)async{
       print('onMessage: $message');
     },
   );

   _fcm.requestNotificationPermissions(
     const IosNotificationSettings(sound: true, badge: true, alert: true)
   );

   _fcm.getToken().then((token) {
     print(token);
     return token;
   });

}
}