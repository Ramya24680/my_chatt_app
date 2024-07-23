// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ChatSign extends StatefulWidget {
//   const ChatSign({super.key});
//
//   @override
//   State<ChatSign> createState() => _ChatSignState();
// }
//
// class _ChatSignState extends State<ChatSign> {
//   TextEditingController nameController=TextEditingController();
//   TextEditingController genderController=TextEditingController();
//   TextEditingController passController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   String? imagename;
//   @override
//   void dispose(){
//     super.dispose();
//     nameController.dispose();
//     genderController.dispose();
//     passController.dispose();
//     emailController.dispose();
//
//   }
//   void selectimage() async {
//     final ImagePicker picker = ImagePicker();
// // Pick an image.
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     imageFile = File(image!.path);
//     print(imageFile!.path);
//     imagename = image.name;
//     print(image.name);
//
//     setState(() {});
//   }
//
//   String? url;
//
//   Future<void> uploadimage() async {
//     var ref = FirebaseStorage.instance.ref().child("Images/${imageFile!.path}");
//     await ref.putFile(File(imageFile!.path));
//     url = await ref.getDownloadURL();
//   }
//
//   File? imageFile;
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding:  const EdgeInsets.symmetric(horizontal: 32),
//           decoration: BoxDecoration(
//             image:DecorationImage(
//             image: AssetImage('asset/image/bg4.jpg'),
//             fit:BoxFit.cover,
//           ),),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Flexible(child: Container(),flex: 2,),
//               SizedBox(height: 64,),
//               Stack(
//                 children: [
//                   imageFile == null
//                       ? GestureDetector(
//                       onTap: () async {
//                         selectimage();
//                       },
//                       child: Center(
//                           child: CircleAvatar(radius: 63,
//                             child: Icon(
//                               Icons.person,
//                               size: 100,
//                             ),
//                           )))
//                       : Center(
//                     child: CircleAvatar(
//                       radius: 40,
//                       backgroundImage: FileImage(imageFile!),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: -5,
//                       right: 80,
//                       child: IconButton(onPressed:(){},
//                   icon: Icon(Icons.add_a_photo),))
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.transparent)),
//                       hintText: "Enter your name",
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                     controller: genderController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.transparent)),
//                       hintText: "Enter your gender",
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.transparent)),
//                       hintText: "Enter your email",
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 45,
//                 child: TextField(
//                     controller: passController,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.transparent)),
//                       hintText: "Enter your password",
//                     )),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//
//               InkWell(
//                 onTap: () async {
//                   setState(() {
//
//                   });
//
//                 },
//                 child: Container(
//
//                   width: double.infinity,
//                   height: 45,child: Text("Sign up"),
//
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   decoration: ShapeDecoration(color: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(4))
//                       )),
//                 ),
//               ),
//               Flexible(child: Container(),flex: 2,)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chatt_app/chat_app/login_screen.dart';

class ChatSign extends StatefulWidget {
  const ChatSign({super.key});

  @override
  State<ChatSign> createState() => _ChatSignState();
}

class _ChatSignState extends State<ChatSign> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? imageName;
  String? imageUrl;
  File? imageFile;

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    passController.dispose();
    emailController.dispose();
    super.dispose();
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
bool isLoading =false;
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
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Container(), flex: 2),
              SizedBox(height: 64),
              Stack(
                children: [
                  imageFile == null
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
                      radius: 40,
                      backgroundImage: FileImage(imageFile!),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    right: 80,
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
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: "Enter your name",
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: "Enter your gender",
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: "Enter your email",
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    hintText: "Enter your password",
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap:()async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text,
                    );

                    User? user = userCredential.user;
                    if (user != null) {
                      await uploadImage();
                      await FirebaseFirestore.instance.collection('chatuser')
                          .doc(user.uid)
                          .set({
                        'name': nameController.text,
                        'gender': genderController.text,
                        'email': emailController.text,
                        'imageUrl': imageUrl,
                      });
                      // Navigate to home screen or show success message
                      print("User registered successfully");
                    }
                  } on FirebaseAuthException catch (e) {
                    // Handle error (show error message)
                    print("Error: ${e.message}");
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  child:
                   isLoading == true ?CircularProgressIndicator(color: Colors.white,)
                       : Text("Sign up"),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
              ),
              Flexible(child: Container(), flex: 2),

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
                          MaterialPageRoute(builder: (context) => ChatLogin()));
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
        ),
      ),
    );
  }
}
