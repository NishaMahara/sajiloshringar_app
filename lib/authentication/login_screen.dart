import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sajiloshringar_app/Widgets/progress_dialog.dart';
import 'package:sajiloshringar_app/authentication/signup_screen.dart';
import 'package:sajiloshringar_app/global/global.dart';
import 'package:sajiloshringar_app/mainScreens/main_screen.dart';
import 'package:sajiloshringar_app/splashScreen/splash_screen.dart';
import 'package:sajiloshringar_app/tabpages/home_tab.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm()
  {
    if(!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    }

    else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill the password");
    }
    else {
      LoginBeauticianNow();
    }
  }

  LoginBeauticianNow() async
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
            await fAuth.signInWithEmailAndPassword(
              email: emailTextEditingController.text.trim(),
              password: passwordTextEditingController.text.trim(),
            ).catchError((msg) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Error: " + msg.toString());
            })
        ).user;
    if (firebaseUser != null) {
      DatabaseReference beauticiansRef = FirebaseDatabase.instance.ref().child(
          "beauticians");
      beauticiansRef.child(firebaseUser.uid).once().then((beauticianKey) {
        final snap = beauticianKey.snapshot;
        if (snap.value != null) {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login sucessful");
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen()));
        }
        else {
          Fluttertoast.showToast(msg: "No record exist with this email");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    }
    else {
      Navigator.pop(context);Fluttertoast.showToast(msg: "Error occured during login.");
    }
  }












  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo1.png"),
              ),

              const SizedBox(height: 10,),
              Text(
                "Login as Beautician ",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,

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
                  ),
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
                  "Login",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.brown),
                ),
                onPressed: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder:(c)=>SignUpScreen()));
                },
              )
            ],

          ),
        ),

      ),
    );
  }
}
