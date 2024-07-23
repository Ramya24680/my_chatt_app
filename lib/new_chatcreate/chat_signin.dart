import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chatt_app/chatwith_phone/welcome_screen.dart';
import 'package:my_chatt_app/new_chatcreate/chat_mobileotp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chatwith_phone/mobile_otp.dart';
import 'chat_bottomtab.dart';
import 'chat_welcome.dart';

class Chat_Signin extends StatefulWidget {
  const Chat_Signin({super.key});

  @override
  State<Chat_Signin> createState() => _Chat_SigninState();
}

class _Chat_SigninState extends State<Chat_Signin> {
  TextEditingController _otpcontroller=TextEditingController();
  final GoogleSignIn _googleSignIn=GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',

    ],
  );
  FirebaseAuth auth=FirebaseAuth.instance;
  Future<void>googleSignIn(BuildContext context)async{
    try{
      GoogleSignInAccount? googleSignInAccount=await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication=
            await googleSignInAccount.authentication;
        AuthCredential credential=await GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        try{
          UserCredential userCredential=
              await auth.signInWithCredential(credential);
          var as=await FirebaseFirestore.instance
          .collection('newChat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
          if(as.exists ==true)
            {
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context)=> Chat_welcome (name: "", phone: "", email: '',)));
            }else
              {
                await FirebaseFirestore.instance
                    .collection('newChat')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'displayName':googleSignInAccount.displayName.toString(),
                  'displayemail':googleSignInAccount.email.toString(),
                  'phoneUrl':googleSignInAccount.photoUrl.toString(),
                  'sadsa':googleSignInAccount.id.toString(),
                }).then((value)async{
                  var sharedPref1 = await SharedPreferences.getInstance();
                  bool? isLoggedIn = await sharedPref1.setBool('Login', true);
                  print(isLoggedIn);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatBottomtab(),
                      ));
                });
              }
        }catch(e){
          final snackBar=SnackBar(content: Text(e.toString()));
          print(snackBar);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }catch(e){
      final snackbar=SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Positioned.fill(
          child:Image.asset('asset/image/chat_image/newchatcreate_bg.jpg',fit: BoxFit.cover,),),
        Column(
          children: [
            Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200,width: 200,

                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,
                    child: Text('Sign in',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40,fontWeight: FontWeight.w500,),),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 50,
                    width: 200,

                    child: Text('Sign up Google/Phone',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),),
                  ),
                ),
            Padding(padding: EdgeInsets.only(left: 30,right: 30),
            child:
            TextField(
              controller:_otpcontroller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10), // Limit to 10 digits
              ],
              decoration: InputDecoration(
                prefixText: "+91",
                hintText: "Mobile No",
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white),),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.white)),),
              textAlign: TextAlign.left,
            ),),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  SharedPreferences preferences=
                      await SharedPreferences.getInstance();
                  await preferences.setString('phone', "9790048997")
                      .then((value)=>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Chat_MobileOtp(phone_number: _otpcontroller.text))));
                },
                child: Text('Continue',style: TextStyle(fontSize: 15,color: Colors.black),),
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  fixedSize: Size(250,50),
                  // backgroundColor: Colors.blue.shade200,
                  backgroundColor: Color(0xff7ed6da),
                  side: BorderSide(
                    width: 2,
                    color:  Color(0xff7ed6da),
                    style: BorderStyle.values[1]
                  ),
                  padding: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.blue.shade200,width: 2)
                  ),
                  enableFeedback: true,
                  elevation: 5,
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('OR',style: TextStyle(color: Colors.black,fontSize: 16),),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              googleSignIn(context);
            },
              child: Container(
                width: 250,height: 50,
                decoration: BoxDecoration(
                  // color: Colors.blue.shade200,
                  color: Color(0xffebcdd9),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10,right: 20),
                      height: 24,width: 24,
                    ),
                    Text('Continue with Google',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            )

              ],
            ),
          ]
          ),

    );
  }
}


