// // import 'package:flutter/material.dart';
// //
// //
// //
// // class ProgressDialog extends StatefulWidget
// // {
// //   String? message;
// //   ProgressDialog({this.message});
// //
// //
// //   @override
// //   State<ProgressDialog> createState() => _ProgressDialogState();
// // }
// //
// // class _ProgressDialogState extends State<ProgressDialog> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Placeholder();
// //     final String? message = widget.message;
// //
// //   }
// // }
// //
// //
// //
// // @override
// // Widget build(BuildContext context)
// // {
// //   return Dialog(
// //     backgroundColor: Colors.black54,
// //     child: Container(
// //       margin: EdgeInsets.all(16.0),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(6),
// //
// //       ),
// //       child: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child:Row(
// //           children:[
// //             const SizedBox(width: 6.0,),
// //             CircularProgressIndicator(
// //               valueColor: AlwaysStoppedAnimation<Color>(Colors.black54) ,
// //             ),
// //             const SizedBox(width: 26.0,),
// //             Text(
// //               message!,
// //               style: const TextStyle(
// //                 color:Colors.grey,
// //                 fontSize: 12,
// //               ),
// //             ),
// //           ],
// //         ),
// //
// //       ),
// //     ),
// //   );
// // }
// //
//
//
//
//
//
// showDialog(
// context: context,
// barrierDismissible: false,
// builder: (BuildContext c)
// {
// return ProgressDialog(message: "Processing, Please wait...",);
// }
// );
// final User? firebaseUser =
// (
// await fAuth.createUserWithEmailAndPassword(
//
// email: emailTextEditingController.text.trim(),
// password: passwordTextEditingController.text.trim(),
// ).catchError((msg){
// Navigator.pop(context);
// Fluttertoast.showToast(msg: "Error: " + msg.toString());
// })
// ).user;
// if(firebaseUser != null)
//
// {
// Map BeauticianMap =
// {
// "id": firebaseUser.uid,
// "name": nameTextEditingController.text.trim(),
// "email": nameTextEditingController.text.trim(),
// "phone": nameTextEditingController.text.trim(),
//
// };
// DatabaseReference beauticiansRef = FirebaseDatabase.instance.reference().child("beautician");
// beauticiansRef.child(firebaseUser.uid).set(BeauticianMap);
//
// // currentfirebaseUser = firebaseUser;firebaseUserz
//
//
// }
// else
// {
// Navigator.pop(context);
// Fluttertoast.showToast(msg: "Account has not been created.");
// }
// }
//
