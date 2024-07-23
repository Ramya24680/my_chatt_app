//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_chatt_app/chatwith_phone/search_page.dart';
// import 'package:my_chatt_app/new_chatcreate/Chat_message.dart';
//
// class ChatContact extends StatefulWidget {
//   const ChatContact({super.key});
//
//   @override
//   State<ChatContact> createState() => _ChatContactState();
// }
//
// class _ChatContactState extends State<ChatContact> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('newChatroom')
//                   .where('friend', arrayContainsAny: [
//                 FirebaseAuth.instance.currentUser!.uid
//               ]).snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                     child: Text('No contact found'),
//                   );
//                 }
//
//                 return ListView.builder(
//                   physics: BouncingScrollPhysics(),
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     // Extract necessary data from Firestore snapshot
//                     var doc = snapshot.data!.docs[index];
//                     String chatroomId = doc.id;
//                     String firstUserId = doc['first chat'];
//                     String receivedUserId = doc['received chat'];
//                     String friendUserId = firstUserId == FirebaseAuth.instance.currentUser!.uid
//                         ? receivedUserId
//                         : firstUserId;
//
//                     return StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('newChat')
//                           .doc(friendUserId)
//                           .snapshots(),
//                       builder: (context, snap) {
//                         if (snap.connectionState == ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         }
//
//                         if (!snap.hasData || snap.data!.data() == null) {
//                           return SizedBox(); // Handle case where data is null
//                         }
//
//                         var friendData = snap.data!.data()!;
//                         String friendName = friendData['name'];
//                         String friendPhone = friendData['phone'];
//                         String friendImage = friendData.containsKey('image')
//                             ? friendData['image']
//                             : '';
//
//                         return Card(
//                           child: ListTile(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Chats(
//                                     name: friendName,
//                                     imageUrl: friendImage,
//                                     id: snap.data!.id,
//                                     ChatRoomId: chatroomId,
//                                   ),
//                                 ),
//                               );
//                             },
//                             leading: friendImage.isNotEmpty
//                                 ? CircleAvatar(
//                               radius: 40,
//                               backgroundImage: NetworkImage(friendImage),
//                             )
//                                 : CircleAvatar(
//                               radius: 40,
//                               backgroundColor: index == 0
//                                   ? Colors.green
//                                   : Colors.green.shade300,
//                               child: Text(
//                                 friendName[0],
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             title: Text(
//                               friendName,
//                               style: TextStyle(fontWeight: FontWeight.w400),
//                             ),
//                             subtitle: Text(friendPhone),
//                             trailing: IconButton(
//                               onPressed: () {},
//                               icon: Icon(Icons.phone,),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/search_page.dart';
import 'package:my_chatt_app/new_chatcreate/Chat_message.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatContact extends StatefulWidget {
  const ChatContact({super.key});

  @override
  State<ChatContact> createState() => _ChatContactState();
}

class _ChatContactState extends State<ChatContact> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('newChatroom')
                  .where('friend', arrayContainsAny: [
                FirebaseAuth.instance.currentUser!.uid
              ]).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text('No contact found'),
                  );
                }

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // Extract necessary data from Firestore snapshot
                    var doc = snapshot.data!.docs[index];
                    String chatroomId = doc.id;
                    String firstUserId = doc['first chat'];
                    String receivedUserId = doc['received chat'];
                    String friendUserId = firstUserId == FirebaseAuth.instance.currentUser!.uid
                        ? receivedUserId
                        : firstUserId;

                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('newChat')
                          .doc(friendUserId)
                          .snapshots(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (!snap.hasData || snap.data!.data() == null) {
                          return SizedBox(); // Handle case where data is null
                        }

                        var friendData = snap.data!.data()!;
                        String friendName = friendData['name'];
                        String friendPhone = friendData['phone'];
                        String friendImage = friendData.containsKey('image')
                            ? friendData['image']
                            : '';

                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Chats(
                                    name: friendName,
                                    imageUrl: friendImage,
                                    id: snap.data!.id,
                                    ChatRoomId: chatroomId,
                                  ),
                                ),
                              );
                            },
                            leading: friendImage.isNotEmpty
                                ? CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(friendImage),
                            )
                                : CircleAvatar(
                              radius: 40,
                              backgroundColor: index == 0
                                  ? Color(0xffc9eded)
                                  : Color(0xff154c79),
                              child: Text(
                                friendName[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              friendName,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            subtitle: Text(friendPhone),
                            trailing: IconButton(
                              onPressed: () {
                                _makePhoneCall(friendPhone);
                              },
                              icon: Icon(Icons.phone),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
