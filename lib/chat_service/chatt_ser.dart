

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chatt_app/resourse/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('ChatApp')
        .snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }
}

 //  Future<void>sendMessage(String receiverID,message)async
 //  {
 //    final String currentUserid= _auth.currentUser!.uid;
 //    final String currentUserEmail= _auth.currentUser!.email.toString();
 //    final Timestamp timestamp=Timestamp.now();
 //
 //
 //    Message newMessage=Message(senderID: currentUserid,
 //        senderEmail: currentUserEmail,
 //        receiverID: receiverID,
 //        message: message,
 //        timestamp: timestamp);
 //    List<String> ids=[currentUserid,receiverID];
 //    ids.sort();
 //    String chatRoomId=ids.join("_");
 //    await _firestore.collection("chat_rooms")
 //        .doc(chatRoomId)
 //        .collection("chats")
 //        .add(newMessage.toMap());
 //  }
 //
 // Stream<QuerySnapshot>getMessage(String userID,oppUserID)
 // {
 //    List<String> ids=[userID,oppUserID];
 //    ids.sort();
 //    String chatRoomId=ids.join('_');
 //    return _firestore.collection("chat_rooms")
 //        .doc(chatRoomId)
 //        .collection("chats")
 //        .orderBy("timestamp",descending: false)
 //        .snapshots();
 // }
 // }

