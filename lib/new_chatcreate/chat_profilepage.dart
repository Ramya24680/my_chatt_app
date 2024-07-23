// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_chatt_app/new_chatcreate/chat_bottomtab.dart';
//
// import '../chatwith_phone/botton_tabbar.dart';
//
// class ChatProfile extends StatefulWidget {
//   const ChatProfile({super.key});
//
//   @override
//   State<ChatProfile> createState() => _ChatProfileState();
// }
//
// class _ChatProfileState extends State<ChatProfile> {
//   TextEditingController name = TextEditingController();
//   TextEditingController age = TextEditingController();
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController username = TextEditingController();
//   TextEditingController mail = TextEditingController();
//   TextEditingController gender = TextEditingController();
//   String? imageName;
//   String? imageUrl;
//   File? imageFile;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   @override
//   void dispose() {
//     name.dispose();
//     age.dispose();
//     phoneNumber.dispose();
//     gender.dispose();
//     username.dispose();
//     mail.dispose();
//     super.dispose();
//   }
//
//   Future<void> getData() async {
//     String uid = FirebaseAuth.instance.currentUser!.uid;
//     var s = await FirebaseFirestore.instance.collection('newChat').doc(uid).get();
//     if (s.exists) {
//       var data = s.data()!;
//       name.text = data['name'] ?? '';
//       username.text = data['username'] ?? '';
//       mail.text = data['mail'] ?? '';
//       phoneNumber.text = data['phone'] ?? '';
//       gender.text = data['gender'] ?? '';
//       age.text = data['age'] ?? '';
//       imageUrl = data['image'] ?? '';
//     }
//     setState(() {});
//   }
//
//   void selectImage() async {
//     showModalBottomSheet(
//       backgroundColor: Color(0xffb5e6f4),
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Text('Profile photo',style: TextStyle(fontSize: 25),),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//
//
//                       IconButton(
//                         icon: Icon(Icons.photo_library),
//                         onPressed: () async {
//                           final ImagePicker picker = ImagePicker();
//                           final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//                           if (image != null) {
//                             imageFile = File(image.path);
//                             imageName = image.name;
//                             await uploadImage();
//                             setState(() {});
//                           }
//                           Navigator.pop(context);
//                         },
//                       ),
//                       SizedBox(height: 20,),
//                       Text('Gallery'),
//                     ],
//                   ),
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.photo_camera),
//                         onPressed: () async {
//                           final ImagePicker picker = ImagePicker();
//                           final XFile? image = await picker.pickImage(source: ImageSource.camera);
//                           if (image != null) {
//                             imageFile = File(image.path);
//                             imageName = image.name;
//                             await uploadImage();
//                             setState(() {});
//                           }
//                           Navigator.pop(context);
//                         },
//                       ),
//                       SizedBox(height: 20,),
//                       Text('Camera'),
//                     ],
//                   ),
//                   // if (imageUrl != null || imageFile != null)
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () async {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Delete Profile Image"),
//                                   content: Text("Are you sure you want to delete the profile image?"),
//                                   actions: [
//                                     TextButton(
//                                       child: Text("Cancel"),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text("Delete"),
//                                       onPressed: () async {
//                                         await deleteImage();
//                                         setState(() {});
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                         SizedBox(height: 20,),
//                         Text('Delete'),
//                       ],
//                     ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> uploadImage() async {
//     if (imageFile != null) {
//       var ref = FirebaseStorage.instance.ref().child('Images/$imageName');
//       await ref.putFile(imageFile!);
//       imageUrl = await ref.getDownloadURL();
//     }
//   }
//
//   Future<void> deleteImage() async {
//     // if (imageUrl != null) {
//       var ref = FirebaseStorage.instance.refFromURL(imageUrl!);
//       await ref.delete();
//       imageUrl = null;
//       imageFile = null;
//       await FirebaseFirestore.instance
//           .collection('newChat')
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .update({'image': FieldValue.delete()});
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Image.asset(
//                 'asset/image/chat_image/newchatcreate_bg.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Center(
//               child: Column(
//                 children: [
//                   SizedBox(height: 65),
//                   Stack(
//                     children: [
//                       imageFile == null && imageUrl == null
//                           ? GestureDetector(
//                         onTap: selectImage,
//                         child: Center(
//                           child: CircleAvatar(
//                             radius: 65,
//                             child: Icon(Icons.person, size: 100),
//                           ),
//                         ),
//                       )
//                           : Center(
//                         child: CircleAvatar(
//                           radius: 65,
//                           backgroundImage: imageFile != null
//                               ? FileImage(imageFile!)
//                               : NetworkImage(imageUrl!) as ImageProvider,
//                         ),
//                       ),
//
//                       Positioned(
//                         bottom: -1,
//                         right: 110,
//                         child: CircleAvatar(radius: 20,backgroundColor: Color(0xffefc6cc),
//                           child: IconButton(
//                             onPressed: selectImage,
//                             icon: Icon(Icons.add_a_photo),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TextField(
//
//                       decoration: InputDecoration(
//                         hintText: "Enter your name",
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.white),),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TextField(
//                      keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         hintText: "Enter your phone number",
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.white),),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),),
//                       textAlign: TextAlign.left,
//                     ),
//                   ), SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TextField(
//
//                       decoration: InputDecoration(
//                         hintText: "Enter your age",
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.white),),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),),
//                       textAlign: TextAlign.left,
//                     ),
//                   ), SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TextField(
//
//                       decoration: InputDecoration(
//                         hintText: "Enter your email",
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.white),),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),),
//                       textAlign: TextAlign.left,
//                     ),
//                   ), SizedBox(height: 5,),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: TextField(
//
//                       decoration: InputDecoration(
//                         hintText: "Enter your gender",
//                         disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: BorderSide(color: Colors.white),),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide(color: Colors.white)),),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   SizedBox(height: 5,),
//                   Align(
//                     alignment: Alignment.center,
//                     child: TextButton(
//                       onPressed:() async{
//                         setState(() {
//                           isLoading= true;
//                         });
//                         await uploadImage();
//                         String uid =FirebaseAuth.instance.currentUser!.uid;
//                         await FirebaseFirestore.instance
//                         .collection('newChat').doc(uid)
//                         .set({
//                           'name': name.text,
//                           'username': username.text,
//                           'phone': phoneNumber.text,
//                           'mail': mail.text,
//                           'gender': gender.text,
//                           'age': age.text,
//                           'image': imageUrl,
//                         });
//                         setState(() {
//                           isLoading =false;
//                         });
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context)=>ChatBottomtab()));
//                         },
//                       child:Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           isLoading ? CircularProgressIndicator():
//                           Center(child: Text("Save", style: TextStyle(color: Colors.black),)),
//                         ],
//                       ),
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.blue,
//                         splashFactory: NoSplash.splashFactory,
//                         backgroundColor: Color(0xff7ed6da),
//                         fixedSize: Size(150, 40),
//                         side: BorderSide(
//                             width: 2,
//                             color: Color(0xff7ed6da), style: BorderStyle.values[1]
//                         ),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             side: BorderSide(color: Colors.blue, width: 2)
//                         ), enableFeedback: true,
//                         elevation: 5,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chatt_app/new_chatcreate/chat_bottomtab.dart';
// import 'botton_tabbar.dart';

class ChatProfile extends StatefulWidget {
  const ChatProfile({super.key});

  @override
  State<ChatProfile> createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
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
        .collection("newChat").doc(uid).get();

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
       child:  Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'asset/image/chat_image/newchatcreate_bg.jpg',
                fit: BoxFit.cover,
              ),),
       Center(
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
                          .collection('newChat')
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
                          builder: (context) => ChatBottomtab(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.blue.shade100),
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
                                color: Colors.black)),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    ]),),
    );
  }
}
