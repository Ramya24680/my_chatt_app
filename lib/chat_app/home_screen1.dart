import 'package:flutter/material.dart';
import 'package:my_chatt_app/chat_app/user_screen.dart';
import 'package:my_chatt_app/chatscreens/chatlist_screen.dart';
class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
          title: Text("Chat App"),
          centerTitle: true,
          bottom: TabBar(
            // indicator: BoxDecoration(shape: BoxShape.rectangle,
            //
            //   color: Colors.white,
            // ),
            indicatorColor: Colors.purpleAccent,
            labelColor: Colors.black,
            dividerColor: Colors.black,
            tabs: [
              Tab(
                text: "Userlist",

              ),
              Text("Chat List")
            ],
          ),
        ),
        body: TabBarView(
          children: [
          ChatUser(),
            ChatlistScreen(name: "", email: "", photoUrl: '',),
          ],
        ),



      ),
    );
  }
}
