import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationApi {
  static String notificationCollection = "notifications";

  static var collection =
      FirebaseFirestore.instance.collection(notificationCollection);

  static addNotification({required senderID,required id,required from,required event,required to,required title}) async {
    await collection.add({
      "id": id,
      "senderID": senderID,
      "createdAt": DateTime.now(),
      "from": from,
      "event": event,
      "to":to,
      "title":title
    });
  }

  static removeNotifcation(docID)async{
    await collection.doc(docID).delete();
  }
}
