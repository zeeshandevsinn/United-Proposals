// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/controller/favorite_controller_user.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

import '../../utils/zbotToast.dart';

class ProfileWidget extends StatefulWidget {
  UserModel model;
  VoidCallback onTap;
  ProfileWidget({super.key, required this.model, required this.onTap});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  setupFirebaseListener() {
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
      }
    });
  }

  bool? isLikedLocally;
  @override
  void initState() {
    setupFirebaseListener();
    super.initState();
    // fetchquerySnapshot();
    // getIsLikeValue(FirebaseAuth.instance.currentUser!.uid, widget.model.id);

    print(isLikedLocally);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        visitProfileFn();
      },
      child: Container(
        margin: EdgeInsets.all(4.sp),
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.20),
              offset: const Offset(-5, -2),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Colors.blue.withOpacity(0.20),
              offset: const Offset(3, 3),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 16.h,
                    width: 40.w,
                    child: CachedNetworkImage(
                      // imageUrl: widget.model.profileImageUrl ?? "",

                      imageUrl: widget.model.profileImage ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 2, 2),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(30)),
                      color: AppColors.primary.withOpacity(.57),
                    ),
                    child: Text(
                      "Premium",
                      // widget.model!.maritalStatus,
                      style: AppTextStyles.poppinsRegular(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 13, 5, 0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.35),
                          offset: const Offset(1, 1),
                          blurRadius: 10,
                          spreadRadius: -10,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.35),
                          offset: const Offset(-1, -1),
                          blurRadius: 10,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: Consumer<RootProvider>(builder: (context, vm, _) {
                      return InkWell(
                        onTap: () async {
                          debugger();
                          if (widget.model.isLike) {
                            widget.model.setIsLike(false);
                            setState(() {});
                          } else {
                            widget.model.setIsLike(true);
                            setState(() {});
                          }
                          // widget.model?.setIsLike(!widget.model!.isLike);
                          print(widget.model.isLike);
                          debugger();
                          if (widget.model.isLike) {
                            ZBotToast.loadingShow();
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.model.id)
                                .update({"isLike": true});
                            await FirebaseFirestore.instance
                                .collection('favorites')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
                                .collection('users')
                                .doc(widget.model.id)
                                .set(widget.model.toJson());
                            ZBotToast.loadingClose();
                            setupFirebaseListener();
                          } else {
                            debugger();
                            ZBotToast.loadingShow();
                            await FirebaseFirestore.instance
                                .collection('favorites')
                                .doc(FirebaseAuth.instance.currentUser?.uid)
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

                          // await getIsLikeValue(
                          //     uid.toString(), widget.model.id);
                          vm.update();
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
                  ),
                ),
              ],
            ),
            h1,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.firstName ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.poppinsMedium(fontSize: 11.sp),
                        ),
                        Text(
                          widget.model.dateOfBirth.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.poppinsRegular(fontSize: 10.sp),
                        ),
                        Text(
                          widget.model.country ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.poppinsRegular(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: visitProfileFn,
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: AppColors.blue,
                      ),
                      child: Text(
                        "Visit Profile",
                        style: AppTextStyles.poppinsMedium(
                          fontSize: 7.sp,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h1,
          ],
        ),
      ),
    );
  }

  void visitProfileFn() {
    Get.toNamed(ProfileDetailScreen.route, arguments: {"model": widget.model});
  }
}
