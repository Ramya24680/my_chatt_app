
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  String name;
  String email;
  WelcomePage({super.key,
  required this.name,
required this.email});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State< WelcomePage> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: widget.name);
     _emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text('Welcome Page'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          Center(
            child: TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'email': _emailController.text,
                  'name': _nameController.text,
                  'date': DateTime.now(),
                  // 'image': url,
                  // 'imagename': imagename!,
                }).then((value) => Navigator.pop(context));
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 15, color: Colors.white),),

              style: TextButton.styleFrom(
                fixedSize: Size(300, 50),
                backgroundColor: Colors.blue.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.blue.shade200,width: 2),
                ),

              ),

            ),
          ),
        ],
      ),
    );
  }
}
