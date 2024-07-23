// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_chatt_app/chatscreens/createaccount_screen.dart';
// import 'package:my_chatt_app/chatscreens/home_screen.dart';
// import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
// import 'package:my_chatt_app/resourse/auth_method.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final emailController=TextEditingController();
//   final passwordController=TextEditingController();
//    bool isLoading=true;
//   final _googleSignin=GoogleSignIn();
//   String _error="";
//   final _auth=FirebaseAuth.instance;
//
//   @override
//   void dispose()
//   {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   showSnackBar(BuildContext context,String text){
//     return ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(text)));
//   }
//   // loginUser(BuildContext context) async {
//   //   setState(() {
//   //     isLoading=true;
//   //   });
//   //   String res=await AuthMethods().loginUser
//   //     (emailController.text, passwordController.text,context);
//   //   if(res=="success"){
//   //     setState(() {
//   //       isLoading=false;
//   //     });
//   //     showSnackBar(context, res);
//   //
//   //
//   //   }else
//   //   {
//   //     setState(() {
//   //       isLoading=false;
//   //     });
//   //     showSnackBar(context, res);
//   //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
//   //   }
//   // }
//   bool _isObscure=true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child:Container(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//
//                 image: AssetImage('asset/image/bg4.jpg'),
//                 fit: BoxFit.cover,
//               )),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Image.asset("asset/image/img_3.png"),
//                 Flexible(child: Container(),flex: 2,),
//                 // Image.asset("asset/image/bg4"),
//                 // Center(child: Text("Login",style: TextStyle(fontSize: 40),)),
//                 SizedBox(height: 20,),
//                 SizedBox(height: 45,
//                   child: TextField(
//                       controller: emailController,
//                       decoration: InputDecoration(filled: true,
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.transparent)
//                         ),
//                         hintText: "Enter your email",)
//                   ),
//                 ),
//
//                 SizedBox(height: 20,),
//                 SizedBox(height: 45,
//                   child: TextField(
//                       obscureText: _isObscure,
//                       controller: passwordController,
//                       decoration: InputDecoration(filled: true,
//                         suffixIcon: IconButton(icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off),
//                           onPressed: (){
//                             setState(() {
//                               _isObscure=!_isObscure;
//                             });
//                           },),
//                         fillColor: Colors.white,
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.transparent)
//                         ),
//                         hintText: "Enter your password",)
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                   onTap: (){
//                     AuthMethods().loginUser
//                       (emailController.text, passwordController.text,context);
//                   },
//                   child: Container(
//                     child: isLoading ==false?CircularProgressIndicator(
//                       color: Colors.white,
//                     ): Text("Log in"),
//                     width: double.infinity,
//                     alignment: Alignment.center,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: ShapeDecoration(
//                       color: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(4))
//                       )
//                     ),
//
//                   ),
//                 ),SizedBox(height: 10,),
//                 InkWell(
//                   onTap: () async {
//                     try {
//                       final GoogleSignInAccount? googleUser=
//                       await _googleSignin.signIn();
//                       final GoogleSignInAuthentication googleAuth=
//                       await googleUser!.authentication;
//                       final credential=GoogleAuthProvider.credential(
//                         accessToken: googleAuth.accessToken,
//                         idToken: googleAuth.idToken,
//                       );
//                       final userCredential=
//                       await _auth.signInWithCredential(credential);
//                       print(".......${userCredential.user!.uid}");
//                       if(userCredential.user! != null)
//                       {
//                         String email=googleUser.email;
//                         String? name=googleUser.displayName;
//                         final currentUser=FirebaseAuth.instance!.currentUser;
//                         print("...............${email}");
//                         print("...............${name}");
//                         final snapshot = await FirebaseFirestore.instance
//                             .collection("ChatApp").doc(currentUser!.uid).get();
//                         if(snapshot.exists)
//                         {
//                           // Navigator.push(
//                           //     context,MaterialPageRoute(builder:
//                           //     (context)=> Chat_screen(email: '', password: '',)));
//
//                         }
//                         else{
//                           Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen(
//                           )));
//
//
//                         }
//                       }
//
//                     }on FirebaseAuthException catch(v)
//                     {
//                       setState(() {
//                         _error=v.message!;
//                       });
//                     }
//                     catch(v){
//                       setState(() {
//                         _error="Failed to Sign in with google";
//                       });
//                     }
//                   },
//                   child:
//                   Container(
//
//                     width: double.infinity,
//                     height: 45.0,child: Text("Continue with google Sign"),
//
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     decoration: ShapeDecoration(color: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(4))
//                         )),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 GestureDetector(onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateScreen(
//                       email:emailController.text,
//                       password:passwordController.text)));
//                 },
//                   child: Container(
//
//                     width: double.infinity,
//                     height: 45.0,child: Text("Create account"),
//
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     decoration: ShapeDecoration(color: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(4))
//                         )),
//                   ),
//                 ),
//                 Flexible(child: Container(),flex: 2,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: Text("Don't have an Account?"),
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context)=> SignupScreen(
//
//
//                             )));
//
//                       },
//                       child: Container(
//                         child: Text(" Sign up",style: TextStyle(
//                           fontWeight: FontWeight.bold,color: Colors.white
//                         ),),
//                       ),
//                     )
//
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//
//
//
//               ],
//             ),
//           )
//         ),
//
//     );
//   }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_chatt_app/chatscreens/createaccount_screen.dart';
import 'package:my_chatt_app/chatscreens/home_screen.dart';
import 'package:my_chatt_app/chatscreens/sign_upscreen.dart';
import 'package:my_chatt_app/resourse/auth_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final _googleSignin = GoogleSignIn();
  String _error = "";
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> saveLoginState(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', email);
  }

  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Flexible(child: Container(), flex: 2,),
                SizedBox(height: 20,),
                SizedBox(height: 45,
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
                SizedBox(height: 20,),
                SizedBox(height: 45,
                  child: TextField(
                    obscureText: _isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: IconButton(icon: Icon(_isObscure
                          ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: "Enter your password",
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String res = await AuthMethods().loginUser(emailController.text, passwordController.text, context);
                    if (res == "success") {
                      await saveLoginState(emailController.text);
                      setState(() {
                        isLoading = false;
                      });
                      showSnackBar(context, res);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      showSnackBar(context, res);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    }
                  },
                  child: Container(
                    child: isLoading == true
                        ? CircularProgressIndicator(color: Colors.white,)
                        : Text("Log in"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        )
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                InkWell(
                  onTap: () async {
                    try {
                      final GoogleSignInAccount? googleUser = await _googleSignin.signIn();
                      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      );
                      final userCredential = await _auth.signInWithCredential(credential);
                      print(".......${userCredential.user!.uid}");
                      if (userCredential.user! != null) {
                        String email = googleUser.email;
                        String? name = googleUser.displayName;
                        final currentUser = FirebaseAuth.instance.currentUser;
                        print("...............${email}");
                        print("...............${name}");
                        final snapshot = await FirebaseFirestore.instance
                            .collection("ChatApp").doc(currentUser!.uid).get();
                        if (snapshot.exists) {
                          await saveLoginState(email);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                        }
                      }
                    } on FirebaseAuthException catch (v) {
                      setState(() {
                        _error = v.message!;
                      });
                    } catch (v) {
                      setState(() {
                        _error = "Failed to Sign in with google";
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    child: Text("Continue with Google Sign"),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        )),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateScreen(
                        email: emailController.text,
                        password: passwordController.text)));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    child: Text("Create account"),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))
                        )),
                  ),
                ),
                Flexible(child: Container(), flex: 2,),
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
                            MaterialPageRoute(builder: (context) => SignupScreen()));
                      },
                      child: Container(
                        child: Text(" Sign up", style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white
                        ),),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          )
      ),
    );
  }
}
