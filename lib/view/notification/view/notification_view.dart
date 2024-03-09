import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/controller/provider/auth_provider.dart';
import 'package:united_proposals_app/controller/provider/noti_provider.dart';
import 'package:united_proposals_app/view/notification/view/noti_widget.dart';

import '../api/notification_apis.dart';
import '../model/noti_model.dart';

class NotificationView extends StatefulWidget {
  static String route = '/notificationView';

  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<String> list = [];
  @override
  Widget build(BuildContext context) {
    // final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return StreamBuilder(
        stream: NotificationApi.collection
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot data = snapshot.data;
            return Scaffold(
              appBar: GlobalWidgets.appBar("Notifications"),
              body: data.docs.isEmpty
                  ? const Center(
                      child: Text("No Notification"),
                    )
                  : SlidableAutoCloseBehavior(
                      child: ListView.builder(
                        padding: EdgeInsets.all(15.sp),
                        reverse:
                            true, // Set this property to true to reverse the order
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          var item = data.docs[index];
                          NotiModel model = NotiModel(
                            title: item.get("title"),
                            to: item.get("to"),
                            from: item.get("from"),
                            id: item.get("id"),
                            redirectId: item.get("senderID"),
                            createdAt: item.get("createdAt"),
                            event: item.get("event"),
                          );
                          return NotiWidget(
                            id: item.id,
                            model: model,
                            text: model,
                          );
                        },
                      ),
                    ),
            );
          }

          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        });
  }
}
