import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'botton_tabbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController gender = TextEditingController();

  String? imageName;
  String? imageUrl;
  File? imageFile;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    phoneNumber.dispose();
    username.dispose();
    mail.dispose();
    gender.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var s = await FirebaseFirestore.instance
        .collection("mobileChat").doc(uid).get();

    if (s.exists) {
      var data = s.data()!;
      name.text = data['name'] ?? '';
      username.text = data['username'] ?? '';
      mail.text = data['mail'] ?? '';
      phoneNumber.text = data['phone'] ?? '';
      gender.text = data['gender'] ?? '';
      age.text = data['age'] ?? '';
      imageUrl = data['image'] ?? '';
    }

    setState(() {});
  }

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      imageName = image.name;
      setState(() {});
    }
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      var ref = FirebaseStorage.instance.ref().child("Images/$imageName");
      await ref.putFile(imageFile!);
      imageUrl = await ref.getDownloadURL();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 64),
                Stack(
                  children: [
                    imageFile == null && imageUrl == null
                        ? GestureDetector(
                      onTap: selectImage,
                      child: Center(
                        child: CircleAvatar(
                          radius: 63,
                          child: Icon(
                            Icons.person,
                            size: 100,
                          ),
                        ),
                      ),
                    )
                        : Center(
                      child: CircleAvatar(
                        radius: 63,
                        backgroundImage: imageFile != null
                            ? FileImage(imageFile!)
                            : NetworkImage(imageUrl!) as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      right: 110,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Enter name",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: phoneNumber,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                      hintText: "Enter your age",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: mail,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: TextFormField(
                    controller: gender,
                    decoration: InputDecoration(
                      hintText: "Enter your gender",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await uploadImage();
                      String uid = FirebaseAuth.instance.currentUser!.uid;
                      await FirebaseFirestore.instance
                          .collection('mobileChat')
                          .doc(uid)
                          .set({
                        'name': name.text,
                        'username': username.text,
                        'phone': phoneNumber.text,
                        'mail': mail.text,
                        'gender': gender.text,
                        'age': age.text,
                        'image': imageUrl, // Use the variable instead of string literal
                      });
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.green),
                      fixedSize: MaterialStatePropertyAll(Size(250, 55)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLoading
                            ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : Text("Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22,
                                color: Colors.white)),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
