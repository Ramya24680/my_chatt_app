import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chatt_app/chatwith_phone/chats.dart';
import 'package:my_chatt_app/chatwith_phone/contact_list.dart';
import 'package:my_chatt_app/chatwith_phone/profile_screen.dart';
import 'package:my_chatt_app/chatwith_phone/search_page.dart';

import 'Chat_search.dart';
import 'chat_contact.dart';
import 'chat_profilepage.dart';

class ChatBottomtab extends StatefulWidget {
  @override
  _ChatBottomtabState createState() => _ChatBottomtabState();
}

class _ChatBottomtabState extends State<ChatBottomtab> {
  TextEditingController searchCon=TextEditingController();
  int _currentIndex = 0;

  List children = [
    // chats(),
    // UserListScreen(),
    // Chat_contact(),
    ChatContact(),
    ChatProfile (),

  ];
  File? imageFile;
  String imageUrl = "";
  Future getImageCamera() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.camera).then((xFile) async {
      if (xFile != null) {
        imageFile = File(xFile.path);
        var ref = FirebaseStorage.instance
            .ref()
            .child('new_chatImage')
            .child("${imageFile}.jpg");

        var uploadTask = await ref.putFile(imageFile!);
        imageUrl = await uploadTask.ref.getDownloadURL();
        setState(() {});
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,

      backgroundColor: Color(0xff7ed6da),
      appBar: AppBar(
        title: Text("Chats",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.teal),),
        backgroundColor: Colors.teal.shade100,
        actions: [
          // Spacer(),
          IconButton(onPressed: (){
            getImageCamera();
          }, icon: Icon(Icons.camera_alt_outlined)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen1 ()));
          }, icon: Icon(Icons.search))
        ],

      ),
      body:
      children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffefc6cc),
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
