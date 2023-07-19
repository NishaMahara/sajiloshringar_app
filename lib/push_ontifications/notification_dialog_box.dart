import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sajiloshringar_app/global/global.dart';

import '../models/user_service_request_information.dart';

class NotificationDialogBox extends StatefulWidget
{
  UserserviceRequestInformation? userserviceRequestDetails;
  NotificationDialogBox({this.userserviceRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox>

{
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),

      ),
      backgroundColor: Colors.transparent,
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "images/logo1.png",
              width: 160,
          height: 16,
            ),
            const SizedBox(height: 2,),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [

           const Text(
             "New Service Request",
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 22,
             ),
           ),

           const SizedBox(width: 10.0,),

           Icon
             (
             Icons.home,
             size: 45,
           ),
         ],
       ),

            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  //home icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(

                        children: [
                         /* Icon(
                            Icons.home,

                            // Replace 'Icons.home' with your custom icon data
                            size: 55,
                          ),*/
                          // Other widgets in the Row
                        ],
                      ),
                     /* Image.asset(
                        "image/logo1.png",
                        width: 16,
                        height: 16,
                      ),*/
                  // const SizedBox(width: 1,),
                   Text(

                     widget.userserviceRequestDetails!.userAddress!,
                     style: const TextStyle(
                       fontSize: 15,
                       color: Colors.black,


                     ),
                   ),
                    ],
                  ),

          const SizedBox(height: 11.0),
                //service

                  Row(
                    children: [

                      const SizedBox(width: 1,),
                      Text(

                      'service:${widget.userserviceRequestDetails!.selected_service!}',
                        style: const TextStyle(
                          fontSize: 18,



                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                primary:Colors.red.shade300,
            ),
                  onPressed: () {
                    //cancel service request
                    Navigator.pop(context);
                  },
                  child: const Text(
                      "Cancel",
                      style:const TextStyle(
                        fontSize: 14.0,

                      )
                  ),
                ),

                const SizedBox(width: 25.0),

                ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary:Colors.green,
             ),
                  onPressed: () {
                    //accept service request
                       acceptserviceRequest(context);
                  },
                  child: const Text(
                      "Accept",
                      style:const TextStyle(
                        fontSize: 14.0,

                      )
                  ),
                ),
              ],
            )
          ],
        )
      ),

    );
  }
  acceptserviceRequest(BuildContext context)
  {
    String getservideRequestId="";
  FirebaseDatabase.instance.ref()
      .child("beauticians")
      .child(currentFirebaseUser!.uid)
      .child("newServiceStatus")
      .once()
      .then((snap)
  {
      if(snap.snapshot.value != null)
      {
        getservideRequestId = snap.snapshot.value.toString();
      }
        else {
Fluttertoast.showToast(msg: "this service request do not exist");
      }

       if(getservideRequestId == widget.userserviceRequestDetails!.serviceRequestId)

{
  FirebaseDatabase.instance.ref()
      .child("beauticians")
      .child(currentFirebaseUser!.uid)
      .child("newServiceStatus")
      .set("accepted");
 // Navigator.push(context, MaterialPageRoute(builder: (c)=> NewServiceScreen()));
//send Beautician to new service request screen
}
       else {
         Fluttertoast.showToast(msg: "this request do not exist");
       }
  });
  }
}


