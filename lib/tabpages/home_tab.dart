import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sajiloshringar_app/global/global.dart';

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

  Position? userCurrentPosition;
  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  String statusText = "Now offline";
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
    userCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 14 );

    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCoOrdinates(userCurrentPosition!,context);
    print("this is your address = " + humanReadableAddress);



  }
  @override
  void initState() {

    super.initState();
    checkIfLocationPermissionAllowed();

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
