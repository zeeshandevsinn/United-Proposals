// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/common-widgets/custom_drawer.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/home_widgets/profile_tile_widget.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

import '../utils/app_colors.dart';

var searchController = TextEditingController();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getPersons();
  }

  bool isLoading = false;

  List totalPersons = [];

  getPersons() async {
    totalPersons.clear();
    // debugger();
    try {
      setState(() {
        isLoading = true;
      });
      var data = await FirebaseFirestore.instance.collection('users').get();
      // totalPersons = data.docs;
      for (var item in data.docs) {
        var d = item.data();
        totalPersons.add(d);
      }
      searchresult = totalPersons;
      print(totalPersons.length);
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

  searchOperation(String searchText) {
    searchresult = [];
    setState(() {});
    // debugger();
    if (totalPersons.isNotEmpty) {
      for (int i = 0; i < totalPersons.length; i++) {
        Map<String, dynamic> data = totalPersons[i];
        String firstName = data['firstName'].toString().toLowerCase();
        String lastName = data['lastName'].toString().toLowerCase();
        print(searchText + " testing here " + firstName + lastName);
        if (firstName.contains(searchText.toLowerCase()) ||
            lastName.contains(searchText.toLowerCase())) {
          searchresult.add(data);
          print(searchresult);
        }
      }
      setState(() {});
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // context.read<RootProvider>().fetchUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // key: _scaffoldKey,
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: AppColors.primary,
            //   child: const Icon(
            //     Icons.filter_list_rounded,
            //     color: AppColors.white,
            //   ),
            //   onPressed: () {
            //     _scaffoldKey.currentState?.openEndDrawer();
            //   },
            // ),
            // endDrawer: const FilterDrawer(),
            body: Column(
      children: [
        h1,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: searchField(),
        ),
        Expanded(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : totalPersons.isEmpty
                  ? Center(
                      child: Text(
                        "No Requests Approved!",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.poppinsRegular().copyWith(
                            color: AppColors.black, fontSize: 20.sp, height: 4),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchresult.length,
                      itemBuilder: (context, index) {
                        var doc = searchresult[index];

                        return ProfileTileWidget(
                          model: UserModel(
                              isVerified: doc['isVerified'] ?? false,
                              acceptRequest: doc['acceptRequest'] ?? false,
                              cast: doc['cast'] ?? "",
                              PhoneNumber: doc['PhoneNumber'] ?? "",
                              about: doc['about'] ?? "",
                              city: doc['city'] ?? "",
                              color: doc['color'] ?? "",
                              country: doc['country'] ?? "",
                              dateOfBirth: doc['dateOfBirth'] ?? "",
                              firstName: doc['firstName'] ?? "",
                              gender: doc['gender'] ?? "",
                              height: doc['height'] ?? 0,
                              howDidYouHearAboutUs:
                                  doc['howDidYouHearAboutUs'] ?? "",
                              id: doc['id'] ?? "",
                              lastName: doc['lastName'] ?? "",
                              maritalStatus: doc['maritalStatus'] ?? "",
                              profileImage: doc['profileImage'] ?? "",
                              religion: doc['religion'] ?? "",
                              state: doc['state'] ?? "",
                              isLike: doc['isLike'] ?? false,
                              isRequestPlaced: doc['isRequestPlaced'] ?? false,
                              email: doc['email'] ?? "",
                              location: doc['location'] ?? ""),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              ProfileDetailScreen.route,
                            );
                          },
                        );
                      },
                    ),
        ),
      ],
    )
            //  Consumer<RootProvider>(
            //   builder: (context, provider, child) {
            //     return SingleChildScrollView(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           searchField(),
            //           h1,
            //           if (provider.filteredUsers.isEmpty)
            //             Center(
            //               child: Text(
            //                 "No Data",
            //                 textAlign: TextAlign.center,
            //                 style: AppTextStyles.poppinsRegular().copyWith(
            //                     color: AppColors.black,
            //                     fontSize: 20.sp,
            //                     height: 4),
            //               ),
            //             )
            //           else
            // ...List.generate(
            //   provider.filteredUsers.length,
            //   (index) =>
            //   ProfileTileWidget(
            //     model: UserModel(
            //         acceptRequest:
            //             provider.filteredUsers[index].acceptRequest ??
            //                 false,
            //         cast: provider.filteredUsers[index].cast,
            //         PhoneNumber:
            //             provider.filteredUsers[index].PhoneNumber,
            //         about: provider.filteredUsers[index].about,
            //         city: provider.filteredUsers[index].city,
            //         color: provider.filteredUsers[index].color,
            //         country: provider.filteredUsers[index].country,
            //         dateOfBirth:
            //             provider.filteredUsers[index].dateOfBirth,
            //         firstName:
            //             provider.filteredUsers[index].firstName,
            //         gender: provider.filteredUsers[index].gender,
            //         height: provider.filteredUsers[index].height,
            //         howDidYouHearAboutUs: provider
            //             .filteredUsers[index].howDidYouHearAboutUs,
            //         id: provider.filteredUsers[index].id,
            //         lastName: provider.filteredUsers[index].lastName,
            //         maritalStatus:
            //             provider.filteredUsers[index].maritalStatus,
            //         profileImage:
            //             provider.filteredUsers[index].profileImage,
            //         religion: provider.filteredUsers[index].religion,
            //         state: provider.filteredUsers[index].state,
            //         isLike: provider.filteredUsers[index].isLike,
            //         isRequestPlaced:
            //             provider.filteredUsers[index].isRequestPlaced,
            //         email: provider.filteredUsers[index].email,
            //         location: provider.filteredUsers[index].location),
            //     onTap: () {
            //       Navigator.pushNamed(
            //         context,
            //         ProfileDetailScreen.route,
            //       );
            //     },
            //   ),
            // )
            //         ],
            //       ),
            //     );
            //   },
            // ),
            ));
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
          getPersons();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.clear();
  }
}

/*
  @override
  Widget build(BuildContext context) {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    var size = MediaQuery.of(context).size * 1;

    return Column(
      children: [
        h1,
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: searchField(),
        ),
        Expanded(
          child:
          isLoading ? Center(child: CircularProgressIndicator.adaptive(),) :
              totalPersons.isEmpty ? Center(
                  child: Text(
                    "No Requests Approved!",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.poppinsRegular().copyWith(
                        color: AppColors.black, fontSize: 20.sp, height: 4),
                  ),
                ) :
                 ListView.builder(
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
                            ? doc["receiverImage"]
                            : doc["senderImage"],
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
                        imageurl: doc['senderID'] !=
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
            //   return Center(
            //     child: Text(
            //       "No Requests Approved!",
            //       textAlign: TextAlign.center,
            //       style: AppTextStyles.poppinsRegular().copyWith(
            //           color: AppColors.black, fontSize: 20.sp, height: 4),
            //     ),
            //   );
            },
          ),
        ),
      ],
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
      if(value.isNotEmpty){
      searchOperation(value);
      }else{
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
*/
// ...provider.filteredUsers.where((user) =>
//                         user.firstName.toLowerCase().contains(searchController.text.toLowerCase()) ||
//                         user.lastName.toLowerCase().contains(searchController.text.toLowerCase()))
//                         .toList()
//                         .map((index) =>
