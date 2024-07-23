import 'package:flutter/material.dart';
class Chatdatapage extends StatefulWidget {
  Chatdatapage({super.key,
  required this.name,
  required this.email});
  String ? name;
  String ? email;

  @override
  State<Chatdatapage> createState() => _ChatdatapageState();
}

class _ChatdatapageState extends State<Chatdatapage> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  @override
  void initState() {
    super.initState();
    namecontroller = TextEditingController(text: widget.name);
    emailcontroller = TextEditingController(text: widget.email);
    setState(() {

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0)),
                height: 50,
                width: 320,
                child:
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.lightBlue.shade100),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.lightBlue.shade100, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.lightBlue.shade100, width: 2.0),
                      )),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0)),
                height: 50,
                width: 320,
                child:
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'name',
                      hintStyle: TextStyle(fontSize: 15.0, color: Colors.lightBlue.shade100),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.lightBlue.shade100, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Colors.lightBlue.shade100, width: 2.0),
                      )),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
