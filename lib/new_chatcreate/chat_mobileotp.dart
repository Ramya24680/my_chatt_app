import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/new_chatcreate/chat_welcome.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_bottomtab.dart';

class Chat_MobileOtp extends StatefulWidget {
  final String phone_number;
  Chat_MobileOtp({super.key, required this.phone_number});

  @override
  State<Chat_MobileOtp> createState() => _Chat_MobileOtpState();
}

class _Chat_MobileOtpState extends State<Chat_MobileOtp> {
  String code = "";
  String smsCode = "";
  String? _verificationCode;
  final TextEditingController otppin = TextEditingController();

  @override
  void initState() {
    super.initState();
    verifyPhonenumber();
  }

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.phone_number}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          final User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            final uid = user.uid;
            print('User UID: $uid');
            var myphoneNo = await FirebaseFirestore.instance
                .collection('newChat').doc(uid).get();
            print('Phone Number: ${widget.phone_number}');
            if (myphoneNo.exists) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatBottomtab();
              }));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Chat_welcome(
                  name: "",
                  email: "",
                  phone: widget.phone_number,
                );
              }));
            }
          }
        });
      },
      verificationFailed: (FirebaseAuthException s) {
        print('Verification Failed: ${s.message}');
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("${s.message}"),
          );
        });
      },
      codeSent: (String? verificationID, int? resendToken) {
        setState(() {
          print('Verification ID: $verificationID');
          _verificationCode = verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        setState(() {
          _verificationCode = verificationID;
        });
      },
      timeout: Duration(seconds: 30),
    );
  }

  Future<void> submitOtp() async {
    final credential = PhoneAuthProvider.credential(
        verificationId: _verificationCode!, smsCode: otppin.text
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      final currentuser = FirebaseAuth.instance.currentUser;
      if (currentuser != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('newChat').doc(currentuser.uid).get();
        if (snapshot.exists) {
          var sharedPref1 = await SharedPreferences.getInstance();
          bool? isLoggedIn = await sharedPref1.setBool('Login', true);
          print(isLoggedIn);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatBottomtab();
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Chat_welcome(
              name: "",
              email: "",
              phone: widget.phone_number,
            );
          }));
        }
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('asset/image/chat_image/newchatcreate_bg.jpg', fit: BoxFit.cover,),
          ),
          Column(
            children: [
              SizedBox(height: 150),
              Align(
                alignment: Alignment.center,
                child: Text('Welcome', textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold
                )),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Sign up/Log in to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),),
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Enter the 6 digit OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedColor: Color(0xffdcbcd1),
                    inactiveColor: Colors.white,
                    selectedFillColor: Colors.lightBlue,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: false,
                  controller: otppin,
                  onCompleted: (v) {
                    print("Completed: $v");
                  },
                  onChanged: (value) {
                    print(value);
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: submitOtp,
                  child: Text("Verify", style: TextStyle(color: Colors.black),),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Color(0xff7ed6da),
                    fixedSize: Size(150, 40),
                    side: BorderSide(
                        width: 2,
                        color: Color(0xff7ed6da), style: BorderStyle.values[1]
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.blue, width: 2)
                    ), enableFeedback: true,
                    elevation: 5,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 500,
                  child: Text(
                    "Didn't get the OTP? Resend OTP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
