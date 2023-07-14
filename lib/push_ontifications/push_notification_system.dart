

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sajiloshringar_app/global/global.dart';
import 'package:sajiloshringar_app/models/user_service_request_information.dart';
import 'package:sajiloshringar_app/push_ontifications/notification_dialog_box.dart';

class PushNotificationSystem

{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future initializeCloudMessaging(BuildContext context) async
  {
    //1.terminated

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //display service request information = user information who has basically requested

        readUserserviceRequestInformation(remoteMessage.data["serviceRequestId"], context);
      }
    });

    //2.foreground
    //whaen app is open and it receive the push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
//display service request information = user information who has basically requested

      readUserserviceRequestInformation(remoteMessage!.data["serviceRequestId"], context);
    });


    //3.background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      //display service request information = user information who has basically requested

      readUserserviceRequestInformation(remoteMessage!.data["serviceRequestId"], context);

    });
  }

  readUserserviceRequestInformation(String userserviceRequestId, BuildContext context)
  {
    FirebaseDatabase.instance.ref()
        .child("All Service Requests").child(userserviceRequestId)
        .once()
        .then((snapData)
    {
      if(snapData.snapshot.value != null) {
        double AddressLat = double.parse((snapData.snapshot.value! as Map)["Address"]["latitude"].toString());
        double AddressLng = double.parse((snapData.snapshot.value! as Map)["Address"]["longitude"].toString());
        String selected_service = (snapData.snapshot.value! as Map)["selected_service"];
        String userAddress = (snapData.snapshot.value! as Map)["userAddress"];
        String beauticianId = (snapData.snapshot.value! as Map)["beauticianId"];
        String userName = (snapData.snapshot.value! as Map)["userName"];
        String userPhone = (snapData.snapshot.value! as Map)["userPhone"];


        //instance of userservicerequestinfo
        UserserviceRequestInformation userserviceRequestDetails = UserserviceRequestInformation();
        userserviceRequestDetails.AddressLatLang =
            LatLng(AddressLat, AddressLng);
        //userserviceRequestDetails.
        userserviceRequestDetails.selected_service = selected_service;
        userserviceRequestDetails.beauticianId = beauticianId;
        userserviceRequestDetails.userName = userName;
        userserviceRequestDetails.userPhone = userPhone;
        userserviceRequestDetails.userAddress  = userAddress;

        showDialog(
            context: context,
            builder: (BuildContext context) => NotificationDialogBox(
                userserviceRequestDetails: userserviceRequestDetails,
            ),

        );
      }


        //home address code

      else
      {
        Fluttertoast.showToast(msg: "This service Request Id don not exist.");
      }
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

