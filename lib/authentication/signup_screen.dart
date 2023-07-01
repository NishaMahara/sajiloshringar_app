import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sajiloshringar_app/Widgets/progress_dialog.dart';

import 'package:sajiloshringar_app/authentication/beautician_info_screen.dart';
import 'package:sajiloshringar_app/authentication/login_screen.dart';
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

  validateForm() {
    if (nameTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "name must be atleast 6 Characters.");
    }
    else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    }
    else if (phoneTextEditingController.text.length<10) {
      Fluttertoast.showToast(msg: "phone number should be of 10 digits.");
    }
    else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "password must be atleast 5 characters.");
    }
    else {
      saveBeauticianInfoNow();
    }
  }
  saveBeauticianInfoNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
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
    if(firebaseUser != null) {
      Map beauticianMap =
      {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "password":passwordTextEditingController.text.trim(),


      };
      DatabaseReference beauticiansRef = FirebaseDatabase.instance.ref().child("beauticians");
      beauticiansRef.child(firebaseUser.uid).set(beauticianMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg:"Account has been Created.");
       Navigator.push(context, MaterialPageRoute(builder: (c)=> BeauticianInfoScreen()));
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
      backgroundColor: Colors.white,
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,

                ),
              ),

              TextField(
                controller: nameTextEditingController,
                style: TextStyle(
                    color: Colors.black
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
                      color: Colors.black,
                      fontSize: 16,
                    )
                ),

              ),
              TextField(
                controller: emailTextEditingController,
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    color: Colors.black
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
                      color: Colors.black,
                      fontSize: 16,
                    )
                ),

              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: TextStyle(
                    color: Colors.black
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
                      color: Colors.black,
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
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  "Already have an Account? Login Here",
                  style: TextStyle(color: Colors.brown),
                ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                  },
              ),
            ],

          ),
        ),

      ),


    );
  }
}

