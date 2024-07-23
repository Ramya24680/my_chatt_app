// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// // import 'package:my_chatt_app/chatscreens/home_screen.dart';
// // import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
// //
// // class ChatLogin extends StatefulWidget {
// //   const ChatLogin({super.key});
// //
// //   @override
// //   State<ChatLogin> createState() => _ChatLoginState();
// // }
// //
// // class _ChatLoginState extends State<ChatLogin> {
// //   TextEditingController emailCon = TextEditingController();
// //   TextEditingController passwordCon = TextEditingController();
// //   final _googleSignin=GoogleSignIn();
// //   final _auth =FirebaseAuth.instance;
// //   String _error="";
// //    @override
// //    void dispose(){
// //      super.initState();
// //      emailCon.dispose();
// //      passwordCon.dispose();
// //    }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Container(
// //           padding: EdgeInsets.symmetric(horizontal: 32),
// //           decoration: BoxDecoration(
// //               image: DecorationImage(
// //                   image: AssetImage(
// //                     'asset/image/bg4.jpg',
// //                   ),
// //                   fit: BoxFit.cover)),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             children: [
// //               Flexible(
// //                 child: Container(),
// //                 flex: 2,
// //               ),
// //               Image.asset(
// //                 'asset/image/undrawlog.png',
// //                 height: 140,
// //               ),
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               SizedBox(
// //                 height: 45,
// //                 child: TextField(
// //                   controller: emailCon,
// //                   decoration: InputDecoration(
// //                       filled: true,
// //                       fillColor: Colors.white,
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                         borderSide: BorderSide(color: Colors.transparent),
// //                       ),
// //                       hintText: "Enter your email",
// //                     hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
// //               ),
// //               ),
// //
// //               SizedBox(
// //                 height: 20,
// //               ),
// //               SizedBox(
// //                 height: 45,
// //                 child: TextField(
// //                   controller: passwordCon,
// //                   decoration: InputDecoration(
// //                       filled: true,
// //                       fillColor: Colors.white,
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                         borderSide: BorderSide(color: Colors.transparent),
// //                       ),
// //                       hintText: "Enter your password",
// //                       hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               GestureDetector(
// //                 onTap: ()async{
// //                   await FirebaseFirestore.instance.collection("chatuser")
// //                       .doc(FirebaseAuth.instance.currentUser!.uid).set({
// //                     "email":emailCon,
// //                     "password":passwordCon,
// //                   }).then((value){
// //                     print("Success");
// //                    Navigator.pop(context);
// //                   });
// //                 },
// //                 child: Container(
// //                   width: double.infinity,
// //                   alignment: Alignment.center,
// //                   child: Text(
// //                     "Log in",
// //                     style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 15,
// //                         color: Colors.white),
// //                   ),
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   decoration: ShapeDecoration(
// //                       color: Colors.blue,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.all(Radius.circular(10)),
// //                       )),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               InkWell(
// //                 onTap: () async {
// //                   try{
// //     final GoogleSignInAccount? googleUser=await _googleSignin.signIn();
// //     final GoogleSignInAuthentication googleAuth=await googleUser!.authentication;
// //     final credential=GoogleAuthProvider.credential(
// //     accessToken: googleAuth.accessToken,
// //     idToken: googleAuth.idToken,
// //     );
// //     final userCredential =await _auth.signInWithCredential(credential);
// //     print("........${userCredential.user!.uid}");
// //     if(userCredential.user! !=null)
// //     {
// //     String email=googleUser.email;
// //     String? name=googleUser.displayName;
// //     final currentUser=FirebaseAuth.instance.currentUser;
// //     print("..............${email}");
// //     print("................${name}");
// //     final snapshot=await FirebaseFirestore.instance
// //         .collection("chatUser").doc(currentUser!.uid).get();
// //     if(snapshot.exists){
// //     // await saveLoginState(email);
// //     Navigator.pushReplacement(
// //     context, MaterialPageRoute(builder: (context)=>HomeScreen()));
// //     }else{
// //     Navigator.push(context,MaterialPageRoute(builder:(context)=>SignupScreen()));
// //
// //     }
// //     }
// //     }on FirebaseAuthException catch(v){
// //                     setState(() {
// //                       _error=v.message!;
// //                     });
// //
// //                   }catch (v){
// //                     setState(() {
// //                       _error="Failed to Sign in with Google";
// //                     });
// //                   }
// //                 },
// //                 child: Container(
// //                   width: double.infinity,
// //                   alignment: Alignment.center,
// //                   child: Text(
// //                     "Continue with Google",
// //                     style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 15,
// //                         color: Colors.white),
// //                   ),
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   decoration: ShapeDecoration(
// //                       color: Colors.blue,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.all(Radius.circular(10)),
// //                       )),
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Container(
// //                 width: double.infinity,
// //                 alignment: Alignment.center,
// //                 child: Text(
// //                   "Create Account",
// //                   style: TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       fontSize: 15,
// //                       color: Colors.white),
// //                 ),
// //                 padding: EdgeInsets.symmetric(vertical: 12),
// //                 decoration: ShapeDecoration(
// //                     color: Colors.blue,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                     )),
// //               ),
// //               Flexible(
// //                 child: Container(),
// //                 flex: 2,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_chatt_app/chatscreens/home_screen.dart';
// import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'create_screen.dart';
//
// class ChatLogin extends StatefulWidget {
//   const ChatLogin({super.key});
//
//   @override
//   State<ChatLogin> createState() => _ChatLoginState();
// }
//
// class _ChatLoginState extends State<ChatLogin> {
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();
//   final _googleSignin = GoogleSignIn();
//   final _auth = FirebaseAuth.instance;
//   String _error = "";
//   bool isLoding=false;
//
//   @override
//   void dispose() {
//     emailCon.dispose();
//     passwordCon.dispose();
//     super.dispose();
//   }
//   Future<void>_SaveLoginState(String email) async
//   {
//     final prefs=await SharedPreferences.getInstance();
//     await prefs.setString('email', email);
//     // await prefs.setString('password', password);
//     await prefs.setBool('isLoggedIn',true);
//   }
// Future<void>_checkLoginState()async{
//     final prefs=await SharedPreferences.getInstance();
//     final isLoggedIn =prefs.getBool('isLoggedIn')??false;
//     if(isLoggedIn){
//       Navigator.push(context, MaterialPageRoute(builder:
//           (context)=>HomeScreen()));
//     }
// }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _checkLoginState();
//   }
//   bool _isObscure=true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 32),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('asset/image/bg4.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(child: Container(), flex: 2),
//               Image.asset('asset/image/undrawlog.png', height: 140),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                   controller: emailCon,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                     hintText: "Enter your email",
//                     hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                   controller: passwordCon,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                     hintText: "Enter your password",
//                     hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: ()async{
//                   setState(() {
//                     isLoding =true;
//                   });
//                   try {
//                     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//                       email: emailCon.text.trim(),
//                       password: passwordCon.text.trim(),
//                     );
//                     print("User Id:${userCredential.user!.uid}");
//                     print("Email:${emailCon.text}");
//                     await FirebaseFirestore.instance.collection("chatuser")
//                         .doc(userCredential.user!.uid)
//                         .set({
//                       "email": emailCon.text.trim(),
//                       "password": passwordCon.text.trim(),
//                     });
//                     print(".........User data stored successfully.......");
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()));
//                   } on FirebaseAuthException catch (e) {
//                     setState(() {
//                       _error = e.message!;
//                     });
//                     print("FirebaseAuthException:$e");
//                   } catch (e){
//                     setState(() {
//                       _error="An unexpected error";
//                     });
//                     print("Exception:$e");
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Log in",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               InkWell(
//                 onTap: () async {
//                   try {
//                     final GoogleSignInAccount? googleUser = await _googleSignin.signIn();
//                     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//                     final credential = GoogleAuthProvider.credential(
//                       accessToken: googleAuth.accessToken,
//                       idToken: googleAuth.idToken,
//                     );
//                     final userCredential = await _auth.signInWithCredential(credential);
//                     print(".......${userCredential.user!.uid}");
//                     if (userCredential.user! != null) {
//                       String email = googleUser.email;
//                       String? name = googleUser.displayName;
//                       final currentUser = FirebaseAuth.instance.currentUser;
//                       print("...............${email}");
//                       print("...............${name}");
//                       final snapshot = await FirebaseFirestore.instance
//                           .collection("ChatApp").doc(currentUser!.uid).get();
//                       if (snapshot.exists) {
//                         // await saveLoginState(email);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       } else {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
//                       }
//                     }
//                   } on FirebaseAuthException catch (v) {
//                     setState(() {
//                       _error = v.message!;
//                     });
//                   } catch (v) {
//                     setState(() {
//                       _error = "Failed to Sign in with google";
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Continue with Google",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context)
//                   =>  ChatCreate (email: emailCon.text, password:passwordCon.text,)));
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               Flexible(child: Container(), flex: 2),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_chatt_app/chat_app/signup_screen.dart';
// import 'package:my_chatt_app/chatscreens/home_screen.dart';
// import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'create_screen.dart';
//
// class ChatLogin extends StatefulWidget {
//   const ChatLogin({super.key});
//
//   @override
//   State<ChatLogin> createState() => _ChatLoginState();
// }
//
// class _ChatLoginState extends State<ChatLogin> {
//   TextEditingController emailCon = TextEditingController();
//   TextEditingController passwordCon = TextEditingController();
//   final _googleSignin = GoogleSignIn();
//   final _auth = FirebaseAuth.instance;
//   String _error = "";
//   bool isLoading = false;
//
//   @override
//   void dispose() {
//     emailCon.dispose();
//     passwordCon.dispose();
//     super.dispose();
//   }
//
//   // Future<void> _saveLoginState(String email) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString('email', email);
//   //   await prefs.setBool('isLoggedIn', true);
//   // }
//   //
//   // Future<void> _checkLoginState() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//   //   if (isLoggedIn) {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => HomeScreen()),
//   //     );
//   //   }
//   // }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _checkLoginState();
//   // }
//
//   bool _isObscure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 32),
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('asset/image/bg4.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(child: Container(), flex: 2),
//               Image.asset('asset/image/undrawlog.png', height: 140),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                   controller: emailCon,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                     hintText: "Enter your email",
//                     hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                   controller: passwordCon,
//                   obscureText: _isObscure,
//                   decoration: InputDecoration(
//                     filled: true,
//                     suffixIcon: IconButton(
//                         icon: Icon(_isObscure
//                             ? Icons.visibility
//                             : Icons.visibility_off),
//                       onPressed: (){
//                           setState(() {
//                             _isObscure=! _isObscure;
//                           });
//                       },
//                     ),
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.transparent),
//                     ),
//                     hintText: "Enter your password",
//                     hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () async {
//                   setState(() {
//                     isLoading = true;
//                   });
//                   try {
//                     UserCredential userCredential =
//                         await _auth.signInWithEmailAndPassword(
//                       email: emailCon.text.trim(),
//                       password: passwordCon.text.trim(),
//                     );
//                     await FirebaseFirestore.instance
//                         .collection("chatuser")
//                         .doc(userCredential.user!.uid)
//                         .set({
//                       "email": emailCon.text.trim(),
//                       "password": passwordCon.text.trim(),
//                     });
//                     setState(() {
//                       isLoading = false;
//                     });
//                     Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()));
//                   } on FirebaseAuthException catch (e) {
//                     setState(() {
//                       _error = e.message!;
//                       isLoading = false;
//                     });
//                   } catch (e) {
//                     setState(() {
//                       _error = "An unexpected error occurred";
//                       isLoading = false;
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: isLoading == true
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : Text(
//                           "Log in",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               InkWell(
//                 onTap: () async {
//                   try {
//                     final GoogleSignInAccount? googleUser =
//                         await _googleSignin.signIn();
//                     final GoogleSignInAuthentication googleAuth =
//                         await googleUser!.authentication;
//                     final credential = GoogleAuthProvider.credential(
//                       accessToken: googleAuth.accessToken,
//                       idToken: googleAuth.idToken,
//                     );
//                     final userCredential =
//                         await _auth.signInWithCredential(credential);
//                     if (userCredential.user! != null) {
//                       String email = googleUser.email;
//                       String? name = googleUser.displayName;
//                       final currentUser = FirebaseAuth.instance.currentUser;
//                       final snapshot = await FirebaseFirestore.instance
//                           .collection("chatuser")
//                           .doc(currentUser!.uid)
//                           .get();
//                       if (snapshot.exists) {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       } else {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ChatSign()));
//                       }
//                     }
//                   } on FirebaseAuthException catch (v) {
//                     setState(() {
//                       _error = v.message!;
//                     });
//                   } catch (v) {
//                     setState(() {
//                       _error = "Failed to sign in with Google";
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Continue with Google",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ChatCreate(
//                         email: emailCon.text,
//                         password: passwordCon.text,
//                       ),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.white,
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(
//                     color: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                 ),
//               ),
//               Flexible(child: Container(), flex: 2),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chatt_app/chat_app/home_screen1.dart';
import 'package:my_chatt_app/chat_app/signup_screen.dart';
import 'package:my_chatt_app/chatscreens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_screen.dart';

class ChatLogin extends StatefulWidget {
  const ChatLogin({super.key});

  @override
  State<ChatLogin> createState() => _ChatLoginState();
}

class _ChatLoginState extends State<ChatLogin> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  final _googleSignin = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  String _error = "";
  bool isLoading = false;

  @override
  void dispose() {
    emailCon.dispose();
    passwordCon.dispose();
    super.dispose();
  }

  Future<void> _saveLoginState(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<void> _checkLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatHomeScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/image/bg4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 2),
                Image.asset('asset/image/undrawlog.png', height: 140),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: emailCon,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter your email",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextField(
                    controller: passwordCon,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter your password",
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                        email: emailCon.text.trim(),
                        password: passwordCon.text.trim(),
                      );
                      await FirebaseFirestore.instance
                          .collection("chatuser")
                          .doc(userCredential.user!.uid)
                          .set({
                        "email": emailCon.text.trim(),
                        "password": passwordCon.text.trim(),
                        "name" : "",
                        "imageUrl" : "",
                        "gender" : ""
                      });
                      await _saveLoginState(emailCon.text.trim());
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => ChatHomeScreen()));
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        _error = e.message!;
                        isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        _error = "An unexpected error occurred";
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: isLoading == true
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                      "Log in",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    try {
                      final GoogleSignInAccount? googleUser =
                      await _googleSignin.signIn();
                      final GoogleSignInAuthentication googleAuth =
                      await googleUser!.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      final userCredential =
                      await _auth.signInWithCredential(credential);
                      if (userCredential.user! != null) {
                        String email = googleUser.email;
                        String? name = googleUser.displayName;
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final snapshot = await FirebaseFirestore.instance
                            .collection("chatuser")
                            .doc(currentUser!.uid)
                            .get();
                        await _saveLoginState(email);
                        if (snapshot.exists) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatSign()));
                        }
                      }
                    } on FirebaseAuthException catch (v) {
                      setState(() {
                        _error = v.message!;
                      });
                    } catch (v) {
                      setState(() {
                        _error = "Failed to sign in with Google";
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatCreate(
                          email: emailCon.text,
                          password: passwordCon.text,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Flexible(child: Container(), flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
