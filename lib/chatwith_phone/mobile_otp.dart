import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/welcome_screen.dart';
import 'package:my_chatt_app/phone_otp/exist_detailpage.dart';
import 'package:my_chatt_app/phone_otp/welcom_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'botton_tabbar.dart';
import 'contact_list.dart';

class MobileOtp_Page extends StatefulWidget {
  String phone_number;
  MobileOtp_Page({super.key,required this.phone_number});

  @override
  State< MobileOtp_Page> createState() => _MobileOtp_PageState();
}

class _MobileOtp_PageState extends State< MobileOtp_Page> {
  String code="";
  String smsCode="";
  String? _verificationCode;
  final TextEditingController otppin=TextEditingController();
  verifyPhonenumber()async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${widget.phone_number}",
      verificationCompleted: (PhoneAuthCredential credential) async
      {
        await FirebaseAuth.instance.signInWithCredential(credential)
            .then((value) async
        {
          final User? user=FirebaseAuth.instance.currentUser;
          final uid=user!.uid;
          print("..........${uid}...........");
          var myphoneNo=await FirebaseFirestore.instance
              .collection("mobileChat").doc(uid).get();
          print(widget.phone_number);
          if(myphoneNo.exists)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return  MyHomePage();
            },
            ));
          }else
          {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Welcomephonepage(
                  name:"",
                  email:"",
                  phone:widget.phone_number
              );
            }
            ));
          }
        });
      },
      verificationFailed:(FirebaseAuthException s)
      {
        print(s);
        showDialog(context: context, builder: (context)
        {
          return AlertDialog(
            title: Text("${s.message}"),
          );
        }
        );
      },
      codeSent: (String? verificationID,int? resendToken){
        setState(() {
          print("..................${verificationID}");
          _verificationCode=verificationID;
        });
      },
      codeAutoRetrievalTimeout: (String verifivcationID)
      {
        setState(() {

          _verificationCode=verifivcationID;
        });
      },
      timeout: Duration(seconds: 30),
    );
  }
  Future<void>submitOtp() async {
    final credential=PhoneAuthProvider.credential(
        verificationId: _verificationCode!,smsCode:otppin.text);
    try{

      await FirebaseAuth.instance.signInWithCredential(credential);
      final currentuser=FirebaseAuth.instance.currentUser;
      final snapshot=await FirebaseFirestore.instance
          .collection("mobileChat")
          .doc(currentuser!.uid)
          .get();
      if(snapshot.exists)

      {
        Navigator.push(context, MaterialPageRoute(builder: (context){
        return  MyHomePage();
      }
      ));

      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return
       WelcomeScreen(name: "", username:"", phone: widget.phone_number);},
        ));
      }
    }catch (e) {
      print(e.toString());
    }
  }
  @override
  void initState(){
    super.initState();
    verifyPhonenumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,width: 200,
                    color: Colors.green.shade100,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,width: 200,
                    color: Colors.green.shade100,
                    child: Text("Welcome",textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 500,
                    color: Colors.green.shade100,
                    child: Text("Sign up/Log in to continue"
                      ,textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(height: 50,width: 500,
                    color: Colors.green.shade100,
                    child: Text("Enter the 6 digit OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otppin,
                    cursorColor: Colors.green,
                    keyboardType:TextInputType.number ,
                    onCompleted: (v)
                    {
                      setState(() {
                        smsCode=otppin.text;
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 500,
                    color: Colors.green.shade100,
                    child: Text(
                      "Didn't get the OTP? Resend OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: ()
                    {
                      submitOtp();
                    },
                    child: Text("Verify",style: TextStyle(color: Colors.black),),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: Colors.green,
                      side: BorderSide(
                          width: 2,
                          color: Colors.green,
                          style: BorderStyle.values[1]

                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.blue,width: 2)
                      ),enableFeedback: true,
                      elevation: 5,
                    ),
                  ),

                ),
                SizedBox(height: 30,),
                // LinearProgressIndicator(color: Colors.green,),

              ],
            ),
          ),
        ),
      ),

    );
  }
}


