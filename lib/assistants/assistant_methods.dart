import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sajiloshringar_app/assistants/request_assistant.dart';
import 'package:sajiloshringar_app/infoHandler/app_info.dart';

import '../global/global.dart';
import '../global/map_key.dart';
import '../models/directions.dart';
import '../models/user_model.dart';
import 'package:provider/provider.dart';



class AssistantMethods {
  static Future<String> searchAddressForGeographicCoOrdinates(Position position, context) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress="";

    var requestResponse = await RequestAssistant.receiveRequest(apiUrl);

    if(requestResponse != "Error Occurred, Failed. No Response.")
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];

    {
      Directions userHomeAddress = Directions();
      userHomeAddress.locationLatitude = position.latitude;
      userHomeAddress.locationLongitude = position.longitude;
      userHomeAddress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false).updateHomeLocationAddress(userHomeAddress);

    }

    return humanReadableAddress;
  }

  static readCurrentOnlineUserInfo() async
  {
    {
      currentFirebaseUser = fAuth.currentUser;
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(currentFirebaseUser!.uid);
      userRef.once().then((snap) {
        if (snap.snapshot.value != null)
        {
          userModelCurrentInfo=UserModel.fromSnapshot(snap.snapshot);

        }
      });
    }
  }
}
