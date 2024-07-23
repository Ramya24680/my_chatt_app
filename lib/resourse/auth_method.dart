import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
import 'package:my_chatt_app/resourse/storage_method.dart';

import '../chatscreens/home_screen.dart';

class AuthMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  signUpUser({required String name,
    required String password,
    required  String email,
    required String gender,
    required  Uint8List file,
    required  BuildContext context,
  })async
  {
    String res="Some error ";
    try
        {
          if(name.isNotEmpty||
              email.isNotEmpty||
              password.isNotEmpty||
              gender.isNotEmpty||file !=null)

            {
              // UserCredential cred=await _auth.createUserWithEmailAndPassword(email:email,password: password);
              String photoUrl=await StorageMethod().uploadImageToStorage("profilePics", file!, false);
              await _firestore.collection("ChatApp")
              .doc(FirebaseAuth.instance.currentUser!.uid).set({
                "name":name,
                "uid":FirebaseAuth.instance.currentUser!.uid ,
                "email":email,
                "gender":gender,
                "photoUrl":photoUrl
              }).then((onValue)=>
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())));

            }
        }
        catch(e)
    {
      return e.toString();
    }
    return res;
  }
  loginUser(
     String email, String password,BuildContext context
) async {
    String res="Something wend wrong";
    try
        {
       if(email.isNotEmpty||password.isNotEmpty) {
         var check= await FirebaseFirestore.instance.collection('ChatApp')
             .where("email",isEqualTo: email).get();
         print(check.docs.length);
         if(check.docs.length == 1){
           await _auth.signInWithEmailAndPassword(email: email, password: password).then((onValue){

             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
           });
         }else{
           await _auth.createUserWithEmailAndPassword(email: email, password: password).then((onValue)=>
               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen())));
         }


       if(check ==res)
         {

         }
         res="success";
       }
       else
         {
           return SignupScreen();
         }
        }catch (e){
      return e.toString();
    }
    return res;
  }
}