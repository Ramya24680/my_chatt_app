// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_chatt_app/chatwith_phone/chats.dart';
// import 'package:my_chatt_app/new_chatcreate/Chat_message.dart';
//
// import 'chat_pro2.dart';
//
// class SearchScreen1 extends StatefulWidget {
//   const SearchScreen1({super.key});
//
//   @override
//   State<SearchScreen1> createState() => _SearchScreen1State();
// }
//
// String search = "";
//
// class _SearchScreen1State extends State<SearchScreen1> {
//   TextEditingController _searchController = TextEditingController();
//
//   String ChatRoomId(String user1, String user2) {
//     if (user1[0].toLowerCase().codeUnits[0] >
//         user2.toLowerCase().codeUnits[0]) {
//       return '$user1$user2';
//     } else {
//       return '$user2$user1';
//     }
//   }
//
//   String chat = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 25, right: 25, bottom: 10, top: 10),
//                 child: TextField(
//                   controller: _searchController,
//                   onChanged: (value) {
//                     setState(() {
//                       print(search);
//                     });
//                   },
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       filled: true,
//                       fillColor: Colors.grey.shade300,
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           _searchController.clear();
//                         },
//                         icon: Icon(Icons.close),
//                       ),
//                       hintText: "Search here.....",
//                       prefixIcon: IconButton(
//                           onPressed: () {}, icon: Icon(Icons.search)),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           borderSide:
//                           BorderSide(color: Colors.teal, width: 2.0)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           borderSide:
//                           BorderSide(color: Colors.teal, width: 2.0))),
//                 ),
//               ),
//               _searchController.text.isEmpty
//                   ? StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("newChat")
//                     .where(FieldPath.documentId,
//                     isNotEqualTo:
//                     FirebaseAuth.instance.currentUser!.uid)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   print(snapshot.data!.docs.length);
//                   int length = snapshot.data!.docs.length;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     itemCount: length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                             color: Color(0xff96e1e7),
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                     snapshot.data!.docs[index]
//                                     ['image'] ??
//                                         'https://via.placeholder.com/150'), // Placeholder image
//                               ),
//                               onTap: () {
//                                 chat = ChatRoomId(
//                                     FirebaseAuth.instance.currentUser!.uid,
//                                     snapshot.data!.docs[index].id);
//                                 FirebaseFirestore.instance
//                                     .collection('newChatroom')
//                                     .doc(chat)
//                                     .set({
//                                   "friend": [
//                                     FirebaseAuth
//                                         .instance.currentUser!.uid,
//                                     snapshot.data!.docs[index].id
//                                   ],
//                                   "date": DateTime.now(),
//                                   "status": "",
//                                   "first chat": FirebaseAuth
//                                       .instance.currentUser!.uid,
//                                   "received chat":
//                                   snapshot.data!.docs[index].id
//                                 }).then((value) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => Chats(
//                                         name: snapshot
//                                             .data!.docs[index]['name'],
//                                         imageUrl: snapshot.data!.docs[index]
//                                         ['image'] ??
//                                             '',
//                                         id: snapshot.data!.docs[index].id,
//                                         ChatRoomId: chat,
//                                       ),
//                                     ),
//                                   );
//                                 });
//                               },
//                               title: Text(
//                                   snapshot.data!.docs[index]['name']),
//                               subtitle: Text(snapshot
//                                   .data!.docs[index]['phone']
//                                   .toString()),
//                               trailing: SizedBox(
//                                 width: 100,
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           chat = ChatRoomId(
//                                               FirebaseAuth.instance
//                                                   .currentUser!.uid,
//                                               snapshot
//                                                   .data!.docs[index].id);
//                                           FirebaseFirestore.instance
//                                               .collection('newChatroom')
//                                               .doc(chat)
//                                               .set({
//                                             "friend": [
//                                               FirebaseAuth.instance
//                                                   .currentUser!.uid,
//                                               snapshot
//                                                   .data!.docs[index].id
//                                             ],
//                                             "date": DateTime.now(),
//                                             "status": "",
//                                             "first chat": FirebaseAuth
//                                                 .instance.currentUser!.uid,
//                                             "received chat": snapshot
//                                                 .data!.docs[index].id
//                                           }).then((value) {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => Chats(
//                                                   name: snapshot
//                                                       .data!.docs[index]
//                                                   ['name'],
//                                                   imageUrl: snapshot
//                                                       .data!.docs[index]
//                                                   ['image'] ??
//                                                       '',
//                                                   id: snapshot
//                                                       .data!.docs[index].id,
//                                                   ChatRoomId: chat,
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                         },
//                                         icon: Icon(Icons.message_outlined)),
//                                     IconButton(
//                                         onPressed: () {
//                                           try {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ChatContactProfile1(
//                                                       name: snapshot.data!.docs[index]
//                                                       ['name'],
//                                                       phoneNumber: snapshot.data!
//                                                           .docs[index]['phone'],
//                                                       mail: snapshot.data!.docs[index]
//                                                       ['mail'],
//                                                       imageUrl: snapshot.data!.docs[index]
//                                                       ['image'] ??
//                                                           '',
//                                                     ),
//                                               ),
//                                             );
//                                           } catch (e) {
//                                             print(
//                                                 'Error navigating to ChatContactProfile1: $e');
//                                           }
//                                         },
//                                         icon: Icon(Icons.person)),
//                                   ],
//                                 ),
//                               ),
//                             )),
//                       );
//                     },
//                   );
//                 },
//               )
//                   : StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("newChat")
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   print(snapshot.data!.docs.length);
//                   int length = snapshot.data!.docs.length;
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     itemCount: length,
//                     itemBuilder: (context, index) {
//                       if (snapshot.data!.docs[index]['name']
//                           .toString()
//                           .toLowerCase()
//                           .contains(
//                           _searchController.text.toLowerCase()) ||
//                           snapshot.data!.docs[index]['phone']
//                               .toString()
//                               .toLowerCase()
//                               .contains(
//                               _searchController.text.toLowerCase())) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Card(
//                             color: Colors.green.shade300,
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                     snapshot.data!.docs[index]['image'] ??
//                                         'https://via.placeholder.com/150'), // Placeholder image
//                               ),
//                               onTap: () {},
//                               title: Text(
//                                   snapshot.data!.docs[index]['name']),
//                               subtitle: Text(snapshot
//                                   .data!.docs[index]['phone']
//                                   .toString()),
//                               trailing: SizedBox(
//                                 width: 100,
//                                 child: Row(
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           String chat1 = ChatRoomId(
//                                               FirebaseAuth.instance
//                                                   .currentUser!.uid,
//                                               snapshot
//                                                   .data!.docs[index].id);
//                                           FirebaseFirestore.instance
//                                               .collection('newChatroom')
//                                               .doc(FirebaseAuth.instance
//                                               .currentUser!.uid +
//                                               snapshot.data!
//                                                   .docs[index].id)
//                                               .set({
//                                             "friend": FirebaseAuth.instance
//                                                 .currentUser!.uid +
//                                                 snapshot
//                                                     .data!.docs[index].id,
//                                             "date": DateTime.now(),
//                                             "status": "",
//                                             "first chat": FirebaseAuth
//                                                 .instance.currentUser!.uid,
//                                             "received chat": snapshot
//                                                 .data!.docs[index].id
//                                           }).then((value) {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => Chats(
//                                                   name: snapshot
//                                                       .data!.docs[index]
//                                                   ['name'],
//                                                   imageUrl: snapshot
//                                                       .data!.docs[index]
//                                                   ['image'] ??
//                                                       '',
//                                                   id: snapshot
//                                                       .data!.docs[index].id,
//                                                   ChatRoomId: chat1,
//                                                 ),
//                                               ),
//                                             );
//                                           });
//                                         },
//                                         icon: Icon(Icons.chat)),
//                                     IconButton(
//                                       onPressed: () {
//                                         try {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ChatContactProfile1(
//                                                     name: snapshot.data!.docs[index]
//                                                     ['name'],
//                                                     phoneNumber: snapshot.data!
//                                                         .docs[index]['phone'],
//                                                     mail: snapshot.data!.docs[index]
//                                                     ['mail'],
//                                                     imageUrl: snapshot.data!
//                                                         .docs[index]['image'] ??
//                                                         '',
//                                                   ),
//                                             ),
//                                           );
//                                         } catch (e) {
//                                           print(
//                                               'Error navigating to ChatContactProfile1: $e');
//                                         }
//                                       },
//                                       icon: Icon(Icons.person),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       return Container();
//                     },
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/chats.dart';
import 'package:my_chatt_app/new_chatcreate/Chat_message.dart';
import '../chatwith_phone/search_page.dart';
import 'chat_pro2.dart';

class SearchScreen1 extends StatefulWidget {
  const SearchScreen1({super.key});

  @override
  State<SearchScreen1> createState() => _SearchScreen1State();
}

class _SearchScreen1State extends State<SearchScreen1> {
  TextEditingController _searchController = TextEditingController();

  String ChatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
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
                      search = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: Icon(Icons.close),
                      ),
                      hintText: "Search here.....",
                      prefixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.search)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                          BorderSide(color: Colors.teal, width: 2.0))),
                ),
              ),
              _searchController.text.isEmpty
                  ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("newChat")
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
                  int length = snapshot.data!.docs.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var friendName = doc['name'];
                      var friendImage = doc['image'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Color(0xff96e1e7),
                          child:
                          // ListTile(
                          //   leading: CircleAvatar(
                          //     backgroundImage: friendImage != null
                          //         ? NetworkImage(friendImage)
                          //         : null,
                          //     backgroundColor: Colors.green,
                          //     child: friendImage == null
                          //         ? Text(
                          //       friendName[0],
                          //       style:
                          //       TextStyle(color: Colors.white),
                          //     )
                          //         : null,
                          //   ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: friendImage != null ? NetworkImage(friendImage) : null,
                              child: friendImage == null
                                  ? Text(
                                friendName.isNotEmpty ? friendName[0] : '',
                                style: TextStyle(color: Colors.white),
                              )
                                  : null,
                            ),
                            onTap: () {
                              chat = ChatRoomId(
                                  FirebaseAuth
                                      .instance.currentUser!.uid,
                                  doc.id);
                              FirebaseFirestore.instance
                                  .collection('newChatroom')
                                  .doc(chat)
                                  .set({
                                "friend": [
                                  FirebaseAuth
                                      .instance.currentUser!.uid,
                                  doc.id
                                ],
                                "date": DateTime.now(),
                                "status": "",
                                "first chat": FirebaseAuth
                                    .instance.currentUser!.uid,
                                "received chat": doc.id
                              }).then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chats(
                                      name: doc['name'],
                                      imageUrl: doc['image'] ?? '',
                                      id: doc.id,
                                      ChatRoomId: chat,
                                    ),
                                  ),
                                );
                              });
                            },
                            title: Text(doc['name']),
                            subtitle: Text(doc['phone'].toString()),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      chat = ChatRoomId(
                                          FirebaseAuth.instance
                                              .currentUser!.uid,
                                          doc.id);
                                      FirebaseFirestore.instance
                                          .collection('newChatroom')
                                          .doc(chat)
                                          .set({
                                        "friend": [
                                          FirebaseAuth.instance
                                              .currentUser!.uid,
                                          doc.id
                                        ],
                                        "date": DateTime.now(),
                                        "status": "",
                                        "first chat": FirebaseAuth
                                            .instance.currentUser!.uid,
                                        "received chat": doc.id
                                      }).then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Chats(
                                              name: doc['name'],
                                              imageUrl: doc['image'] ??
                                                  '',
                                              id: doc.id,
                                              ChatRoomId: chat,
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    icon: Icon(Icons.message_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChatContactProfile1(
                                                name: doc['name'],
                                                phoneNumber: doc['phone'],
                                                mail: doc['mail'],
                                                imageUrl: doc['image'] ?? '',
                                              ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.person),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
                  : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("newChat")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  int length = snapshot.data!.docs.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var friendName = doc['name'];
                      var friendImage = doc['image'];

                      if (friendName
                          .toString()
                          .toLowerCase()
                          .contains(
                          _searchController.text.toLowerCase()) ||
                          doc['phone']
                              .toString()
                              .toLowerCase()
                              .contains(
                              _searchController.text.toLowerCase())) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Color(0xff96e1e7),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: friendImage != null
                                    ? NetworkImage(friendImage)
                                    : null,
                                backgroundColor: Colors.green,
                                child: friendImage == null
                                    ? Text(
                                  friendName[0],
                                  style: TextStyle(
                                      color: Colors.white),
                                )
                                    : null,
                              ),
                              onTap: () {},
                              title: Text(friendName),
                              subtitle: Text(doc['phone'].toString()),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        String chat1 = ChatRoomId(
                                            FirebaseAuth.instance
                                                .currentUser!.uid,
                                            doc.id);
                                        FirebaseFirestore.instance
                                            .collection('newChatroom')
                                            .doc(chat1)
                                            .set({
                                          "friend": [
                                            FirebaseAuth.instance
                                                .currentUser!.uid,
                                            doc.id
                                          ],
                                          "date": DateTime.now(),
                                          "status": "",
                                          "first chat": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "received chat": doc.id
                                        }).then((value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Chats(
                                                name: friendName,
                                                imageUrl: friendImage ??
                                                    '',
                                                id: doc.id,
                                                ChatRoomId: chat1,
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      icon: Icon(Icons.chat),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChatContactProfile1(
                                                  name: doc['name'],
                                                  phoneNumber: doc['phone'],
                                                  mail: doc['mail'],
                                                  imageUrl:
                                                  doc['image'] ?? '',
                                                ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.person),
                                    ),
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
