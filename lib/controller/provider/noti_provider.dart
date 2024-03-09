import 'package:flutter/foundation.dart';
import 'package:united_proposals_app/resources/dummy.dart';
import 'package:united_proposals_app/view/notification/model/noti_model.dart';

class NotiProvider extends ChangeNotifier {


   
  NotiModel notiModel = NotiModel();

  List<NotiModel> notifications = [
    NotiModel(
      id: 1,
      createdAt: DateTime.now(),
      from: "Tessa ",
      event: " has sent you a friend request.",
      // notiType: NotiType.event,
      isSeen: false,
    ),
    NotiModel(
      id: 2,
      createdAt: DateTime.now(),
      from: "Charlie",
      event: " has accepted your request.",
      // notiType: NotiType.addedFlock,
      isSeen: false,
    ),
    NotiModel(
      id: 3,
      createdAt: DateTime.now(),
      from: "Charlie",
      event: " has sent you a friend request.",
      // notiType: NotiType.friendRequestSent,
      isSeen: false,
    ),
    NotiModel(
      id: 4,
      createdAt: DateTime.now(),
      from: "Tessa",
      event: " has accepted your friend request. ",
      // notiType: NotiType.friendRequestAccepted,
      isSeen: false,
    ),
    NotiModel(
      id: 5,
      createdAt: DateTime.now(),
      from: "Tessa",
      event: DummyData.shortText,
      isSeen: false,
    ),
  ];

  void update() {
    notifyListeners();
  }
}
