import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LogPrac extends StatefulWidget {
  const LogPrac({super.key});

  @override
  State<LogPrac> createState() => _LogPracState();
}

class _LogPracState extends State<LogPrac> {
  TextEditingController nameCon=TextEditingController();
  TextEditingController phoneCon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              TextField(
                controller: nameCon,
                decoration: InputDecoration(
                  labelText: "Name"
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: phoneCon,
                decoration: InputDecoration(
                  labelText: "phone"
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()async
              {
               await  FirebaseFirestore.instance.
                collection("practices").doc()
                   .set({
                 "name": nameCon.text,
                 "Phone-Number": phoneCon.text
               }).then((value) {
                 print("Success");
                 nameCon.clear();
                 phoneCon.clear();
               });

              }, child: Text("Login")),
            ],
          ),
        ),


      ),
    );
  }
}

