// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/chat_work/view/chat_view.dart';
import 'package:united_proposals_app/view/not_verified_screen.dart';
import 'package:united_proposals_app/view/request_screen.dart';

import '../common-widgets/global_widgets.dart';
import '../controller/provider/root_provider.dart';
import '../models/user_model.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'settings_screens/setting_screen.dart';

class RootScreen extends StatefulWidget {
  static String route = "/rootScreen";

  RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var iconsList = [
    Icons.person,
    Icons.diversity_1_outlined,
    Icons.home,
    Icons.chat,
    Icons.settings
  ];

  List<Widget> screensList = [
    const ProfileScreen(),
    const RequestScreen(),
    const HomeScreen(),
    const ChatView(),
    const SettingScreen(),
  ];

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(message: "Click exit again!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<void> checkUserExistence() async {
    // Get the current user ID (Replace this with your logic to fetch user ID)
    String uid = FirebaseAuth
        .instance.currentUser!.uid; // Replace with actual user ID retrieval

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('favorites').doc(uid).get();
    // debugger();
    if (userSnapshot.exists) {
      return;
      // User exists in the collection, navigate to home page
      // navigateToHomePage();
    } else {
      // Update all user list boolean variables to false
      await updateAllUsersBooleanField();
      return;
      // Navigate to the home page after updating the user list
      // navigateToHomePage();
    }
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // List<UserModel> userList = [];
  final CollectionReference usersChatCollection =
      FirebaseFirestore.instance.collection('chat_room');
  updateAllChatUsersBooleanField() async {
    QuerySnapshot usersSnapshot = await usersChatCollection.get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Iterate through each user document and update the boolean field to false
    usersSnapshot.docs.forEach((userDoc) {
      batch.set(userDoc.reference, {'isBlock': false});
    });
// Commit the batch update
    await batch.commit();
  }

  updateAllUsersBooleanField() async {
    QuerySnapshot usersSnapshot = await usersCollection.get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Iterate through each user document and update the boolean field to false
    usersSnapshot.docs.forEach((userDoc) {
      batch.update(userDoc.reference, {'isLike': false});
    });
// Commit the batch update
    await batch.commit();
  }

  acceptRequest() async {
    var batch = FirebaseFirestore.instance.batch();

// Get all documents in the "users" collection
    var usersSnapshot = await FirebaseFirestore.instance
        .collection("users") // Change this to the correct collection name
        .get();

// Iterate through each document and add the new boolean field
    for (var doc in usersSnapshot.docs) {
      var userRef = FirebaseFirestore.instance
          .collection("users") // Change this to the correct collection name
          .doc(doc.id);
      // debugger();
      batch.update(userRef, {
        'acceptRequest': false
      }); // Change 'newBooleanField' to your desired field name
    }

// Commit the batched write
    await batch.commit();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    checkUserExistence();
    GetUserVerification();
    acceptRequest();
  }

  bool verify = false;
  GetUserVerification() async {
    var check = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (check.get('isVerified')) {
      verify = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var myProvider = context.watch<RootProvider>();
      return verify
          ? WillPopScope(
              onWillPop: () => onWillPop(),
              child: SafeArea(
                child: Scaffold(
                  appBar: GlobalWidgets.homeAppBar(appBarTitle(
                      context.read<RootProvider>().selectedScreenValue)),
                  body: PageView(
                    controller: myProvider.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: screensList,
                  ),
                  bottomNavigationBar: Container(
                    height: 6.5.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, -1),
                          color: AppColors.primary.withOpacity(.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < iconsList.length; i++)
                          InkWell(
                            onTap: (() {
                              context.read<RootProvider>().selectedScreenValue =
                                  i;
                              context.read<RootProvider>().update();
                              myProvider.pageController.jumpToPage(i);
                            }),
                            child: SizedBox(
                              width: 13.w,
                              height: 5.5.h,
                              child: Icon(
                                iconsList[i],
                                size: myProvider.selectedScreenValue == i
                                    ? 24.sp
                                    : 18.sp,
                                color: myProvider.selectedScreenValue == i
                                    ? AppColors.primary
                                    : AppColors.grey,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
          : NotVerifiedScreen();
    });
  }

  String appBarTitle(int val) {
    switch (val) {
      case 0:
        return "User Profiles";
      case 1:
        return "Requests";
      case 2:
        return "Home";
      case 3:
        return "Messages";
      case 4:
        return "Settings";
      default:
        return "";
    }
  }
}
