// chat Tile:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../models/chat_model.dart';
// import '../../../../controller/provider/chat_provider.dart';
import '../chat_conversation.dart';

class ChatTileWidget extends StatefulWidget {
  // final ChatModel? model;
  Map document;
  String name;
  String imageurl;
  String userID;
  String lastMessageText;
  ChatTileWidget(
      {super.key,
      required this.document,
      required this.name,
      required this.imageurl,
      required this.userID,
      required this.lastMessageText});

  @override
  State<ChatTileWidget> createState() => _ChatTileWidgetState();
}

class _ChatTileWidgetState extends State<ChatTileWidget> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    print(widget.userID.toString() + "testing id of receiver");
    print(FirebaseAuth.instance.currentUser!.uid.toString() + "current ID");
    Map<String, dynamic> data = widget.document as Map<String, dynamic>;
    // return Consumer<ChatProvider>(builder: (context, chatVm, _) {

    return Padding(
      padding: EdgeInsets.only(
        bottom: 1.2.h,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: .12,
          //openThreshold: 0.25,closeThreshold: 0.22,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                deleteChatRoom(data['room_id']);
              },
              backgroundColor: AppColors.lightRed,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(8),
              autoClose: true,
              child: ImageIcon(
                AssetImage(AppImages.deleteImageIcon),
                color: AppColors.red,
                size: 13.sp,
              ),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChatBetweenUsers(
                reciverUserID: widget.userID,
                Image: widget.imageurl,
                Name: widget.name,
              );
            }));
          },
          child: Container(
            width: 100.w,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.unReadColor,
              // : AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.16),
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageurl ?? AppImages.dummyImage,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 13.w,
                      width: 13.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 1),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, e) => SizedBox(
                        height: 13.w,
                        width: 13.w,
                        child: const Icon(Icons.error)),
                    placeholder: (context, url) {
                      return Center(
                          child: SizedBox(
                        height: 13.w,
                        width: 13.w,
                        child: const CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.primary),
                      ));
                    },
                  ),
                ),
                w2,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name ?? " 1",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.poppinsRegular(
                          fontSize: 12.sp,
                          color: AppColors.black,
                          letterSpacing: 0.35,
                        ),
                      ),
                      Text(
                        widget.lastMessageText,
                        style: AppTextStyles.poppinsRegular(
                          fontSize: 10.sp,
                          color: AppColors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                      // to access last msg:
                      // FutureBuilder<QuerySnapshot>(
                      //   future: firestore
                      //       .collection('chat_rooms')
                      //       .doc(data['room_id'])
                      //       .collection('messages')
                      //       .orderBy('timestamp', descending: true)
                      //       .limit(1)
                      //       .get(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return CircularProgressIndicator();
                      //     }
                      //     if (snapshot.hasError) {
                      //       return Text('Error: ${snapshot.error}');
                      //     }

                      //     if (!snapshot.hasData ||
                      //         snapshot.data!.docs.isEmpty) {
                      //       return Text('No messages yet.');
                      //     }

                      //     var lastMessage = snapshot.data!.docs.first.data()
                      //         as Map<String, dynamic>;
                      //     var lastMessageText = lastMessage['text'];

                      //     return Text(
                      //       lastMessageText,
                      //       style: AppTextStyles.poppinsRegular(
                      //         fontSize: 10.sp,
                      //         color: AppColors.grey,
                      //       ),
                      //       maxLines: 1,
                      //       overflow: TextOverflow.ellipsis,
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
                Text(
                  DateFormat('hh:mm a').format(data['time'] ?? DateTime.now()),
                  style: AppTextStyles.poppinsRegular(
                    fontSize: 8.sp,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void onTapFn({required ChatProvider chatVM}) {
  void deleteChatRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(roomId)
          .delete();
    } catch (e) {
      print('Error deleting chat room: $e');
    }
  }
}


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:united_proposals_app/resources/app_images.dart';
// import 'package:united_proposals_app/resources/dummy.dart';
// import 'package:united_proposals_app/utils/app_colors.dart';
// import 'package:united_proposals_app/utils/height_widths.dart';
// import 'package:united_proposals_app/utils/text_style.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // import '../../models/chat_model.dart';
// // import '../../../../controller/provider/chat_provider.dart';
// import '../chat_conversation.dart';

// class ChatTileWidget extends StatelessWidget {
//   // final ChatModel? model;
//   DocumentSnapshot document;
//   String Name, ImageUrl, userID;
//   ChatTileWidget(
//       {super.key,
//       required this.document,
//       required this.ImageUrl,
//       required this.Name,
//       required this.userID});
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//     // return Consumer<ChatProvider>(builder: (context, chatVm, _) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: 1.2.h,
//       ),
//       child: Slidable(
//         endActionPane: ActionPane(
//           extentRatio: .12,
//           //openThreshold: 0.25,closeThreshold: 0.22,
//           motion: const ScrollMotion(),
//           children: [
//             CustomSlidableAction(
//               onPressed: (context) {
//                 // deleteBtn(chatVm);
//               },
//               backgroundColor: AppColors.lightRed,
//               padding: EdgeInsets.zero,
//               borderRadius: BorderRadius.circular(8),
//               autoClose: true,
//               child: ImageIcon(
//                 AssetImage(AppImages.deleteImageIcon),
//                 color: AppColors.red,
//                 size: 13.sp,
//               ),
//             ),
//           ],
//         ),
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatBetweenUsers(
//                     reciverUserID: userID,
//                     Image: ImageUrl,
//                     Name: Name,
//                   ),
//                 ));
//           },
//           child: Container(
//             width: 100.w,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//             margin: const EdgeInsets.only(right: 5),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: data['isRead'] == false
//                   ? AppColors.unReadColor
//                   : AppColors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.grey.withOpacity(0.16),
//                   offset: const Offset(0, 2),
//                   blurRadius: 6,
//                 ),
//               ],
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: CachedNetworkImage(
//                     imageUrl: ImageUrl ?? AppImages.dummyImage,
//                     imageBuilder: (context, imageProvider) => Container(
//                       height: 13.w,
//                       width: 13.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: AppColors.primary, width: 1),
//                         image: DecorationImage(
//                           image: imageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     fit: BoxFit.cover,
//                     errorWidget: (context, url, e) => SizedBox(
//                         height: 13.w,
//                         width: 13.w,
//                         child: const Icon(Icons.error)),
//                     placeholder: (context, url) {
//                       return Center(
//                           child: SizedBox(
//                         height: 13.w,
//                         width: 13.w,
//                         child: const CircularProgressIndicator.adaptive(
//                             backgroundColor: AppColors.primary),
//                       ));
//                     },
//                   ),
//                 ),
//                 w2,
//                 Expanded(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         Name ?? " 1",
//                         overflow: TextOverflow.ellipsis,
//                         style: AppTextStyles.poppinsRegular(
//                           fontSize: 12.sp,
//                           color: AppColors.black,
//                           letterSpacing: 0.35,
//                         ),
//                       ),
//                       Text(
//                         DummyData.shortText,
//                         style: AppTextStyles.poppinsRegular(
//                           fontSize: 10.sp,
//                           color: AppColors.grey,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   DateFormat('hh:mm a').format(data['time'] ?? DateTime.now()),
//                   style: AppTextStyles.poppinsRegular(
//                     fontSize: 8.sp,
//                     color: AppColors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void onTapFn({required ChatProvider chatVM}) {
//   // data['isRead'] = true;
//   // chatVM.update();
//   // Get.toNamed(ChatBetweenUsers.route, arguments: {'model': model});
//   // }

//   // void deleteBtn(ChatProvider chatVM) {
//   //   chatVM.listOfChatModel.remove(model);
//   //   chatVM.update();
//   // }
// }
