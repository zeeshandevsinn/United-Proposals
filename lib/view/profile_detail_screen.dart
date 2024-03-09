import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/settings_screens/block_report_view.dart';

import '../common-widgets/custom_data.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';
import 'notification/api/notification_apis.dart';

class ProfileDetailScreen extends StatefulWidget {
  static String route = "/profileDetailScreen";

  UserModel? model;
  // var userId;
  ProfileDetailScreen({super.key, this.model});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  dynamic args;
  // UserModel? model;
  double height = 0.0;

  getUserProfile(id) async {
    // ZBotToast.loadingShow();
    var data =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    userDetails = data;
    // ZBotToast.loadingClose();
    setState(() {});
  }

  var userDetails;
  setupFirebaseListener() {
    FirebaseFirestore.instance
        .collection("favorites")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("users")
        .doc(widget.model?.id)
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

  RequestFirebaseListner() {
    FirebaseFirestore.instance
        .collection("requests")
        .doc(widget.model?.id)
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Extract the 'isLike' field value from the snapshot
        bool isRequest = snapshot.get('isRequestPlaced');
        bool accept = snapshot.get('acceptRequest');
        // Update UI state based on this 'isLiked' value
        setState(() {
          // Update the local state in both screens
          requests = isRequest;
          AcceptRequest = accept;
        });
      }
    });
  }

  bool? AcceptRequest;
  bool? isLikedLocally;
  // @override
  // void initState() {
  //   super.initState();
  //   // fetchquerySnapshot();
  //   // getIsLikeValue(FirebaseAuth.instance.currentUser!.uid, widget.model.id);
  //   setupFirebaseListener();
  //   print(isLikedLocally);
  // }

  // var fav;
  // setupFirebaseListener() {
  //   FirebaseFirestore.instance
  //       .collection("favorites")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("users")
  //       .doc(widget.model?.id)
  //       .snapshots()
  //       .listen((DocumentSnapshot snapshot) {
  //     if (snapshot.exists) {
  //       // debugger();
  //       // Extract the 'isLike' field value from the snapshot
  //       bool isLiked = snapshot.get('isLike');
  //       // Update UI state based on this 'isLiked' value
  //       setState(() {
  //         // Update the local state in both screens
  //         isLikedLocally = isLiked;
  //       });
  //     }
  //   });
  // }

  // bool? isLikedLocally;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["model"] != null) {
          widget.model = args["model"];
        }
      }

      setState(() {});

      setupFirebaseListener();
      RequestFirebaseListner();
    });
    // getUserProfile(FirebaseAuth.instance.currentUser?.uid.toString());
    super.initState();
  }

  bool requests = false;
  double cmToFeet(double centimeters) {
    double cmToFeetConversionFactor = 30.48;
    return centimeters / cmToFeetConversionFactor;
  }

  @override
  Widget build(BuildContext context) {
    height = cmToFeet(widget.model!.height);
    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidgets.appBar(
            '${widget.model?.firstName ?? ''}\'s Detail',
            actions: [
              IconButton(
                onPressed: () {
                  Get.dialog(const BlockReportScreen());
                },
                icon: const Icon(
                  Icons.report_gmailerrorred_rounded,
                  color: AppColors.red,
                ),
              ),
            ]),
        bottomNavigationBar: buttons(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
                child: CachedNetworkImage(
                  imageUrl: widget.model?.profileImage ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, e) => SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const Icon(Icons.error)),
                  placeholder: (context, url) {
                    return SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
              h2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Personal Information',
                          style: AppTextStyles.poppinsBold(fontSize: 15.sp),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child:
                              Consumer<RootProvider>(builder: (context, vm, _) {
                            return InkWell(
                              onTap: () async {
                                // Toggle the isLike status in the UserModel
                                // widget.model?.setIsLike(!widget.model!.isLike);

                                // // Get an instance of SharedPreferences
                                // SharedPreferences prefs =
                                //     await SharedPreferences.getInstance();

                                // // Save the updated isLike status to local storage
                                // prefs.setBool('favorite_${widget.model?.id}',
                                //     widget.model!.isLike);
                                if (widget.model!.isLike) {
                                  widget.model!.setIsLike(false);
                                  setState(() {});
                                } else {
                                  widget.model!.setIsLike(true);
                                  setState(() {});
                                }
                                // widget.model?.setIsLike(!widget.model!.isLike);
                                print(widget.model!.isLike);
                                // debugger
                                if (widget.model!.isLike) {
                                  ZBotToast.loadingShow();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.model?.id)
                                      .update({"isLike": true});
                                  await FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('users')
                                      .doc(widget.model?.id)
                                      .set(widget.model!.toJson());
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
                                      .doc(widget.model?.id)
                                      .delete();

                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.model?.id)
                                      .update({"isLike": false});
                                  ZBotToast.loadingClose();
                                  setupFirebaseListener();
                                  isLikedLocally = false;
                                }

                                vm.update();
                                debugPrint(
                                    "widget.model?.isLike ${widget.model?.isLike}");
                              },
                              child: Icon(
                                Icons.favorite_rounded,
                                size: 20.sp,
                                color: (isLikedLocally ?? false)
                                    ? AppColors.primary
                                    : Colors.black54,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    h1,
                    Text(
                      "About:",
                      style: AppTextStyles.poppinsMedium(
                        fontSize: 12.sp,
                        color: AppColors.black,
                        letterSpacing: 0.45,
                      ),
                    ),
                    Text(
                      widget.model!.about,
                      style: AppTextStyles.poppinsRegular(
                        color: AppColors.grey,
                        letterSpacing: 0.45,
                      ),
                    ),
                    h1,
                    CustomData(
                        title: 'Name:',
                        subTitle:
                            "${widget.model?.firstName ?? ''} ${widget.model?.lastName ?? " "}"),
                    h1,
                    CustomData(
                        title: 'Age:',
                        subTitle: widget.model!.dateOfBirth.toString()),
                    h1,
                    CustomData(
                        title: 'Gender:', subTitle: widget.model!.gender),
                    h1,
                    CustomData(title: 'Email:', subTitle: widget.model!.email),
                    h1,
                    CustomData(
                        title: 'Number:', subTitle: widget.model!.PhoneNumber),
                    h1,
                    CustomData(
                        title: 'Height:',
                        subTitle: '${height.toStringAsFixed(1)} ft'),
                    h1,
                    CustomData(
                      title: 'Martial Status:',
                      subTitle: widget.model!.maritalStatus,
                    ),
                    h1,
                    CustomData(title: 'Color:', subTitle: widget.model!.color),
                    h1,
                    CustomData(
                        title: 'Cast:', subTitle: widget.model!.cast ?? ""),
                    h1,
                    CustomData(
                        title: 'Religion:', subTitle: widget.model!.religion),
                    h1,
                    CustomData(
                        title: 'Location:', subTitle: widget.model!.location),
                    h2,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttons() {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (AcceptRequest ?? false)
              ? Expanded(
                  child: CustomButton(
                  color: AppColors.primary,
                  text: "Send Message",
                  tap: () {
                    Get.back();
                  },
                  textColor: AppColors.white,
                ))
              : Expanded(
                  child: CustomButton(
                  color: requests ? AppColors.primary : AppColors.blue,
                  text: requests ? "Pending Request" : "Send Request",
                  tap: requests
                      ? () {}
                      : () async {
                          try {
                            ZBotToast.loadingShow();
                            // debugger();

                            var uid = FirebaseAuth.instance.currentUser?.uid;
                            await getUserProfile(uid);
                            var here = userDetails.data();

                            await FirebaseFirestore.instance
                                .collection("requests")
                                .doc(widget.model!.id)
                                .collection("users")
                                .doc(uid)
                                .set(userDetails.data());
                            await FirebaseFirestore.instance
                                .collection("requests")
                                .doc(widget.model!.id)
                                .collection("users")
                                .doc(uid)
                                .update({'isRequestPlaced': true});
                            await NotificationApi.addNotification(
                                title:
                                    "${here["firstName"]} sends a Friend Request",
                                event: "Request Sent",
                                senderID: uid,
                                id: widget.model!.id,
                                from: here["firstName"],
                                to: widget.model!.firstName);
                            RequestFirebaseListner();

                            ZBotToast.loadingClose();

                            // requests = true;
                            setState(() {});
                            ZBotToast.showToastSuccess(
                                message: "Request Send!");
                            // Get.back();

                            // ZBotToast.showToastError(message: "Error");
                          } catch (e) {
                            ZBotToast.showToastError(message: e.toString());
                            print(e.toString());
                          }
                        },
                  textColor: AppColors.white,
                ))
        ],
      ),
    );
  }
}
