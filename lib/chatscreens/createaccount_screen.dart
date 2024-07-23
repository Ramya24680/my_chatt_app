import 'package:flutter/material.dart';


class CreateScreen extends StatefulWidget {
  final String email, password;

  CreateScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late  TextEditingController emailController=TextEditingController();
  late  TextEditingController passwordController=TextEditingController();
  late  TextEditingController cpasswordController=TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    passwordController = TextEditingController(text: widget.password);
    cpasswordController = TextEditingController();
  }
  bool _isObscure=true;
  bool _isObscure1=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/image/bg4.jpg'),
                fit: BoxFit.cover ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Container(), flex: 2),
              SizedBox(height: 20),
              SizedBox(height: 45,
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "Enter your email",)
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 45,
                child: TextField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(filled: true,
                      suffixIcon: IconButton(icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            _isObscure=!_isObscure;
                          });
                        },),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "Enter your password",)
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 45,
                child: TextField(
                    obscureText: _isObscure1,
                    controller: cpasswordController,
                    decoration: InputDecoration(filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure1?Icons.visibility:Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            _isObscure1=!_isObscure1;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "Enter your confirmpassword",)
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }
}

