import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_bottomtab.dart';
import 'chat_signin.dart';

class Splash_screen1 extends StatefulWidget {
  const Splash_screen1({super.key});

  @override
  State<Splash_screen1> createState() => Splash_screen1State();
}

class Splash_screen1State extends State<Splash_screen1> {
  // static const String key="Login";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    welcomepage();
  }
  void welcomepage() async {
    var sharedPref1 = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPref1.getBool("Login");
    print(isLoggedIn);
    Timer(Duration(seconds: 5), () {
      if (isLoggedIn == false || isLoggedIn == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Chat_Signin()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatBottomtab()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff7ed6da),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),)
            ],
          ),
        ),
      ),
    );
  }
}
