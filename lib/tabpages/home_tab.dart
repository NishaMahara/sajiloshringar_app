import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sajiloshringar_app/global/global.dart';
import 'package:sajiloshringar_app/push_ontifications/push_notification_system.dart';


import '../assistants/assistant_methods.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}


class _HomeTabPageState extends State<HomeTabPage>
{
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  //

  Position? beauticianCurrentPosition;
  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  String statusText = "Go Online";
  Color buttonColor = Colors.green;
  bool isBeauticianActive = false;



  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if(_locationPermission == LocationPermission.denied)
    {
      _locationPermission = await Geolocator.requestPermission();
    }


  }

  locateBeauticianPosition() async
  {
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    beauticianCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(beauticianCurrentPosition!.latitude, beauticianCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14 );

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCoOrdinates(beauticianCurrentPosition!,context);
    print("this is your address = " + humanReadableAddress);




  }
 
 readCurrentBeauticianInformation() async
 {
  currentFirebaseUser = fAuth.currentUser;
  PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
  pushNotificationSystem.initializeCloudMessaging(context);
  pushNotificationSystem.generateAndGetToken();
 }
 
 
 
  @override
  void initState() {

    super.initState();
    checkIfLocationPermissionAllowed();

      readCurrentBeauticianInformation();
  }

  beauticianIsOnlineNow() async
  {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,

    );
    Geofire.initialize("activeBeauticians");
    Geofire.setLocation(currentFirebaseUser!.uid,
        beauticianCurrentPosition!.latitude,
        beauticianCurrentPosition!.longitude
    );
    DatabaseReference ref = FirebaseDatabase.instance.ref()
        .child("beauticians")
        .child(currentFirebaseUser!.uid)
    .child("newServiceStatus");

    ref.set("idle");//waiting for service request
    ref.onValue.listen((event) { });
  }
updateBeauticiansLocationAtRealTime()
{
  streamSubscriptionPosition = Geolocator.getPositionStream()
      .listen((Position position)
      {
        beauticianCurrentPosition = position;
        if(isBeauticianActive== true)
          {
            Geofire.setLocation(
                currentFirebaseUser!.uid, 
                beauticianCurrentPosition!.latitude,
                beauticianCurrentPosition!.longitude
            );
          }
        LatLng latLng  = LatLng(
          beauticianCurrentPosition!.latitude,
          beauticianCurrentPosition!.longitude,
        );
        newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));


      });
      }
      beauticiansIsOfflineNow() {
        Geofire.removeLocation(currentFirebaseUser!.uid);

        DatabaseReference? ref = FirebaseDatabase.instance.ref()
            .child("beauticians").child(currentFirebaseUser!.uid)
            .child("newServiceStatus");
        ref.onDisconnect();
        ref.remove();
        ref = null;

       // Future.delayed(const Duration(microseconds: 9000), () {
         //SystemNavigator.pop();
       // });
      }

 
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

    GoogleMap(
    mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller)
    {
    _controllerGoogleMap.complete(controller);
    newGoogleMapController = controller;
    locateBeauticianPosition();

         },

        ),
        //ui for online offline driver
        statusText!= "Now Online"
            ? Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.black,
        )

            : Container(),

        // button for driver online offline
        Positioned(
          top: statusText != "Now Online" ? MediaQuery.of(context).size.height *0.40
              : 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: ()
                  {
                    if(isBeauticianActive != true)//offline
                        {
                      beauticianIsOnlineNow();
                      updateBeauticiansLocationAtRealTime();
                      setState(() {
                        statusText = "Now Online";
                        isBeauticianActive = true;
                        buttonColor = Colors.green;
                      });
                      Fluttertoast.showToast(msg: "you are Online Now");
                    }
                    else
                      {
                        beauticiansIsOfflineNow();
                        setState(() {
                          statusText = "Go Online";
                          isBeauticianActive = false;
                          buttonColor = Colors.green;
                        });
                        Fluttertoast.showToast(msg: "you are Offline Now");
                      }
                    },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),

      child:statusText != "Now Online"
      ? Text(
        statusText,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
      )
        :  const Icon(
        Icons.phonelink_ring,
        color: Colors.white,
        size: 24,
      ),
              ),

            ],

          ),

        ),


      ],
    );
  }
}
