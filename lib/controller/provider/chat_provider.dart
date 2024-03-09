import 'package:flutter/material.dart';
// import '../../view/chat/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // List<ChatModel> listOfChatModel = [
  //   ChatModel(
  //       isRead: false,
  //       userImage: AppImages.dummyImage,
  //       userName: "  ",
  //       time: DateTime.now()),
  //   ChatModel(
  //       isRead: true,
  //       userImage: AppImages.dummyImage,
  //       userName: "Alexander A.",
  //       time: DateTime.now()),
  //   ChatModel(
  //       isRead: true,
  //       userImage: AppImages.dummyImage,
  //       userName: "William M.",
  //       time: DateTime.now()),
  // ];

  // List<ChatMessageModel> chatMessageList = [
  //   ChatMessageModel(
  //       time: DateTime.now(),
  //       message: "Hello!",
  //       isReceiver: false,
  //       isOffer: false,
  //       price: 0,
  //       title: ""),
  //   ChatMessageModel(
  //       time: DateTime.now(),
  //       message: "How are you?",
  //       isReceiver: true,
  //       isOffer: false,
  //       price: 0,
  //       title: ""),
  //   ChatMessageModel(
  //       time: DateTime.now(),
  //       message: "How are you?",
  //       isReceiver: true,
  //       isOffer: false,
  //       price: 0,
  //       title: ""),
  //   ChatMessageModel(
  //       time: DateTime.now(),
  //       message: "I am waiting.",
  //       isReceiver: false,
  //       isOffer: true,
  //       price: 20,
  //       title: "test"),
  //   ChatMessageModel(
  //       time: DateTime.now(),
  //       message: "I am waiting for your response,..",
  //       isReceiver: false,
  //       isOffer: false,
  //       price: 0,
  //       title: ""),
  // ];

  void update() {
    notifyListeners();
  }
}
