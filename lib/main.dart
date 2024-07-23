import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/welcome_screen.dart';

import 'package:my_chatt_app/phone_otp/exist_detailpage.dart';
import 'package:my_chatt_app/phone_otp/loginpage.dart';
import 'package:my_chatt_app/phone_otp/phone_otppage.dart';
import 'package:my_chatt_app/phone_otp/welcom_page.dart';
import 'package:my_chatt_app/practies/login.dart';
import 'package:my_chatt_app/practies/shared_pre.dart';
import 'chat_app/home_screen1.dart';
import 'chat_app/login_screen.dart';
import 'chat_app/signup_screen.dart';
import 'chat_app/user_screen.dart';
import 'chatscreens/home_screen.dart';
import 'chatscreens/login_screen.dart';
import 'chatscreens/sign_upscreen.dart';
import 'chatwith_phone/botton_tabbar.dart';
import 'chatwith_phone/contact_list.dart';
import 'chatwith_phone/splash_screen.dart';
import 'firebase_options.dart';
import 'google_signin/loginpage.dart';
import 'login_page.dart';
import 'new_chatcreate/chat_profilepage.dart';
import 'new_chatcreate/chat_signin.dart';
import 'new_chatcreate/chat_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: Splash_screen1(),
    );
  }
}
