import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExistPage extends StatefulWidget {
  const ExistPage({Key? key}):super(key: key);

  @override
  State<ExistPage> createState() => _ExistPageState();
}
 String number="";
class _ExistPageState extends State<ExistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
      ),
      body: StreamBuilder(stream: FirebaseFirestore.instance
          .collection("PhoneOtp")
          .doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder:(context,snapshot)
      {
        return
          Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Name :${snapshot.data!["name"]}",style: TextStyle(color: Colors.green.shade900,fontSize: 20),),
            SizedBox(height: 20,),
            Text("Email :${snapshot.data!["email"]}",style: TextStyle(color: Colors.green.shade900,fontSize: 20),),
                SizedBox(height: 20,),
            Text("Phone :${snapshot.data!["phone"]}",style: TextStyle(color: Colors.green.shade900,fontSize: 20),),

              ],
            ),
          );

      }),
    );
  }
}
