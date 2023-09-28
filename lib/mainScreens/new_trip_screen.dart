// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sajiloshringar_app/models/user_service_request_information.dart';
// class NewTripScreen extends StatefulWidget
// {
//  UserserviceRequestInformation? userServiceRequestDetails;
//  NewTripScreen({this.userServiceRequestDetails,
// });
//
//   @override
//   State<NewTripScreen> createState() => _NewTripScreenState();
// }
//
// class _NewTripScreenState extends State<NewTripScreen>
// {
//   GoogleMapController? newTripGoogleMapController;
//   final Completer<GoogleMapController> _controllerGoogleMap = Completer();
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//      target: LatLng(37.42796133580664, -122.085749655962),
//      zoom: 14.4746,
//   );
//
//   String? buttonTitle = "Arrived";
//   Color? buttonColor = Colors.green;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//     children: [
//
//       //googlemap
//       GoogleMap(
//       mapType: MapType.normal,
//       myLocationEnabled: true,
//   initialCameraPosition: _kGooglePlex,
//   onMapCreated: (GoogleMapController controller)
//   {
//   _controllerGoogleMap.complete(controller);
//   newTripGoogleMapController = controller;
//   },
//
//   ),
//
//   //ui
//   Positioned(
//   bottom: 0,
//   left: 0,
//     right: 0,
//
//     child: Container(
//     decoration:const BoxDecoration(
//     color: Colors.black,
//     borderRadius: BorderRadius.only(
//     topLeft: Radius.circular(18),
//     ),
//   boxShadow:
//   [
//
//       BoxShadow(
//   color: Colors.white30,
//   blurRadius: 18,
//   spreadRadius: .5,
//   offset: Offset(0.6, 0.6),
//   ),
//   ],
//     ),
//   child: Column(
//   children: [
//     //duration
//      Text(
//     "18min",
//     style: TextStyle(
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
//   color: Colors.lightBlueAccent,
//
//   ),
//     ),
//
//   const SizedBox(height: 18,),
//
//   //user name icon
//   Row(
//   children: [
//     Text(
//   "user name",
//   style:const TextStyle(
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
//   color: Colors.lightBlueAccent,
//   ),
//   ),
//   Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Icon(
//     Icons.phone_android,
//     ),
//   ),
//   ],
//   ),
//
//   const SizedBox(height: 25,),
//
//   ElevatedButton.icon(
//           onPressed: ()
//   {
//
//   },
//   icon: const Icon(
//   Icons.directions_car,
//   color: Colors.white,
//   size: 25,
//   ),
//
//   label:Text(
//   "reached",
//   style: TextStyle(
//   color: Colors.white,
//   fontSize: 16,
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//
//
//
//
//   //user service location with icon
//
//   ),
//   ],
//   ),
//     ),
//   ),
//
//   ],
//     ),
//     );
//   }
// }
//
//
import 'dart:async';

import 'package:sajiloshringar_app/models/user_service_request_information.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import '../assistants/black_theme_google_map.dart';


class NewTripScreen extends StatefulWidget
{
  UserserviceRequestInformation? userServiceRequestDetails;

  NewTripScreen({
    this.userServiceRequestDetails,
  });

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}




class _NewTripScreenState extends State<NewTripScreen>
{
  GoogleMapController? newTripGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? buttonTitle = "Arrived";
  Color? buttonColor = Colors.green;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Stack(
        children: [

          //google map
          GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller)
            {
              _controllerGoogleMap.complete(controller);
              newTripGoogleMapController = controller;

              //black theme google map
            //  blackThemeGoogleMap(newTripGoogleMapController);
            },
          ),

          //ui
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                ),
                boxShadow:
                [
                  BoxShadow(
                    color: Colors.white30,
                    blurRadius: 18,
                    spreadRadius: .5,
                    offset: Offset(0.6, 0.6),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(
                  children: [

                    //duration
                    Text(
                      "18 mins",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreenAccent,
                      ),
                    ),

                    const SizedBox(height: 18,),

                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 8,),

                    //user name - icon
                    Row(
                      children: [
                        Text(
                          widget.userServiceRequestDetails!.userName!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreenAccent,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18,),

                    //user PickUp Address with icon
                  /*  Row(
                      children: [
                        Image.asset(
                          "images/origin.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 14,),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.userServiceRequestDetails!.originAddress!,
                              style: const TextStyle(
                               fontSize: 16,
                               color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/

                    const SizedBox(height: 20.0),

                    //user DropOff Address with icon
                  /*  Row(
                      children: [
                        Image.asset(
                          "images/destination.png",
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 14,),
                        Expanded(
                          child: Container(
                            child: Text(
                              widget.userServiceRequestDetails!.destinationAddress!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),*/

                    const SizedBox(height: 24,),

                    const Divider(
                      thickness: 2,
                      height: 2,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 10.0),

                    ElevatedButton.icon(
                      onPressed: ()
                      {

                      },
                      style: ElevatedButton.styleFrom(
                        primary: buttonColor,
                      ),
                      icon: const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
