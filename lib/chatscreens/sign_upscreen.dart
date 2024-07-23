import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chatt_app/chatscreens/home_screen.dart';
import 'package:my_chatt_app/chatscreens/login_screen.dart';


import '../resourse/auth_method.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genderController.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = new ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("no image select");
  }

  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('asset/image/bg4.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SizedBox(
              height: 64,
            ),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.purple.shade200,
                        backgroundImage: AssetImage("asset/image/img_1.png"),
                      ),
                Positioned(
                    bottom: -10,
                    left: 70,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "Enter your name",
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "Enter your gender",
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "Enter your email",
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45,
              child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintText: "Enter your password",
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: ()async {
                setState(() {
                  isLoading = true;
                });
                String res = await AuthMethods().signUpUser(
                    name: nameController.text,
                    password: passwordController.text,
                    email: emailController.text,
                    gender: genderController.text,
                    file: _image!, context: context);

              },
              child: Container(
                child: isLoading==false
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text("Sign up"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
              ),
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text("Don't have an Account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    child: Text(
                      " Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
