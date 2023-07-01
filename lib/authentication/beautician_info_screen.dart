import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sajiloshringar_app/global/global.dart';
import 'package:sajiloshringar_app/splashScreen/splash_screen.dart';
class BeauticianInfoScreen extends StatefulWidget
{


  @override
  State<BeauticianInfoScreen> createState() => _BeauticianInfoScreenState();
}

class _BeauticianInfoScreenState extends State<BeauticianInfoScreen>
{

  TextEditingController BeauticianNameEditingController = TextEditingController();
  TextEditingController BeauticianEmailTextEditingController = TextEditingController();
  TextEditingController BeauticianAddressTextEditingController = TextEditingController();

   saveBeauticianInfo()
   {
     Map beauticianInfoMap =
     {
       "Beautician_name": BeauticianNameEditingController.text.trim(),
       "Beautician_email": BeauticianEmailTextEditingController.text.trim(),
       "Beautician_address": BeauticianAddressTextEditingController.text.trim(),


     };

     DatabaseReference beauticiansRef = FirebaseDatabase.instance.ref().child("beauticians");
     beauticiansRef.child(currentFirebaseUser!.uid).child("beautician_details").set(beauticianInfoMap);
     Fluttertoast.showToast(msg: "Congratulations!Beautician Information has been saved.");
     Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

   }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(

                children: [

                  const SizedBox(height: 24,),

                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset("images/logo1.png"),
                  ),
                  const SizedBox(height: 10,),
                  const Text(
                    "Beautician Details ",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  TextField(
                    controller: BeauticianNameEditingController,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration:  const InputDecoration(
                        labelText: "Name",
                        hintText: "Name",

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )
                    ),

                  ),
                  TextField(
                    controller: BeauticianEmailTextEditingController,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration:  const InputDecoration(
                        labelText: "Email",
                        hintText: "abc@gmail.com",

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )
                    ),

                  ),
                  TextField(
                    controller: BeauticianAddressTextEditingController,

                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration:  const InputDecoration(
                        labelText: "Address",
                        hintText: "Address",

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.grey),
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )
                    ),

                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
    if (BeauticianNameEditingController.text.isNotEmpty && BeauticianEmailTextEditingController.text.isNotEmpty && BeauticianAddressTextEditingController.text.isNotEmpty )
    {
    saveBeauticianInfo();
    }
    },

      style: ElevatedButton.styleFrom(
             backgroundColor: Colors.lightGreenAccent,
                    ),
                    child:const Text(
                      "save Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}
