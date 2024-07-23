import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/signin_screen.dart';
import 'package:my_chatt_app/chatwith_phone/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'botton_tabbar.dart';



class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => Splash_screenState();
}

class Splash_screenState extends State<Splash_screen> {
  // static const String key="Login";
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    welcomepage();
  }
  void welcomepage() async {
    var sharedPref = await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPref.getBool("Login");
    print(isLoggedIn);
    Timer(Duration(seconds: 5), () {
      if (isLoggedIn == false || isLoggedIn == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 40),)
            ],
          ),
        ),
      ),
    );
  }
}
