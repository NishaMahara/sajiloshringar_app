import 'package:flutter/material.dart';
import 'package:sajiloshringar_app/splashScreen/splash_screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Profile"
      ),
    );

  }
}


// // child: ElevatedButton(
// // child: Text(
// // "sign out",
// // ),
// // onPressed: (),
// // {
// //   fAuth.signOut();
// Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
// // }
// )