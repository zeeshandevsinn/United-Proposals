import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/image_widget/image_widget.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/chat_work/models/message.dart';
import 'package:united_proposals_app/view/root_screen.dart';

import '../../utils/height_widths.dart';
import '../notification/api/notification_apis.dart';
import '../profile_detail_screen.dart';

class RequestTileWidget extends StatefulWidget {
  final UserModel model;
  const RequestTileWidget({super.key, required this.model});

  @override
  State<RequestTileWidget> createState() => _RequestTileWidgetState();
}

class _RequestTileWidgetState extends State<RequestTileWidget> {
  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  getUserProfile() async {
    // ZBotToast.loadingShow();
    var id = FirebaseAuth.instance.currentUser?.uid;
    var data =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    // debugger();
    // log(data.data() as String);
    userDetails = data;
    // ZBotToast.loadingClose();
    setState(() {});
  }

  var userDetails;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileDetailScreen(
                        model: widget.model,
                      )));
        },
        child: Container(
          width: 100.w,
          margin: EdgeInsets.only(bottom: 3.w),
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                offset: const Offset(3, 3.0),
                blurRadius: 10.0,
              ),
              BoxShadow(
                color: AppColors.lightGrey.withOpacity(0.2),
                offset: const Offset(-3, -3.0),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                ImageWidget(
                  profileImage: widget.model.profileImage ?? "",
                  size: 18.w,
                  isRadius: true,
                ),
                w2,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.model.firstName ?? "",
                              style:
                                  AppTextStyles.poppinsMedium(fontSize: 11.sp),
                            ),
                            Text(
                              widget.model.dateOfBirth.toString(),
                              style:
                                  AppTextStyles.poppinsRegular(fontSize: 10.sp),
                            ),
                            Text(
                              widget.model.maritalStatus,
                              style:
                                  AppTextStyles.poppinsRegular(fontSize: 10.sp),
                            ),
                            Text(
                              widget.model.location ?? "",
                              style:
                                  AppTextStyles.poppinsRegular(fontSize: 10.sp),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              acceptRequestFn();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: AppColors.primary,
                              ),
                              child: Text(
                                "Accept Request",
                                style: AppTextStyles.poppinsMedium(
                                  fontSize: 8.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          // Spacer(),
                          // InkWell(
                          //   onTap: () {
                          //     acceptRequestFn();
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(5.sp),
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(6.0),
                          //       color: AppColors.themeYellow,
                          //     ),
                          //     child: Text(
                          //       "Reject Request",
                          //       style: AppTextStyles.poppinsMedium(
                          //         fontSize: 8.sp,
                          //         color: AppColors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  acceptRequestFn() async {
    try {
      ZBotToast.loadingShow();
      var uid = FirebaseAuth.instance.currentUser?.uid;

      List<String> ids = [uid.toString(), widget.model.id];
      ids.sort();
      String chatRoomId = ids.join("_");
      // debugger();
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(uid.toString())
          .collection('users')
          .doc(widget.model.id.toString())
          .update({'acceptRequest': true});
      Message newMessage = Message(
        senderId: uid.toString(),
        receverId: widget.model.id,
        timestamp: Timestamp.now(),
        message: "Say Hi",
      );

      await FirebaseFirestore.instance
          .collection("chat_room")
          .doc(chatRoomId)
          .collection('message')
          .add(newMessage.toMap());
      await FirebaseFirestore.instance
          .collection('chat_room')
          .doc(chatRoomId)
          .set({
        "senderID": uid,
        "receiverID": widget.model.id,
        "senderName": userDetails.get('firstName'),
        "receiverName": widget.model.firstName,
        "lastMessage": newMessage.message,
        "receiverImage": userDetails.get('profileImage'),
        "senderImage": widget.model.profileImage,
        "isBlock": false,
      });

      await FirebaseFirestore.instance
          .collection("requests")
          .doc(widget.model.id)
          .collection("users")
          .doc(uid)
          .set(userDetails.data());
      await FirebaseFirestore.instance
          .collection("requests")
          .doc(widget.model.id)
          .collection("users")
          .doc(uid)
          .update({'isRequestPlaced': true, 'acceptRequest': true});

      await NotificationApi.addNotification(
          title: "${userDetails.get('firstName')} Accepted a Friend Request",
          event: "Request Accept",
          senderID: uid,
          id: widget.model.id,
          from: userDetails.get('firstName'),
          to: widget.model.firstName);
      ZBotToast.loadingClose();
      ZBotToast.showToastSuccess(message: "Request Accept Check Inbox!");
      // ZBotToast.showToastSuccess(message: "!");
      // Get.toNamed(RootScreen.route);
      // context.read<RootProvider>().pageController.jumpToPage(3);
    } catch (e) {
      ZBotToast.loadingClose();

      ZBotToast.showToastError(message: e.toString());
    }
  }
}
