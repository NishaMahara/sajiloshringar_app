import 'package:flutter/material.dart';
import 'package:sajiloshringar_app/authentication/signup_screen.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      backgroundColor: Colors.black,
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
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,

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
                  ),
                ),

              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: ()
                {

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child:const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.grey),
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
