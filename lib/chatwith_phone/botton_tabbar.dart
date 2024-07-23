import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/chats.dart';
import 'package:my_chatt_app/chatwith_phone/contact_list.dart';
import 'package:my_chatt_app/chatwith_phone/profile_screen.dart';
import 'package:my_chatt_app/chatwith_phone/search_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchCon=TextEditingController();
  int _currentIndex = 0;

  List children = [
    // chats(),
    // UserListScreen(),
    ContactsListPage(),
    ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatApp",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
          }, icon: Icon(Icons.search))
        ],

      ),
      body:
      children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      backgroundColor: Colors.green.shade200,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
