import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sajiloshringar_app/global/global.dart';

class PushNotificationSystem

{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future initializeCloudMessaging() async
  {
    //1.terminated

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //display service request information = user information who has basically requested
      }
    });

    //2.foreground
    //whaen app is open and it receive the push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
//display service request information = user information who has basically requested
    });


    //3.background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      //display service request information = user information who has basically requested

    });
  }
  Future generateAndGetToken() async
  {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token: ");
    print(registrationToken);


    FirebaseDatabase.instance.ref()
        .child("beauticians")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);
    messaging.subscribeToTopic("allBeauticians");
    messaging.subscribeToTopic("allUsers");
  }
}

