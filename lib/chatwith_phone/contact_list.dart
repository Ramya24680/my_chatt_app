// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import '../chat_app/chat_screen.dart';
// // import 'chats.dart';
// //
// // class ContactsListPage extends StatefulWidget {
// //   @override
// //   _ContactsListPageState createState() => _ContactsListPageState();
// // }
// //
// // class _ContactsListPageState extends State<ContactsListPage> {
// //   List contacts = [];
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: StreamBuilder(
// //               stream: FirebaseFirestore.instance
// //                   .collection('mobileChat')
// //                   .snapshots(),
// //               builder: (context, snapshot) {
// //                 print(snapshot.data!.docs.length);
// //                 int length = snapshot.data!.docs.length;
// //                 return snapshot.data?.docs.length == null
// //                     ? CircularProgressIndicator()
// //                     : ListView.builder(
// //                         itemCount: length,
// //                         itemBuilder: (BuildContext context, int index) {
// //                           return Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 horizontal: 10, vertical: 5),
// //                             child: Card(
// //                               color: Colors.green.shade300,
// //                               elevation: 5,
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(15),
// //                               ),
// //                               child: ListTile(
// //                                 leading:
// //                                     snapshot.data!.docs[index]['image'] != null
// //                                         ? CircleAvatar(
// //                                             backgroundImage: NetworkImage(
// //                                                 snapshot.data!.docs[index]
// //                                                     ['image']),
// //                                           )
// //                                         : CircleAvatar(
// //                                             child: Icon(Icons.person),
// //                                           ),
// //                                 title: Text(snapshot.data!.docs[index]['name']),
// //                                 subtitle:
// //                                     Text(snapshot.data!.docs[index]['phone']),
// //                                 trailing: Icon(Icons.arrow_forward_ios),
// //                                 onTap: () {
// //                                   FirebaseFirestore.instance
// //                                       .collection('chatroom')
// //                                       .doc(FirebaseAuth
// //                                               .instance.currentUser!.uid +
// //                                           snapshot.data!.docs[index].id)
// //                                       .set({
// //                                     "friend":FirebaseAuth.instance.currentUser!.uid+
// //                                     snapshot.data!.docs[index].id,
// //
// //                                     "date":DateTime.now(),
// //                                     "status":""
// //
// //                                   }).then((value) {
// //                                     Navigator.push(
// //                                       context,
// //                                       MaterialPageRoute(
// //                                         builder: (context) => ChatScreendetail(
// //                                             name: snapshot.data!.docs[index]
// //                                                 ['name'],
// //                                             imageUrl: snapshot.data!.docs[index]
// //                                                     ['image'] ??
// //                                                 '',
// //                                             id: snapshot.data!.docs[index].id),
// //                                       ),
// //                                     );
// //                                   });
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chatt_app/chatwith_phone/search_page.dart';

import 'chats.dart';
class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Column(
        children: [
          Expanded(child: StreamBuilder(
            stream: FirebaseFirestore.instance
            .collection('chatroom').where('friend',arrayContainsAny:
            [FirebaseAuth.instance.currentUser!.uid]).snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Text('No contact found'),
                );
              }
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                  itemBuilder:(context,index){
                  String image='';
                  if(snapshot.data!.docs[index]
                  .data().containsKey('image')){
                    image=snapshot.data!.docs[index]['image'];
                  }
                  return StreamBuilder(stream: FirebaseFirestore.instance
                      .collection('mobileChat')
                      .doc(snapshot.data!.docs[index]['first chat']==
                  FirebaseAuth.instance.currentUser!.uid
                  ?snapshot.data!.docs[index]['received chat']
                  :snapshot.data!.docs[index]['first chat']).snapshots(),
                       builder: (context,snap){
                    if(snap.hasData) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                ChatScreendetail(
                                  name: snap.data!['name'],
                                  // imageUrl: snapshot.data!.docs[index]['image'],
                                  // imageUrl: image,
                                  imageUrl: snap.data!['image'],
                                  // id: snapshot.data!.docs[index]['id'],
                                  id: snap.data!.id,
                                  chatroomid: snapshot.data!.docs[index].id,
                                )));
                          },
                          leading: image == ""
                              ? CircleAvatar(radius: 40,
                              backgroundColor: index == 0
                                  ? Colors.green
                                  : Colors.green.shade300,
                              child: Text(snap.data!['name'][0],
                                style: TextStyle(color: Colors.white),
                              )
                          ) :
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(image),
                          ),
                          // ? CircleAvatar(
                          //   radius: 40,
                          //   backgroundImage: NetworkImage(image),
                          // ):
                          // CircleAvatar(radius: 40,
                          //     backgroundColor: index == 0
                          //         ? Colors.green
                          //         : Colors.green.shade300,
                          //     child: Text(snap.data!['name'][0],
                          //       style: TextStyle(color: Colors.white),
                          //     )
                          // ) ,

                          title: Text(snap.data!['name'],
                            style: TextStyle(fontWeight: FontWeight.w400),),
                          subtitle: Text(snap.data!['phone']),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_ios),
                          ),

                        ),
                      );
                    }else
                      {
                        return CircularProgressIndicator();
                      }
                  });
                  });
            },
          )
    ),
        ],
      ),
    );
  }
}

