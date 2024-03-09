import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/chat_work/view/widget/chat_tile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/height_widths.dart';

var searchController = TextEditingController();

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  FocusNode searchFN = FocusNode();

  getUserProfile(id) async {
    var data =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    userDetails = data;
    setState(() {});
  }

  var RequestApproved = false;
  getRequestProfile(id) async {
    var data =
        await FirebaseFirestore.instance.collection('requests').doc(id).get();
    if (data.exists) {
      var boolean = true;
      setState(() {
        RequestApproved = boolean;
      });
    }
  }

  var userDetails;

  @override
  void initState() {
    super.initState();
    getChats();
    // getRequestProfile(FirebaseAuth.instance.currentUser?.uid);
  }

  bool isLoading = false;

  List totalChats = [];

  getChats() async {
    totalChats.clear();
    // debugger();
    try {
      setState(() {
        isLoading = true;
      });
      var data = await FirebaseFirestore.instance.collection('chat_room').get();
      // totalChats = data.docs;
      for (var item in data.docs) {
        var d = item.data();
        totalChats.add(d);
      }
      searchresult = totalChats;
      print(totalChats.length);
    } catch (e) {
      print(e);
      debugger();
    }
    setState(() {
      isLoading = false;
    });
  }

  List searchresult = [];
  bool _isSearching = false;

  void searchOperation(String searchText) {
    searchresult = [];
    setState(() {});
    // debugger();
    if (totalChats.isNotEmpty) {
      for (int i = 0; i < totalChats.length; i++) {
        Map<String, dynamic> data = totalChats[i];
        // Convert all values to lowercase for case-insensitive search
        String senderName = data['senderName'].toString().toLowerCase();
        String receiverName = data['receiverName'].toString().toLowerCase();
        // String lastMessage = data['lastMessage'].toString().toLowerCase();
        print(searchText + " testing here " + senderName + receiverName);
        if (senderName.contains(searchText.toLowerCase()) ||
                receiverName.contains(searchText.toLowerCase())
            //  ||
            // lastMessage.contains(searchText.toLowerCase())
            ) {
          // debugger();
          searchresult.add(data);
          print(searchresult);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var size = MediaQuery.of(context).size * 1;

    return Material(
      child: Column(
        children: [
          h1,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: searchField(),
          ),
          Expanded(
            child:
                // child: StreamBuilder(
                //   stream:
                //       FirebaseFirestore.instance.collection('chat_room').snapshots(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasError) {
                //       print("Error: ${snapshot.error}");
                //       return Text("Error occurred!");
                //     }
                //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                // return Center(
                //   child: Text(
                //     "No Requests Approved!",
                //     textAlign: TextAlign.center,
                //     style: AppTextStyles.poppinsRegular().copyWith(
                //         color: AppColors.black, fontSize: 20.sp, height: 4),
                //   ),
                // );
                //     } else if (snapshot.hasData) {
                //       QuerySnapshot data = snapshot.data!;
                isLoading
                    ? Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : totalChats.isEmpty
                        ? Center(
                            child: Text(
                              "Chat Room is Empty!",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.poppinsRegular().copyWith(
                                  color: AppColors.black,
                                  fontSize: 20.sp,
                                  height: 4),
                            ),
                          )
                        : ListView.builder(
                            itemCount: searchresult.length,
                            itemBuilder: (context, index) {
                              var doc = searchresult[index];
                              // debugger();
                              if (doc['senderID'] ==
                                  FirebaseAuth.instance.currentUser?.uid) {
                                return ChatTileWidget(
                                  document: doc,
                                  userID: doc['senderID'] !=
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? doc["senderID"]
                                      : doc["receiverID"],
                                  name: doc['senderID'] !=
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? doc["senderName"]
                                      : doc["receiverName"],
                                  imageurl: doc['senderID'] !=
                                          FirebaseAuth.instance.currentUser?.uid
                                      // ? doc["ReceiverImage"]

                                      ? doc["senderImage"]
                                      : doc["receiverImage"],
                                  lastMessageText: doc['lastMessage'],
                                );
                              } else if (doc["receiverID"] ==
                                  FirebaseAuth.instance.currentUser?.uid) {
                                return ChatTileWidget(
                                  document: doc,
                                  userID: doc['senderID'] !=
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? doc["senderID"]
                                      : doc["receiverID"],
                                  name: doc['senderID'] !=
                                          FirebaseAuth.instance.currentUser?.uid
                                      ? doc["senderName"]
                                      : doc["receiverName"],
                                  imageurl: doc['senderID'] ==
                                          FirebaseAuth.instance.currentUser?.uid
                                      // ? doc["ReceiverImage"]

                                      ? doc["receiverImage"]
                                      : doc["senderImage"],
                                  lastMessageText: doc['lastMessage'],
                                );
                              } else
                                return SizedBox();

                              /*  if (data.docs[index].get('senderID') == uid) {
                        getUserProfile(data.docs[index].get('receiverID'));
                        return SingleChildScrollView(
                          child: Column(children: [
                            ChatTileWidget(
                              document: docs as DocumentSnapshot,
                              userID: data.docs[index].get('receiverID'),
                              name: userDetails.get('firstName'),
                              imageurl: userDetails.get('profileImage'),
                            )
                          ]),
                        );
                      } else if (data.docs[index].get('receiverID') == uid) {
                        getUserProfile(data.docs[index].get('senderID'));
                        String fullName = userDetails.get('firstName') +
                            userDetails.get('lastName');
                        return SingleChildScrollView(
                          child: Column(children: [
                            ChatTileWidget(
                              document: docs as DocumentSnapshot,
                              userID: data.docs[index].get('senderID'),
                              name: fullName,
                              imageurl: userDetails.get('profileImage'),
                            )
                          ]),
                        );
                      } */
                              //       },
                              //     );
                              //   }
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return TextFormField(
      focusNode: FocusNode(),
      controller: searchController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onChanged: (value) {
        debugPrint('Search term changed: $value');
        if (value.isNotEmpty) {
          searchOperation(value);
        } else {
          getChats();
        }
      },
      onTap: () {
        debugPrint('Search field tapped');
      },
      onFieldSubmitted: (value) {
        debugPrint('Search submitted: $value');
      },
      decoration: AppDecoration.fieldDecoration(
        hintText: "Search",
        preIcon: Icon(
          Icons.search,
          color: FocusNode().hasFocus ? AppColors.primary : Colors.grey,
        ),
        verticalPadding: 10,
      ),
    );
  }
}



// // chat view:
// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:united_proposals_app/controller/provider/chat_provider.dart';
// // import 'package:united_proposals_app/controller/provider/chat_provider.dart';
// import 'package:united_proposals_app/resources/app_decoration.dart';
// import 'package:united_proposals_app/utils/app_colors.dart';
// import 'package:united_proposals_app/utils/text_style.dart';
// import 'package:united_proposals_app/utils/zbotToast.dart';
// import 'package:united_proposals_app/view/chat_work/view/widget/chat_tile_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../utils/height_widths.dart';

// class ChatView extends StatefulWidget {
//   const ChatView({Key? key}) : super(key: key);

//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   FocusNode searchFN = FocusNode();
//   TextEditingController searchController = TextEditingController();
//   PageController pageMove = PageController();
//   int chatTypePageIndex = 0;
//   bool isLoading = false;
//   getUserProfile(id) async {
//     // ZBotToast.loadingShow();
//     // var id = FirebaseAuth.instance.currentUser?.uid;
//     var data =
//         await FirebaseFirestore.instance.collection("users").doc(id).get();
//     debugger();
//     // log(data.data() as String);
//     userDetails = data;
//     // ZBotToast.loadingClose();
//     setState(() {});
//   }

//   var userDetails;

//   @override
//   Widget build(BuildContext context) {
//     var uid = FirebaseAuth.instance.currentUser?.uid;

//     return Column(
//       children: [
//         h1,
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: searchField(),
//         ),
//         Expanded(
//           child: StreamBuilder(
//             stream:
//                 FirebaseFirestore.instance.collection('chat_room').snapshots(),
//             builder: (context, snapshot) {
//               // debugger();
//               if (snapshot.hasData) {
//                 QuerySnapshot data = snapshot.data!;
//                 return ListView.builder(
//                   itemCount: data.docs.length,
//                   itemBuilder: (context, index) {
//                     if (data.docs[index].get('senderID') == uid) {
//                       var docs = snapshot.data!.docs;
//                       getUserProfile(data.docs[index].get('receiverID'));
//                       String fullName = userDetails.get('firstName') +
//                           userDetails.get('lastName');
//                       debugger();
//                       return SingleChildScrollView(
//                         child: Column(children: [
//                           ChatTileWidget(
//                             document: docs as DocumentSnapshot,
//                             userID: data.docs[index].get('receiverID'),
//                             name: fullName,
//                             imageurl: userDetails.get('profileImage'),
//                           )
//                         ]),
//                       );
//                     } else if (data.docs[index].get('receiverID') == uid) {
//                       var docs = snapshot.data!.docs;
//                       getUserProfile(data.docs[index].get('senderID'));
//                       String fullName = userDetails.get('firstName') +
//                           userDetails.get('lastName');
//                       return SingleChildScrollView(
//                         child: Column(children: [
//                           ChatTileWidget(
//                             document: docs as DocumentSnapshot,
//                             userID: data.docs[index].get('senderID'),
//                             name: fullName,
//                             imageurl: userDetails.get('profileImage'),
//                           )
//                         ]),
//                       );
//                     }
//                   },
//                 );
//               } else if (!snapshot.hasData)
//                 return Center(
//                   child: Text(
//                     "No Requests Approved!",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.poppinsRegular().copyWith(
//                         color: AppColors.black, fontSize: 20.sp, height: 4),
//                   ),
//                 );

//               return ZBotToast.loadingShow();
//             },
//           ),
//         ),
//       ],
//     );

//   }

//   var user = FirebaseAuth.instance.currentUser;

//   Widget searchField() {
//     return TextFormField(
//       focusNode: searchFN,
//       controller: searchController,
//       keyboardType: TextInputType.text,
//       textInputAction: TextInputAction.done,
//       onChanged: (value) {
//         debugPrint('Search');
//         setState(() {});
//       },
//       onTap: () {
//         setState(() {});
//       },
//       onFieldSubmitted: (value) {
//         setState(() {});
//       },
//       decoration: AppDecoration.fieldDecoration(
//         hintText: "Search",
//         preIcon: Icon(
//           Icons.search,
//           color: searchFN.hasFocus ? AppColors.primary : Colors.grey,
//         ),
//         verticalPadding: 10,
//       ),
//     );
//   }
// }

// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// // import 'package:united_proposals_app/controller/provider/chat_provider.dart';
// import 'package:united_proposals_app/resources/app_decoration.dart';
// import 'package:united_proposals_app/utils/app_colors.dart';
// import 'package:united_proposals_app/utils/zbotToast.dart';
// import 'package:united_proposals_app/view/chat_work/view/widget/chat_tile_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// class ChatView extends StatefulWidget {
//   const ChatView({Key? key}) : super(key: key);
//   @override
//   State<ChatView> createState() => _ChatViewState();
// }
// class _ChatViewState extends State<ChatView> {
//   FocusNode searchFN = FocusNode();
//   TextEditingController searchController = TextEditingController();
//   PageController pageMove = PageController();
//   int chatTypePageIndex = 0;
//   // ChatProvider chatVM = ChatProvider();
//   getUserProfile(id) async {
//     ZBotToast.loadingShow();
//     var data =
//         await FirebaseFirestore.instance.collection("users").doc(id).get();

//     userDetails = data;
//     ZBotToast.loadingClose();
//     setState(() {});
//   }
//   var userDetails;
//   @override
//   Widget build(BuildContext context) {
//     var uid = FirebaseAuth.instance.currentUser?.uid;
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('requests')
//             .doc(uid.toString())
//             .collection('users')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             QuerySnapshot data = snapshot.data!;
//             for (var index = 0; index < data.docs.length; index++) {
//               if (data.docs[index].get('isRequestPlaced')) {
//                 String fullName = data.docs[index].get('firstName') +
//                     data.docs[index].get('lastName');
//                 return Column(
//                     children: snapshot.data!.docs
//                         .map((docs) => ChatTileWidget(
//                               document: docs,
//                               ImageUrl: data.docs[index].get('profileImage'),
//                               Name: fullName,
//                               userID: data.docs[index].get('id'),
//                             ))
//                         .toList());
//               }
//             }
//           } else {
//             // return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat_room').doc(uid)., builder: builder)
//             if (snapshot.hasError) {
//               return Center(child: Text('Something went wrong'));
//             }
//             // switch(snapshot.connectionState){
//             // case ConnectionState.waiting:
//             // case ConnectionState.none:
//             // return Center(child: CircularProgressIndicator());
//             // case ConnectionState.active:
//             // return Center(child: Text("data is ${snapshot.data}"));
//             // case ConnectionState.done:
//             // return Center(child: Text("data is ${snapshot.data}"));
//             // }
//           }
//           return Center(child: Text('No Request Approved'));
//           // StreamBuilder(
//           //     stream: FirebaseFirestore.instance
//           //         .collection('chat_room')
//           //         .doc(uid)
//           //         .collection('message')
//           //         .snapshots(),
//           //     builder: (context, snapshot) {
//           //       debugger();
//           //       if (snapshot.hasData) {
//           //         QuerySnapshot data = snapshot.data!;
//           //         String id = data.docs[0].get('senderId');
//           //         userDetails = FirebaseFirestore.instance
//           //             .collection("users")
//           //             .doc(id)
//           //             .get();

//           //         debugger();
//           //         return Column(
//           //             children: snapshot.data!.docs
//           //                 .map((docs) => ChatTileWidget(
//           //                       document: docs,
//           //                       ImageUrl: "",
//           //                       Name: "Alex",
//           //                       userID: uid.toString(),
//           //                     ))
//           //                 .toList());
//           //       }
//           //       return ZBotToast.loadingShow();
//           //     });
//         });
//     //  Consumer<ChatProvider>(builder: (context, chatVM, _) {
//     //   return Column(
//     //     children: [
//     //       h1,
//     //       // switchPageWidget(chatVM: chatVM),
//     //       Padding(
//     //         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.5.h),
//     //         child: searchField(),
//     //       ),
//     //       Expanded(
//     //         child: PageView(
//     //           physics: const NeverScrollableScrollPhysics(),
//     //           controller: pageMove,
//     //           onPageChanged: (val) {
//     //             chatTypePageIndex = val;
//     //             setState(() {});
//     //           },
//     //           children: [
//     //             individualChatView(chatVM: chatVM),
//     //             flockChatView(chatVM: chatVM)
//     //           ],
//     //         ),
//     //       ),
//     //     ],
//     //   );
//     // }

//     // );
//   }
  // Widget searchField() {
  //   return TextFormField(
  //     focusNode: searchFN,
  //     controller: searchController,
  //     keyboardType: TextInputType.text,
  //     textInputAction: TextInputAction.done,
  //     onChanged: (value) {
  //       debugPrint('Search');
  //       setState(() {});
  //     },
  //     onTap: () {
  //       setState(() {});
  //     },
  //     onFieldSubmitted: (value) {
  //       setState(() {});
  //     },
  //     decoration: AppDecoration.fieldDecoration(
  //       hintText: "Search",
  //       preIcon: Icon(
  //         Icons.search,
  //         color: searchFN.hasFocus ? AppColors.primary : Colors.grey,
  //       ),
  //       verticalPadding: 10,
  //     ),
  //   );
  // }

//   // Widget individualChatView({required ChatProvider chatVM}) {
//   //   return SlidableAutoCloseBehavior(
//   //     child: ListView(
//   //       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//   //       children: List.generate(
//   //           chatVM.listOfChatModel
//   //               .where((element) => element.userName!
//   //                   .isCaseInsensitiveContains(searchController.text))
//   //               .toList()
//   //               .length, (index) {
//   //         List<ChatModel> searchList = chatVM.listOfChatModel
//   //             .where((element) => element.userName!
//   //                 .isCaseInsensitiveContains(searchController.text))
//   //             .toList();
//   //         return ChatTileWidget(
//   //           model: searchList[index],
//   //         );
//   //       }),
//   //     ),
//   //   );
//   // }

//   // Widget flockChatView({required ChatProvider chatVM}) {
//   //   return SlidableAutoCloseBehavior(
//   //     child: ListView(
//   //       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
//   //       children: List.generate(
//   //           chatVM.listOfChatModel
//   //               .where((element) => element.userName!
//   //                   .isCaseInsensitiveContains(searchController.text))
//   //               .toList()
//   //               .length, (index) {
//   //         List<ChatModel> searchGroupList = chatVM.listOfChatModel
//   //             .where((element) => element.userName!
//   //                 .isCaseInsensitiveContains(searchController.text))
//   //             .toList();
//   //         return ChatTileWidget(
//   //           model: searchGroupList[index],
//   //         );
//   //       }),
//   //     ),
//   //   );
//   // }
// }
