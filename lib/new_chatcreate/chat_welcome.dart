
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/new_chatcreate/chat_bottomtab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat_welcome extends StatefulWidget {
  String name;
  String email;
  String phone;
  Chat_welcome({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<Chat_welcome> createState() => _Chat_welcomeState();
}

class _Chat_welcomeState extends State<Chat_welcome> {
  TextEditingController name = TextEditingController();
  late TextEditingController phoneNumber;
  TextEditingController username = TextEditingController();
  TextEditingController mail = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumber = TextEditingController(text: widget.phone);
    name.text = widget.name;
    mail.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'asset/image/chat_image/newchatcreate_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Image.asset(
                  'asset/image/chat_image/welcom.png',
                  scale: 4,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 180.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    TextField(
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Mobile no",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: username,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: "Enter your username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: mail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your mail",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('newChat')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .set({
                            'name': name.text,
                            'username': username.text,
                            'phone': phoneNumber.text,
                            'mail': mail.text,
                            'image': ''
                          }).then((value)async {
                            var sharedPref1 = await SharedPreferences.getInstance();
                            bool? isLoggedIn = await sharedPref1.setBool('Login', true);
                            print(isLoggedIn);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatBottomtab()),
                            );
                          });
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: Color(0xff7ed6da),
                          fixedSize: Size(150, 40),
                          side: BorderSide(
                              width: 2,
                              color: Color(0xff7ed6da),
                              style: BorderStyle.values[1]),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.blue, width: 2)),
                          enableFeedback: true,
                          elevation: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
