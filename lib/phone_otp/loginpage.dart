import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/phone_otp/phone_otppage.dart';

import '../google_signin/loginpage.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({super.key});

  @override
  State<LoginPhonePage> createState() => _LoginPhonePageState();
}

class _LoginPhonePageState extends State<LoginPhonePage> {

  TextEditingController pcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: Colors.green.shade100,
      ),
      backgroundColor: Colors.green.shade100,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              Text("Mobile number",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              TextField(
                controller: pcontroller,

                cursorWidth: 2,
                cursorColor: Colors.green,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.phone),
                    hintText: "Enter your mobile no"),
              ),

              SizedBox(height: 40,),
        
                     Align(
                       alignment: Alignment.center,
                         child: TextButton(
                        onPressed: () async
                        {
        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        PhoneOtp_Page(phone_number: pcontroller.text)));
        
                        },
        
                           child:Text("Continue",style: TextStyle(color: Colors.black),) ,
                           style: TextButton.styleFrom(
                             fixedSize: Size(300, 50),
                             backgroundColor: Colors.green.shade700,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10),
                               side: BorderSide(color: Colors.green,width: 2),
                             ),
        
                           ),),),
                        SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                        child: Text("Or"),
                      ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> GoogleSignin()
                    ));
        
                  },
                  child: Row(
                    children: [
                      Container(height: 30,width: 30,color: Colors.blue,
                      child: Image.network('https://www.vhv.rs/dpng/d/0-6167_google-app-icon-png-transparent-png.png',fit: BoxFit.fill,),),
                      SizedBox(width: 20,),
                      Text( "Continue with Google Signin",style: TextStyle(color: Colors.black),),
                    ],
                  ),
                    style: TextButton.styleFrom(
                        fixedSize: Size(300, 50),
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.green,width: 2),
                        ),),
                ),
              )
        
        
        
            ],
          ),
        ),
      ),

    );
  }
}
