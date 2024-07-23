import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'homepage.dart';
import 'welcomepage.dart';

class GoogleSignin extends StatefulWidget {
  // String name;
  // String email;
  GoogleSignin({super.key,
 //  required this.name,
 // required this.email
 });

  @override
  State< GoogleSignin> createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State< GoogleSignin> {
  String? email;
  String? name;
  String? imagename;
  String? url;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  final _googleSignin=GoogleSignIn();
  String _error="";
  final _auth=FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
  }

  List<XFile> userlist = [];
  void selectimage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> user = await picker.pickMultiImage();
    userlist = user;
    setState(() {});
  }

  void captureimage() async {
    PermissionStatus camerapermission = await Permission.camera.status;
    print(camerapermission);
    if (camerapermission.isDenied) {
      await Permission.camera.request();
    }
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.rear);
    imageFile = File(image!.path);
    print(imageFile!.path);
    imagename = image.name;
    print(image.name);

    setState(() {});
  }

  File? imageFile;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                


                ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: userlist.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Image.file(
                        File(userlist[index].path),
                        height: 50,
                        width: 50,
                      );
                    }),

                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  height: 50,
                  width: 320,
                  child: TextField(
                    onTap: () {},
                    controller: emailcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.lightBlue.shade100),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.lightBlue.shade100, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.lightBlue.shade100, width: 2.0),
                        )),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                  height: 50,
                  width: 320,
                  child: TextField(
                    onTap: () {},
                    controller: namecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'name',
                        hintStyle: TextStyle(
                            fontSize: 15.0, color: Colors.lightBlue.shade100),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.lightBlue.shade100, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                              color: Colors.lightBlue.shade100, width: 2.0),
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.lightBlue.shade100, // background
                      backgroundColor: Colors.blue, // foreground
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        'email': emailcontroller.text,
                        'name': namecontroller.text,
                        'date': DateTime.now(),
                        'image': url,
                        'imagename': imagename!,
                      }).then((value) => Navigator.pop(context));
                    },
                    child: Text(
                      "                      Login                  ",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Or',
                  style: TextStyle(color: Colors.blue),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    try {
                       final GoogleSignInAccount? googleUser=
                           await _googleSignin.signIn();
                       final GoogleSignInAuthentication googleAuth=
                           await googleUser!.authentication;
                       final credential=GoogleAuthProvider.credential(
                         accessToken: googleAuth.accessToken,
                         idToken: googleAuth.idToken,
                       );
                       final userCredential=
                           await _auth.signInWithCredential(credential);
                       print(".......${userCredential.user!.uid}");
                       if(userCredential.user! != null)
                         {
                           String email=googleUser.email;
                           String? name=googleUser.displayName;
                           final currentUser=FirebaseAuth.instance!.currentUser;
                           print("...............${email}");
                           print("...............${name}");
                           final snapshot = await FirebaseFirestore.instance
                           .collection("Users").doc(currentUser!.uid).get();
                           if(snapshot.exists)
                             {
                               Navigator.push(
                                   context,MaterialPageRoute(builder: (context)=>
                                   WelcomePage(name: name.toString(),email: email,)));

                             }
                           else{
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>
                                 Chatdatapage(name: '', email: '',)));


                           }
                         }

                    }on FirebaseAuthException catch(v)
                    {
                      setState(() {
                        _error=v.message!;
                      });
                    }
                    catch(v){
                      setState(() {
                        _error="Failed to Sign in with google";
                      });
                    }
                  },
                  child: CircleAvatar(
                      child: Image(
                    image: NetworkImage(
                      'https://clipground.com/images/google-logo-clipart-transparent.png',
                    ),
                    fit: BoxFit.fill,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.lightBlue.shade100, // background
                        backgroundColor: Colors.blue, // foreground
                      ),
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateAc()));
                      },
                      child: Text(
                          '                 Create Account                ')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
