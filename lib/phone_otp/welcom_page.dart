import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/phone_otp/exist_detailpage.dart';

class Welcomephonepage extends StatefulWidget {
  String email;
  String name;
  String phone;
   Welcomephonepage({Key? key,
   required this.name,
   required this.email,
   required this.phone}):super(key:key);

  @override
  State<Welcomephonepage> createState() => _WelcomephonepageState();
}

class _WelcomephonepageState extends State<Welcomephonepage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  @override
  void initState(){
    super.initState();
    nameController=TextEditingController(text: widget.name);
    emailController=TextEditingController(text: widget.email);
    phoneController=TextEditingController(text: widget.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80,),
                Text("Welcome",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold,color: Colors.green.shade900),),

                SizedBox(height: 20,),

                TextField(
                  controller: nameController,
                  cursorWidth: 2,
                  cursorColor: Colors.green,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                     hintText: "name"),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller:emailController,
                  decoration: InputDecoration(hintText: "email"),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "phoneNo"),
                ),
                SizedBox(height: 40,),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: ()
                    {
                      FirebaseFirestore.instance.collection('PhoneOtp')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(
                        {
                          "name":nameController.text,
                          "email":emailController.text,
                          "phone":phoneController.text,
                        }
                      ).then((value){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ExistPage()));

                      });
                    },
                     child: Text("Continue",style: TextStyle(color: Colors.black),),
                    style: TextButton.styleFrom(
                      fixedSize: Size(300, 50),
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.green,width: 2),
                      ),

                    ),
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
