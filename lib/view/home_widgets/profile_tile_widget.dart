// import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../../utils/height_widths.dart';
import '../../utils/zbotToast.dart';
import '../profile_detail_screen.dart';

// import 'package:firebase_querySnapshotbase/firebase_querySnapshotbase.dart';
class ProfileTileWidget extends StatefulWidget {
  final UserModel model;
  final VoidCallback onTap;
  const ProfileTileWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  State<ProfileTileWidget> createState() => _ProfileTileWidgetState();
}

class _ProfileTileWidgetState extends State<ProfileTileWidget> {
  // final ref = FirebasequerySnapshotbase.instance.ref("");

  Future<void> fetchquerySnapshot() async {
    // Assuming you have a "users" collection in Firestore
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        // Limit the number of items to 4
        .get();

    final List<UserModel> userModels = [];
    // for (var index = 0; index < querySnapshot.docs.length; index++) {
    //   final List<UserModel> userModels = querySnapshot.docs
    //       .map(
    //         (doc) => UserModel(
    //             about: querySnapshot.docs[index].get('about'),
    //             city: querySnapshot.docs[index].get('city'),
    //             color: querySnapshot.docs[index].get('color'),
    //             country: querySnapshot.docs[index].get('country'),
    //             dateOfBirth: querySnapshot.docs[index].get('dateOfBirth'),
    //             firstName: querySnapshot.docs[index].get('firstName'),
    //             gender: querySnapshot.docs[index].get('gender'),
    //             height: querySnapshot.docs[index].get('height'),
    //             howDidYouHearAboutUs:
    //                 querySnapshot.docs[index].get('howDidYouHearAboutUs'),
    //             id: querySnapshot.docs[index].get('id'),
    //             lastName: querySnapshot.docs[index].get('lastName'),
    //             maritalStatus: querySnapshot.docs[index].get('martialStatus'),
    //             profileImage: querySnapshot.docs[index].get('profileImage'),
    //             religion: querySnapshot.docs[index].get('religion'),
    //             state: querySnapshot.docs[index].get('state'),
    //             isLike: querySnapshot.docs[index].get('isLike'),
    //             isRequestPlaced:
    //                 querySnapshot.docs[index].get('isRequestPlaced'),
    //             location: querySnapshot.docs[index].get('location')),
    //       )
    //       .toList();
    // }

    // Now you have a list of 4 user models, update your UI accordingly
    // (You may want to handle this querySnapshot in the parent widget)

    print(userModels);
  }

  bool? isLike;
  getIsLikeValue(String uid, String userId) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("favorites")
        .doc(uid)
        .collection("users")
        .doc(userId)
        .get();

    if (snapshot.exists) {
      // Accessing the 'isLike' field from the document
      isLike = snapshot.get('isLike');
      return true;
      // return isLike!;
    } else {
      isLike = false;
      return isLike;
      // return false; // Default value or handle the case where the document doesn't exist
    }
  }

  void setupFirebaseListener() {
    FirebaseFirestore.instance
        .collection("favorites")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("users")
        .doc(widget.model.id)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Extract the 'isLike' field value from the snapshot
        bool isLiked = snapshot.get('isLike');
        // Update UI state based on this 'isLiked' value
        setState(() {
          // Update the local state in both screens
          isLikedLocally = isLiked;
        });
      } else {
        setState(() {
          isLikedLocally = false;
        });
      }
    });
  }

  bool? isLikedLocally;
  @override
  void initState() {
    super.initState();
    // fetchquerySnapshot();
    // getIsLikeValue(FirebaseAuth.instance.currentUser!.uid, widget.model.id);
    setupFirebaseListener();
    print(isLikedLocally);
  }

  Widget build(BuildContext context) {
    var fullName = widget.model.firstName + " " + widget.model.lastName;
    return Container(
      child: GestureDetector(
        onTap: () {
          visitProfileFn();
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
                              fullName ?? "",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<RootProvider>(builder: (context, vm, _) {
                            return InkWell(
                              onTap: () async {
                                print(widget.model.isLike);
                                widget.model.setIsLike(!widget.model.isLike);
                                var uid =
                                    FirebaseAuth.instance.currentUser?.uid;
                                // debugger();

                                if (widget.model.isLike) {
                                  ZBotToast.loadingShow();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.model.id)
                                      .update({"isLike": true});
                                  await FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('users')
                                      .doc(widget.model.id)
                                      .set(widget.model.toJson());
                                  ZBotToast.loadingClose();
                                  setupFirebaseListener();
                                } else {
                                  // debugger();
                                  ZBotToast.loadingShow();
                                  await FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('users')
                                      .doc(widget.model.id)
                                      .delete();

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.model?.id)
                                      .update({"isLike": false});
                                  ZBotToast.loadingClose();
                                  setupFirebaseListener();
                                  isLikedLocally = false;
                                }

                                print(widget.model.isLike);

                                vm.update();
                                debugPrint(
                                    "widget.model.isLike ${widget.model.isLike}");
                                // debugPrint("list  ${vm.userList.first.isLike}");
                              },
                              child: Icon(
                                Icons.favorite_rounded,
                                size: 14.sp,
                                color: isLikedLocally ?? false
                                    ? AppColors.primary
                                    : Colors.black54,
                              ),
                            );
                          }),
                          InkWell(
                            onTap: () {
                              visitProfileFn();
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: AppColors.blue,
                              ),
                              child: Text(
                                "Visit Profile",
                                style: AppTextStyles.poppinsMedium(
                                  fontSize: 8.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void visitProfileFn() {
    // Navigator.pus
    Get.toNamed(ProfileDetailScreen.route, arguments: {"model": widget.model});
  }
}
