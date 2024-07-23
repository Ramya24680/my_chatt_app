import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatscreens/chatlist_screen.dart';
import 'package:my_chatt_app/chatscreens/userlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
           UserScreen(),
            ChatlistScreen(name: "", email: "", photoUrl: '',),
          ],
        ),



      ),
    );
  }
}
