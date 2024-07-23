


//Drawer
import 'package:flutter/material.dart';

class DrawerWidgt extends StatefulWidget {
  const DrawerWidgt({Key? key}) : super(key: key);

  @override
  _DrawerWidgtState createState() => _DrawerWidgtState();
}

class _DrawerWidgtState extends State<DrawerWidgt> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        // width: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        shadowColor: Colors.red,
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                  ),
                  Text("Header"),
                ],
              ),
              decoration: BoxDecoration(color: Colors.amber),
            ),
            ListTile(
              title: Text("Price"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.money),),
            ) ,  ListTile(
              title: Text("Stock"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.analytics_outlined),),
            )  , ListTile(
              title: Text("list"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.list),),
            )   ,ListTile(
              title: Text("Grid"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.grid_3x3),),
            )   ,ListTile(
              title: Text("Wallet"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.wallet),),
            )   ,ListTile(
              title: Text("Logout"),
              trailing: IconButton(onPressed: (){},icon: Icon(Icons.logout),),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 20,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Drawer Header'),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.pages),
              title: const Text('Image'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: const Text('Email'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      // backgroundColor: focus.hasFocus ? Colors.red : Colors.green,
      appBar: AppBar(
        title: const Text("DropDownMenu"),
      ),

    );
  }
}