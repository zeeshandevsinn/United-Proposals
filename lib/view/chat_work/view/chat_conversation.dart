// chat conversation:

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/chat_work/service/chatt_service.dart';
import 'package:united_proposals_app/view/notification/api/notification_apis.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

import '../../../models/user_model.dart';
import '../../../utils/zbotToast.dart';

// import '../../../controller/provider/chat_provider.dart';

// ignore: must_be_immutable
class ChatBetweenUsers extends StatefulWidget {
  static String route = '/ChatBetweenUsers';
  var reciverUserID;
  var Image;
  var Name;
  UserModel? model;
  ChatBetweenUsers(
      {super.key, this.reciverUserID, this.Image, this.Name, this.model});

  @override
  State<ChatBetweenUsers> createState() => _ChatBetweenUsersState();
}

class _ChatBetweenUsersState extends State<ChatBetweenUsers> {
  bool noBNav = false;
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  // final ScrollController _scrollController = ScrollController();
  dynamic args;
  ScrollController scrollController = ScrollController();
  getUserProfile(id) async {
    ZBotToast.loadingShow();
    var data =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    ZBotToast.loadingClose();
    userDetails = data;

    profileDetailModel = await UserModel.fromDocumentSnapshot(data);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    // blocking();
    checkBlocking();
    getUserProfile(widget.reciverUserID);
    getCurrentUserProfile();

    Future.delayed(Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
    super.initState();
  }

  getCurrentUserProfile() async {
    ZBotToast.loadingShow();
    var id = FirebaseAuth.instance.currentUser?.uid;
    var data =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    ZBotToast.loadingClose();
    CurrentUserDetails = data;
    setState(() {});
  }

  var CurrentUserDetails;
  var userDetails;

  UserModel? profileDetailModel;

  // DocumentSnapshot? blockcheck;
  checkBlocking() async {
    var firestore = FirebaseFirestore.instance;
    List<String> ids = [
      FirebaseAuth.instance.currentUser!.uid,
      widget.reciverUserID
    ];
    print(ids);
    ids.sort();

    String chatRoomId = ids.join("_");
    // ignore: unused_local_variable
    var data = await firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .get()
        .then((snapshot) {
      // print(data);
      if (snapshot.exists) {
        // var data = snapshot.data();
        if (snapshot.get('isBlock')) {
          bool isBlock = snapshot.get('isBlock');

          setState(() {
            selectBlock = isBlock;
          });
        }
      }
    });
  }

  // isBlock() {
  //   var firestore = FirebaseFirestore.instance;
  //   List<String> ids = [
  //     FirebaseAuth.instance.currentUser!.uid,
  //     widget.reciverUserID
  //   ];
  //   print(ids);
  //   ids.sort();
  //   String chatRoomId = ids.join("_");

  //   firestore
  //       .collection('chat_room')
  //       .doc(chatRoomId)
  //       .get()
  //       .then((DocumentSnapshot snapshot) async {
  //     if (snapshot.exists) {
  //       var id = FirebaseAuth.instance.currentUser?.uid;
  //       if (snapshot.get('isBlock') && snapshot.get('senderID') == id) {
  //         debugger();
  //         await FirebaseFirestore.instance
  //             .collection('Block_user')
  //             .doc(widget.reciverUserID)
  //             .collection('users')
  //             .doc(id)
  //             .set({
  //           "isBlocked": false,
  //         });
  //         await FirebaseFirestore.instance
  //             .collection('chat_room')
  //             .doc(chatRoomId)
  //             .update({'isBlock': false});
  //       } else if (snapshot.get('isBlock') == false) {
  //         debugger();
  //         await FirebaseFirestore.instance
  //             .collection('Block_user')
  //             .doc(widget.reciverUserID)
  //             .collection('users')
  //             .doc(id)
  //             .set({
  //           "isBlocked": true,
  //         });
  //         await FirebaseFirestore.instance
  //             .collection('chat_room')
  //             .doc(chatRoomId)
  //             .update({'isBlock': true});
  //       } else {
  //         ZBotToast.showToastError(message: "SomeThing Wrong!");
  //       }
  //     }
  //   });
  // }

  // check() async {
  //   var firestore = FirebaseFirestore.instance;
  //   List<String> ids = [
  //     FirebaseAuth.instance.currentUser!.uid,
  //     widget.reciverUserID
  //   ];
  //   print(ids);
  //   ids.sort();
  //   String chatRoomId = ids.join("_");
  //   debugger();
  //   // blocking();
  //   await firestore
  //       .collection("chat_room")
  //       .doc(chatRoomId)
  //       .get()
  //       .then((DocumentSnapshot snapshot) {
  //     debugger();
  //     // blockcheck = snapshot.data();
  //     print(snapshot.data());
  //     if (snapshot.exists) {
  //       if (snapshot.get('isBlock') &&
  //           snapshot.get('senderID') ==
  //               FirebaseAuth.instance.currentUser?.uid) {
  //         firestore
  //             .collection("chat_room")
  //             .doc(chatRoomId)
  //             .update({'isBlock': false});
  //         bool isBlock = snapshot.get('isBlock');
  //         // Update UI state based on this 'isLiked' value
  //         setState(() {
  //           // Update the local state in both screens
  //           selectBlock = isBlock;
  //         });
  //       } else if (snapshot.get('isBlock') == false) {
  //         firestore
  //             .collection("chat_room")
  //             .doc(chatRoomId)
  //             .update({'isBlock': true});
  //         bool isBlock = snapshot.get('isBlock');
  //         // Update UI state based on this 'isLiked' value
  //         setState(() {
  //           // Update the local state in both screens
  //           selectBlock = isBlock;
  //         });
  //       } else {
  //         ZBotToast.showToastError(message: "SomeThing Went Wrong!");
  //       }
  //       // Extract the 'isLike' field value from the snapshot
  //     }
  //   });
  // }

  bool selectBlock = false;
  @override
  Widget build(BuildContext context) {
    // return Consumer<ChatProvider>(builder: (context, chatVM, _) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: chatAppBar(),
      // ignore: unnecessary_null_comparison
      body: selectBlock == null
          ? CircularProgressIndicator.adaptive()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Text(
                    DateFormat("EEEE, hh:mm a").format(DateTime.now()),
                    textAlign: TextAlign.end,
                    style: AppTextStyles.poppinsRegular(
                      fontSize: 8.sp,
                      color: const Color(0xffB0AFB8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: buildMessageList(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: selectBlock
                            ? Text("Person has Been Blocked!")
                            : TextFormField(
                                controller: controller,
                                maxLines: 3,
                                minLines: 1,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  hintText: "Write a Message...",
                                  hintStyle: AppTextStyles.poppinsRegular(
                                    fontSize: 12.sp,
                                    color: AppColors.lightGrey,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  filled: true,
                                  isDense: true,
                                  fillColor: AppColors.white,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22),
                                    borderSide:
                                        const BorderSide(color: AppColors.grey),
                                  ),
                                ),
                              ),
                      ),
                      selectBlock
                          ? Container()
                          : InkWell(
                              onTap: () async {
                                // debugger();
                                if (controller.text.isNotEmpty) {
                                  chatService.sendMessage(
                                      widget.reciverUserID, controller.text,
                                      receiverImage: widget.Image,
                                      senderImage: CurrentUserDetails.get(
                                          'profileImage'),
                                      senderName:
                                          CurrentUserDetails.get('firstName'),
                                      isBlock: selectBlock,
                                      receiverName: widget.Name);
                                  NotificationApi.addNotification(
                                      title:
                                          "${CurrentUserDetails.get('firstName')} sends a message",
                                      event: controller.text,
                                      senderID: null,
                                      id: widget.reciverUserID,
                                      from: CurrentUserDetails.get('firstName'),
                                      to: widget.Name);
                                  controller.clear();
                                  Future.delayed(Duration(seconds: 1), () {
                                    scrollController.animateTo(
                                      scrollController.position.maxScrollExtent,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 2.w),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.4.h, horizontal: 3.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Image.asset(
                                  AppImages.sendMessageIcon,
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // final ScrollController _controller = ScrollController();
  // _scrollDown() {
  //   try {
  //     debugger();
  //     _controller.animateTo(
  //       _controller.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 500),
  //       curve: Curves.easeInOut,
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     ZBotToast.showToastError(message: e.toString());
  //   }
  // }

  Widget buildMessageList() {
    return StreamBuilder(
        stream: ChatService().getMessage(
          widget.reciverUserID,
          FirebaseAuth.instance.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Erorr${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          } else {
            // debugger();
            return ListView(
              controller: scrollController,
              children: snapshot.data!.docs
                  .map<Widget>((document) => buildMessageItem(document))
                  .toList(),
            );
          }
        });
  }

  Widget buildMessageItem(var document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data['senderId'] == FirebaseAuth.instance.currentUser!.uid) {
      return sender(message: data['message'], time: data['timestamp'].toDate());
    } else {
      return receiver(
          message: data['message'], time: data['timestamp'].toDate());
    }
  }

  AppBar chatAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: AppColors.white,
      toolbarHeight: 70,
      centerTitle: false,
      leadingWidth: 5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_outlined,
                color: AppColors.black,
              ),
            ),
          ),
          w3,
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                // debugger();
                visitProfileFn();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ProfileDetailScreen(
                //               model: widget.model,
                //             )));
              },
              child: CachedNetworkImage(
                imageUrl: widget.Image ?? AppImages.dummyImage,
                imageBuilder: (context, imageProvider) => Container(
                  height: 10.w,
                  width: 10.w,
                  // height: 40,
                  // width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
                errorWidget: (context, url, e) => const Icon(Icons.error),
                placeholder: (context, url) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive(
                    backgroundColor: AppColors.primary,
                  ));
                },
              ),
            ),
          ),
          w2,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  widget.Name ?? "Alexander",
                  style: AppTextStyles.poppinsRegular(
                    color: AppColors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: AppColors.primary,
            child: PopupMenuButton(
              surfaceTintColor: Colors.black,
              // initialValue: 1,
              // Callback that sets the selected popup menu item.
              onSelected: (item) {
                if (item == 1) {
                  // debugger();
                  _showBlockDialog(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: selectBlock ? Text('UnBlock') : Text('Block'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void visitProfileFn() {
    Get.toNamed(ProfileDetailScreen.route,
        arguments: {"model": profileDetailModel});
  }

  _showBlockDialog(BuildContext context) {
    // debugger();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: selectBlock ? Text('UnBlock User?') : Text('Block User?'),
          content: selectBlock
              ? Text('Are you sure you want to Unblock this user?')
              : Text('Are you sure you want to block this user?'),
          actions: [
            TextButton(
              onPressed: () async {
                ZBotToast.loadingShow();

                // if (blockcheck?.get('isBlock') &&
                //     blockcheck?.get('senderID') ==
                //         FirebaseAuth.instance.currentUser?.uid) {
                //   await UnBlock();
                //   await chatService.sendMessage(
                //       widget.reciverUserID, "UnBlocked",
                //       receiverImage: widget.Image,
                //       senderImage: CurrentUserDetails.get('profileImage'),
                //       senderName: CurrentUserDetails.get('firstName'),
                //       isBlock: selectBlock,
                //       receiverName: widget.Name);
                //   ZBotToast.loadingClose();
                //   ZBotToast.showToastSuccess(message: "User has been Blocked");
                //   Navigator.pop(context);
                // } else if (blockcheck?.get('isBlock') == false) {
                //   await block();
                //   await chatService.sendMessage(widget.reciverUserID, "Blocked",
                //       receiverImage: widget.Image,
                //       senderImage: CurrentUserDetails.get('profileImage'),
                //       senderName: CurrentUserDetails.get('firstName'),
                //       isBlock: selectBlock,
                //       receiverName: widget.Name);
                //   ZBotToast.loadingClose();
                //   ZBotToast.showToastSuccess(message: "User has been Blocked");
                //   Navigator.pop(context);
                // } else {
                //   ZBotToast.loadingClose();
                //   ZBotToast.showToastError(message: "Error!!");
                // }

                var firestore = FirebaseFirestore.instance;
                // Handle 'Yes' button press
                List<String> ids = [
                  FirebaseAuth.instance.currentUser!.uid,
                  widget.reciverUserID
                ];
                print(ids);
                ids.sort();
                String chatRoomId = ids.join("_");

                var data = await firestore
                    .collection('chat_room')
                    .doc(chatRoomId)
                    .get();
                // debugger();
                print(data);
                // ignore: unnecessary_null_comparison
                if (data != null && selectBlock) {
                  //for Unblock
                  // debugger();
                  if (data.get('senderID') ==
                      FirebaseAuth.instance.currentUser?.uid) {
                    // await chatService.sendMessage(
                    //     widget.reciverUserID, "Unblocked",
                    //     receiverImage: widget.Image,
                    //     senderImage: CurrentUserDetails.get('profileImage'),
                    //     senderName: CurrentUserDetails.get('firstName'),
                    //     isBlock: selectBlock,
                    //     receiverName: widget.Name);
                    await firestore
                        .collection('chat_room')
                        .doc(chatRoomId)
                        .update({'isBlock': false});

                    await chatService.sendMessage(
                        widget.reciverUserID, "UnBlocked",
                        receiverImage: widget.Image,
                        senderImage: CurrentUserDetails.get('profileImage'),
                        senderName: CurrentUserDetails.get('firstName'),
                        isBlock: false,
                        receiverName: widget.Name);
                    await checkBlocking();
                    setState(() {
                      selectBlock = false;
                    });
                    ZBotToast.loadingClose();
                    ZBotToast.showToastSuccess(
                        message: "User has been UnBlocked");
                  } else {
                    ZBotToast.loadingClose();
                    ZBotToast.showToastError(
                        message: "User already Blocked You!");
                  }

                  Navigator.pop(context);
                } else if (data!.get('isBlock') == false) {
                  //for Block
                  // debugger();
                  // await
                  // await blocking();

                  await firestore
                      .collection('chat_room')
                      .doc(chatRoomId)
                      .update({'isBlock': true});
                  await chatService.sendMessage(widget.reciverUserID, "Blocked",
                      receiverImage: widget.Image,
                      senderImage: CurrentUserDetails.get('profileImage'),
                      senderName: CurrentUserDetails.get('firstName'),
                      isBlock: true,
                      receiverName: widget.Name);
                  // debugger();
                  await checkBlocking();
                  setState(() {
                    selectBlock = true;
                  });
                  ZBotToast.loadingClose();
                  ZBotToast.showToastSuccess(message: "User has been Blocked");
                  Navigator.pop(context);
                } else {
                  ZBotToast.loadingClose();
                  ZBotToast.showToastError(message: 'Something Went Wrong!');
                }

                // Add your logic here for blocking the user
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Handle 'No' button press
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  /// Send Message
  Widget sender({required String message, required DateTime time}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                  bottomLeft: Radius.circular(34),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 60.w,
                  minHeight: 3.h,
                ),
                child: Text(
                  message,
                  style: AppTextStyles.poppinsRegular(
                    fontSize: 10.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            h0P6,
            Text(
              DateFormat("hh:mm a").format(time),
              textAlign: TextAlign.end,
              style: AppTextStyles.poppinsRegular(
                fontSize: 8.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Message You Receive
  Widget receiver({
    required String message,
    required DateTime time,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            w1,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(34),
                        topRight: Radius.circular(34),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(34),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.26),
                          offset: const Offset(10.0, 0),
                          blurRadius: 35.0,
                        ),
                      ]),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 60.w,
                      minHeight: 3.h,
                    ),
                    child: Text(
                      message,
                      style: AppTextStyles.poppinsRegular(
                        color: AppColors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                h0P6,
                Text(
                  DateFormat("hh:mm a").format(time),
                  textAlign: TextAlign.end,
                  style: AppTextStyles.poppinsRegular(
                    color: AppColors.black,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:united_proposals_app/resources/app_images.dart';
// import 'package:united_proposals_app/utils/app_colors.dart';
// import 'package:united_proposals_app/utils/height_widths.dart';
// import 'package:united_proposals_app/utils/text_style.dart';
// import 'package:united_proposals_app/view/chat_work/service/chatt_service.dart';
// // import '../../../controller/provider/chat_provider.dart';
// // ignore: must_be_immutable
// class ChatBetweenUsers extends StatefulWidget {
//   static String route = '/ChatBetweenUsers';
//   var reciverUserID;
//   var Image;
//   var Name;
//   ChatBetweenUsers(
//       {super.key, required this.reciverUserID, this.Image, this.Name});
//   @override
//   State<ChatBetweenUsers> createState() => _ChatBetweenUsersState();
// }
// class _ChatBetweenUsersState extends State<ChatBetweenUsers> {
//   bool noBNav = false;
//   final ChatService chatService = ChatService();
//   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   TextEditingController controller = TextEditingController();
//   // final ScrollController _scrollController = ScrollController();
//   dynamic args;
//   // ChatModel? model;
//   // @override
//   // void initState() {
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   //     args = ModalRoute.of(context)?.settings.arguments;
//   //     if (args['model'] != null) {
//   //       model = args['model'];
//   //       setState(() {});
//   //     }
//   //     _scrollDown();
//   //   });
//   //   super.initState();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     // return Consumer<ChatProvider>(builder: (context, chatVM, _) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: chatAppBar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 2.h),
//             child: Text(
//               DateFormat("EEEE, hh:mm a").format(DateTime.now()),
//               textAlign: TextAlign.end,
//               style: AppTextStyles.poppinsRegular(
//                 fontSize: 8.sp,
//                 color: const Color(0xffB0AFB8),
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//           Expanded(
//             child: buildMessageList(),
//             //  ListView(
//             //   controller: _scrollController,
//             //   children: List.generate(chatVM.chatMessageList.length, (index) {
//             //     if (chatVM.chatMessageList[index].isReceiver) {
//             //       return sender(
//             //         message: chatVM.chatMessageList[index].message ?? '',
//             //         time:
//             //             chatVM.chatMessageList[index].time ?? DateTime.now(),
//             //       );
//             //     } else {
//             //       return receiver(
//             //         message: chatVM.chatMessageList[index].message ?? '',
//             //         time:
//             //             chatVM.chatMessageList[index].time ?? DateTime.now(),
//             //       );
//             //     }
//             //   }),
//             // ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: controller,
//                     // onFieldSubmitted: (val) {
//                     // if (controller.text.isNotEmpty) {
//                     //   chatVM.chatMessageList.add(
//                     //     ChatMessageModel(
//                     //         time: DateTime.now(),
//                     //         message: val,
//                     //         isReceiver: true,
//                     //         isOffer: false,
//                     //         price: 0,
//                     //         title: ""),
//                     //   );
//                     //   chatVM.update();
//                     //     controller.clear();
//                     //     ///Scroll
//                     //     _scrollDown();
//                     //   }
//                     // },
//                     maxLines: 3,
//                     minLines: 1,
//                     textInputAction: TextInputAction.newline,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 15),
//                       hintText: "Write a Message...",
//                       hintStyle: AppTextStyles.poppinsRegular(
//                         fontSize: 12.sp,
//                         color: AppColors.lightGrey,
//                         fontWeight: FontWeight.w300,
//                       ),
//                       filled: true,
//                       isDense: true,
//                       fillColor: AppColors.white,
//                       errorBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(22),
//                         borderSide: const BorderSide(color: AppColors.grey),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(22),
//                         borderSide: const BorderSide(color: AppColors.grey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(22),
//                         borderSide: const BorderSide(color: AppColors.grey),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(22),
//                         borderSide: const BorderSide(color: AppColors.gre
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     if (controller.text.isNotEmpty) {
//                       chatService.sendMessage(
//                           widget.reciverUserID, controller.text);
//                       controller.clear();
//                       // chatVM.chatMessageList.add(
//                       //   ChatMessageModel(
//                       //       time: DateTime.now(),
//                       //       message: controller.text.trim(),
//                       //       isReceiver: true,
//                       //       isOffer: false,
//                       //       price: 0,
//                       //       title: ""),
//                       // );
//                       // chatVM.update();
//                       ///Scroll
//                       // _scrollDown();
//                     }
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(left: 2.w),
//                     padding:
//                         EdgeInsets.symmetric(vertical: 1.4.h, horizontal: 3.w),
//                     decoration: BoxDecoration(
//                       color: AppColors.primary,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Image.asset(
//                       AppImages.sendMessageIcon,
//                       height: 28,
//                       width: 28,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget buildMessageList() {
//     return StreamBuilder(
//         stream: ChatService().getMessage(
//           widget.reciverUserID,
//           FirebaseAuth.instance.currentUser!.uid,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Erorr${snapshot.error}');
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text('Loading...');
//           } else {
//             return ListView(
//               children: snapshot.data!.docs
//                   .map<Widget>((document) => buildMessageItem(document))
//                   .toList(),
//             );
//           }
//         });
//   }
//   Widget buildMessageItem(var document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//     if (data['senderId'] == FirebaseAuth.instance.currentUser!.uid) {
//       return sender(message: data['message'], time: data['timestamp'].toDate());
//     } else {
//       return receiver(
//           message: data['message'], time: data['timestamp'].toDate());
//     }
//   }
//   AppBar chatAppBar() {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       elevation: 0,
//       backgroundColor: AppColors.white,
//       toolbarHeight: 70,
//       centerTitle: false,
//       leadingWidth: 5,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () {
//               Get.back();
//             },
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(
//                 Icons.arrow_back_outlined,
//                 color: AppColors.black,
//               ),
//             ),
//           ),
//           w3,
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: CachedNetworkImage(
//               imageUrl: widget.Image ?? AppImages.dummyImage,
//               imageBuilder: (context, imageProvider) => Container(
//                 height: 10.w,
//                 width: 10.w,
//                 // height: 40,
//                 // width: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: AppColors.primary,
//                     width: 1,
//                   ),
//                   image: DecorationImage(
//                     image: imageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               fit: BoxFit.cover,
//               errorWidget: (context, url, e) => const Icon(Icons.error),
//               placeholder: (context, url) {
//                 return const Center(
//                     child: CircularProgressIndicator.adaptive(
//                   backgroundColor: AppColors.primary,
//                 ));
//               },
//             ),
//           ),
//           w2,
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.Name ?? "",
//                 style: AppTextStyles.poppinsRegular(
//                   color: AppColors.grey,
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//   /// Send Message
//   Widget sender({required String message, required DateTime time}) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               margin: const EdgeInsets.symmetric(vertical: 5),
//               decoration: const BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(34),
//                   topRight: Radius.circular(34),
//                   bottomLeft: Radius.circular(34),
//                   bottomRight: Radius.circular(0),
//                 ),
//               ),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxWidth: 60.w,
//                   minHeight: 3.h,
//                 ),
//                 child: Text(
//                   message,
//                   style: AppTextStyles.poppinsRegular(
//                     fontSize: 10.sp,
//                     color: AppColors.white,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//             h0P6,
//             Text(
//               DateFormat("hh:mm a").format(time),
//               textAlign: TextAlign.end,
//               style: AppTextStyles.poppinsRegular(
//                 fontSize: 8.sp,
//                 color: AppColors.black,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   /// Message You Receive
//   Widget receiver({
//     required String message,
//     required DateTime time,
//   }) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             w1,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(34),
//                         topRight: Radius.circular(34),
//                         bottomLeft: Radius.circular(0),
//                         bottomRight: Radius.circular(34),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.grey.withOpacity(0.26),
//                           offset: const Offset(10.0, 0),
//                           blurRadius: 35.0,
//                         ),
//                       ]),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: 60.w,
//                       minHeight: 3.h,
//                     ),
//                     child: Text(
//                       message,
//                       style: AppTextStyles.poppinsRegular(
//                         color: AppColors.black,
//                         fontSize: 10.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ),
//                 h0P6,
//                 Text(
//                   DateFormat("hh:mm a").format(time),
//                   textAlign: TextAlign.end,
//                   style: AppTextStyles.poppinsRegular(
//                     color: AppColors.black,
//                     fontSize: 8.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//   // void _scrollDown() {
//   //   _scrollController.animateTo(
//   //     _scrollController.position.maxScrollExtent + 100.h,
//   //     duration: const Duration(milliseconds: 500),
//   //     curve: Curves.easeOut,
//   //   );
//   // }
