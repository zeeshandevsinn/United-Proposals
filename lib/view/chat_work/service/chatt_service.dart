// chat service:

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:united_proposals_app/view/chat_work/models/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String recevierId, String message,
      {senderName, receiverName, senderImage, receiverImage, isBlock}) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
      senderId: currentUserId,
      receverId: recevierId,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [currentUserId, recevierId];
    ids.sort();
    print(ids);
    String chatRoomId = ids.join("_");
    await firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
    // debugger();
    await firestore.collection('chat_room').doc(chatRoomId).update({
      'lastMessage': newMessage.message,
      'senderID': currentUserId,
      'receiverID': recevierId,
      'isBlock': isBlock,
      'receiverImage': receiverImage,
      'senderImage': senderImage,
      'senderName': senderName,
      'receiverName': receiverName
    });
    // await firestore.collection("chat_room").doc(chatRoomId).set({
    //   "senderID": currentUserId,
    //   "receiverID": recevierId,
    //   "senderName": senderName,
    //   "receiverName": receiverName,
    //   "lastMessage": newMessage.message,
    //   "receiverImage": receiverImage,
    //   "senderImage": senderImage,
    // });
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    // debugger();
    List<String> ids = [userId, otherUserId];
    print(ids);
    ids.sort();
    String chatRoomId = ids.join("_");
    var userDetails;
    var data = firestore.collection('chat_room').doc(chatRoomId).get();
    userDetails = data;
    // debugger();
    if (userDetails != null) {
      return firestore
          .collection('chat_room')
          .doc(chatRoomId)
          .collection('message')
          .orderBy('timestamp', descending: false)
          .snapshots();
    } else {
      List<String> ids = [otherUserId, userId];
      print(ids);
      ids.sort(((a, b) => a.length.compareTo(b.length)));
      String chatRoomId1 = ids.join("_");
      return firestore
          .collection('chat_room')
          .doc(chatRoomId1)
          .collection('message')
          .orderBy('timestamp', descending: false)
          .snapshots();
    }
  }
}


// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:united_proposals_app/view/chat_work/models/message.dart';
// class ChatService extends ChangeNotifier {
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   Future<void> sendMessage(String recevierId, String message) async {
//     final String currentUserId = firebaseAuth.currentUser!.uid;
//     final Timestamp timestamp = Timestamp.now();
//     Message newMessage = Message(
//       senderId: currentUserId,
//       receverId: recevierId,
//       timestamp: timestamp,
//       message: message,
//     );
//     List<String> ids = [currentUserId, recevierId];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//     debugger();
//     await firestore
//         .collection('chat_room')
//         .doc(chatRoomId)
//         .collection('message')
//         .doc(currentUserId)
//         .set(newMessage.toMap());
//   }
//   Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
//     List<String> ids = [userId, otherUserId];
//     ids.sort();
//     String chatRoomId = ids.join("_");
//     return firestore
//         .collection('chat_room')
//         .doc(chatRoomId)
//         .collection('message')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }
