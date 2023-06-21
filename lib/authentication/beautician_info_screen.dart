import 'package:flutter/material.dart';
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
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  TextField(
                    controller: BeauticianNameEditingController,
                    style: TextStyle(
                        color: Colors.grey
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
                          color: Colors.grey,
                          fontSize: 16,
                        )
                    ),

                  ),
                  TextField(
                    controller: BeauticianEmailTextEditingController,
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
                    controller: BeauticianAddressTextEditingController,

                    style: TextStyle(
                        color: Colors.grey
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
                          color: Colors.grey,
                          fontSize: 16,
                        )
                    ),

                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> BeauticianInfoScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent,
                    ),
                    child:const Text(
                      "save Details",
                      style: TextStyle(
                        color: Colors.black54,
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
