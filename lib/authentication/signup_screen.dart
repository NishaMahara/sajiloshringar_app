import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sajiloshringar_app/Widgets/progress_dialog.dart';

import 'package:sajiloshringar_app/authentication/beautician_info_screen.dart';
import 'package:sajiloshringar_app/global/global.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
//validation of login page

  validateForm()
  {
    if (nameTextEditingController.text.length < 3)
    {
          Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
        }
        else if (!emailTextEditingController.text.contains("@"))
        {
          Fluttertoast.showToast(msg: "Email address is not valid.");
        }
        else if (phoneTextEditingController.text.isEmpty) {
          Fluttertoast.showToast(msg: "phone number is required.");
        }
        else if (passwordTextEditingController.text.length < 6) {
          Fluttertoast.showToast(msg: "password must be atleast 5 characters.");
        }
        else
        {
          saveBeauticianInfoNow();

        }
      }

      saveBeauticianInfoNow() async
      {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext c)
            {
              return ProgressDialog(message: "Processing, Please wait...",);
              }
        );
        final User? firebaseUser =
            (
            await fAuth.createUserWithEmailAndPassword(

              email: emailTextEditingController.text.trim(),
              password: passwordTextEditingController.text.trim(),
            ).catchError((msg){
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Error: " + msg.toString());
            })
        ).user;
        if(firebaseUser != null)

        {
          Map BeauticianMap =
          {
            "id":firebaseUser.uid,
            "name": nameTextEditingController.text.trim(),
            "email": nameTextEditingController.text.trim(),
            "phone": nameTextEditingController.text.trim(),

          };
          DatabaseReference beauticiansRef = FirebaseDatabase.instance.reference().child("beautician");
          beauticiansRef.child(firebaseUser.uid).set(BeauticianMap);

          // currentfirebaseUser = firebaseUser;firebaseUserz


        }
        else
        {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Account has not been created.");
        }
      }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo1.png"),
              ),
              const SizedBox(height: 10,),
              Text(
                "Register as Beautician ",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,

                ),
              ),

              TextField(
                controller: nameTextEditingController,
                style: TextStyle(
                    color: Colors.grey
                ),
                decoration:  const InputDecoration(
                    labelText: "Name",
                    hintText: "Nisha Mahara",

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
                      color: Colors.grey,
                      fontSize: 16,
                    )
                ),

              ),
              TextField(
                controller: emailTextEditingController,
                style: TextStyle(
                    color: Colors.grey
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
                      color: Colors.grey,
                      fontSize: 16,
                    )
                ),

              ),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    color: Colors.grey
                ),
                decoration:  const InputDecoration(
                    labelText: "Phone",
                    hintText: "9846111111",

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
                      color: Colors.grey,
                      fontSize: 16,
                    )
                ),

              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.grey
                ),
                decoration:  const InputDecoration(
                    labelText: "Password",
                    hintText: "*********",

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
                      color: Colors.grey,
                      fontSize: 16,
                    )
                ),

              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: ()
                {
                  validateForm();

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child:const Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),


            ],

          ),
        ),

      ),


    );
  }
}

