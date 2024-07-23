import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCreate extends StatefulWidget {
  String email;
  String password;
   ChatCreate({super.key,
   required this.email,
   required this.password
   });

  @override
  State<ChatCreate> createState() => _ChatCreateState();
}

class _ChatCreateState extends State<ChatCreate> {
 TextEditingController emailCon=TextEditingController();
 TextEditingController passwordCon=TextEditingController();
  TextEditingController conpassword=TextEditingController();
  @override
  void initState(){
    super.initState();
    emailCon=TextEditingController(text: widget.email);
    passwordCon=TextEditingController(text: widget.password);
    conpassword=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('asset/image/bg4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Container(),flex: 2,),
              Image.asset('asset/image/chat_image/createimage.png', height: 160),

              SizedBox(height: 45,
                child: TextField(
                  controller: emailCon,

                  decoration: InputDecoration(filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)
                  ),hintText: "Enter your email",
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 45,
                child: TextField(
                  controller: passwordCon,
                   obscureText: true,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),hintText: "Enter your password",
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 45,
                child: TextField(
                  controller: conpassword,
                  decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),hintText: "Enter your confirm password",
                      hintStyle: TextStyle(fontSize: 15,color: Colors.grey)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(

                width: double.infinity,
                height: 45,child: Text("Created Account"),

                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))
                    )),
              ),
              Flexible(child: Container(),flex: 2,)
            ],
          ),
        ),
      ),

    );
  }
}
