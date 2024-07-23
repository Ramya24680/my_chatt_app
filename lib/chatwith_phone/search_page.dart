import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/chats.dart';

import 'chat_profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String search = "";

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  // final _searchController=TextEditingController();
  @override
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  String chat = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, bottom: 10, top: 10),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      print(search);
                      // _searchController.clear();
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade300,
                     suffixIcon: IconButton(onPressed: (){
                       _searchController.clear();

                     },icon: Icon(Icons.close),),
                      hintText: "Search here.....",
                      prefixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.0))),
                ),
              ),
              _searchController.text.isEmpty
                  ? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("mobileChat")
                          .where(FieldPath.documentId,
                              isNotEqualTo:
                                  FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        print(snapshot.data!.docs.length);
                        int length = snapshot.data!.docs.length;
                        //  final filter=snapshot.data!.docs.where((doc){
                        //    return doc.id!=FirebaseAuth.instance.currentUser!.uid;
                        // }).toList();
                        //  if(filter.isEmpty){
                        //    return Center(
                        //      child: Text("No contacts found"),
                        //    );
                        //  }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  color: Colors.green.shade300,
                                  child: ListTile(
                                    onTap: () {
                                      chat = chatRoomId(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          snapshot.data!.docs[index].id);
                                      FirebaseFirestore.instance
                                          .collection('chatroom')
                                          .doc(chat)
                                          .set({
                                        "friend": [
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          snapshot.data!.docs[index].id
                                        ],
                                        "date": DateTime.now(),
                                        "status": "",
                                        "first chat": FirebaseAuth
                                            .instance.currentUser!.uid,
                                        "received chat":
                                            snapshot.data!.docs[index].id
                                      }).then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreendetail(
                                              name: snapshot.data!.docs[index]
                                                  ['name'],
                                              imageUrl: snapshot.data!
                                                      .docs[index]['image'] ??
                                                  '',
                                              id: snapshot.data!.docs[index].id,
                                              chatroomid: chat,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    title: Text(
                                        snapshot.data!.docs[index]['name']),
                                    subtitle: Text(snapshot
                                        .data!.docs[index]['phone']
                                        .toString()),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                chat = chatRoomId(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    snapshot
                                                        .data!.docs[index].id);
                                                FirebaseFirestore.instance
                                                    .collection('chatroom')
                                                    .doc(chat)
                                                    .set({
                                                  "friend": [
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    snapshot
                                                        .data!.docs[index].id
                                                  ],
                                                  "date": DateTime.now(),
                                                  "status": "",
                                                  "first chat": FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  "received chat": snapshot
                                                      .data!.docs[index].id
                                                }).then((value) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreendetail(
                                                        name: snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                        imageUrl: snapshot.data!
                                                                    .docs[index]
                                                                ['image'] ??
                                                            '',
                                                        id: snapshot.data!
                                                            .docs[index].id,
                                                        chatroomid: chat,
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                              icon:
                                                  Icon(Icons.message_outlined)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatContactProfile(
                                                              name:snapshot.data!.docs[index]['name'],
                                                              phoneNumber:snapshot.data!.docs[index]['phone'],
                                                              mail:snapshot.data!.docs[index]['mail'],
                                                              imageUrl:snapshot.data!.docs[index].id,
                                                            )));
                                              },
                                              icon: Icon(Icons.person))
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          },
                        );
                      },
                    )
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("mobileChat")
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.data!.docs.length);
                        int length = snapshot.data!.docs.length;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase()) ||
                                snapshot.data!.docs[index]['phone']
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase())) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Colors.green.shade300,
                                  child: ListTile(
                                    onTap: () {},
                                    title: Text(
                                        snapshot.data!.docs[index]['name']),
                                    subtitle: Text(snapshot
                                        .data!.docs[index]['phone']
                                        .toString()),
                                    trailing: SizedBox(
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                String chat1 = chatRoomId(
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    snapshot
                                                        .data!.docs[index].id);
                                                FirebaseFirestore.instance
                                                    .collection('chatroom')
                                                    .doc(FirebaseAuth.instance
                                                            .currentUser!.uid +
                                                        snapshot.data!
                                                            .docs[index].id)
                                                    .set({
                                                  "friend": FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid +
                                                      snapshot
                                                          .data!.docs[index].id,
                                                  "date": DateTime.now(),
                                                  "status": "",
                                                  "first chat": FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid,
                                                  "received chat": snapshot
                                                      .data!.docs[index].id
                                                }).then((value) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatScreendetail(
                                                        name: snapshot.data!
                                                                .docs[index]
                                                            ['name'],
                                                        imageUrl: snapshot.data!
                                                                    .docs[index]
                                                                ['image'] ??
                                                            '',
                                                        id: snapshot.data!
                                                            .docs[index].id,
                                                        chatroomid: chat1,
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                              icon: Icon(Icons.chat)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatContactProfile(
                                                              name:snapshot.data!.docs[index]['name'],
                                                              phoneNumber:snapshot.data!.docs[index]['phone'],
                                                              mail:snapshot.data!.docs[index]['mail'],
                                                              imageUrl:snapshot.data!.docs[index].id,
                                                            )));
                                              },
                                              icon: Icon(Icons.person))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
