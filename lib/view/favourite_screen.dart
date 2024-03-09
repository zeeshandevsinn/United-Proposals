// ignore_for_file: camel_case_types

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/controller/favorite_controller_user.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/home_widgets/profile_tile_widget.dart';
import 'package:united_proposals_app/view/prefrences.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

class FavouriteProfileScreen extends StatefulWidget {
  static String route = "/FavouriteProfileScreen";
  const FavouriteProfileScreen({super.key});

  @override
  State<FavouriteProfileScreen> createState() => _FavouriteProfileScreenState();
}

class _FavouriteProfileScreenState extends State<FavouriteProfileScreen> {
  // UserModel? model;
  List favorites = [];

  @override
  void initState() {
    super.initState();
    // favorites = Preferences.getitem();
  }

  var uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: GlobalWidgets.appBar('Liked Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h1,
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('favorites')
                  .doc(uid)
                  .collection('users')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData) {
                  return Text('No Data');
                }

                if (snapshot.hasData) {
                  QuerySnapshot data = snapshot.data!;
                  List<Widget> profileTiles = [];
                  for (var index = 0; index < data.docs.length; index++) {
                    if (data.docs[index].get('isLike')) {
                      profileTiles.add(
                        ProfileTileWidget(
                          model: UserModel(
                              isVerified:
                                  data.docs[index].get('isVerified') ?? false,
                              acceptRequest:
                                  data.docs[index].get('acceptRequest') ??
                                      false,
                              cast: data.docs[index].get('cast') ?? "",
                              PhoneNumber:
                                  data.docs[index].get('PhoneNumber') ??
                                      "" ??
                                      "",
                              about: data.docs[index].get('about') ?? "",
                              city: data.docs[index].get('city') ?? "",
                              color: data.docs[index].get('color') ?? "",
                              country: data.docs[index].get('country') ?? "",
                              dateOfBirth:
                                  data.docs[index].get('dateOfBirth') ?? "",
                              firstName:
                                  data.docs[index].get('firstName') ?? "",
                              gender: data.docs[index].get('gender') ?? "",
                              height: data.docs[index].get('height') ?? "",
                              howDidYouHearAboutUs: data.docs[index]
                                      .get('howDidYouHearAboutUs') ??
                                  "",
                              id: data.docs[index].get('id') ?? "",
                              lastName: data.docs[index].get('lastName') ?? "",
                              maritalStatus:
                                  data.docs[index].get('maritalStatus') ?? "",
                              profileImage:
                                  data.docs[index].get('profileImage') ?? "",
                              religion: data.docs[index].get('religion') ?? "",
                              state: data.docs[index].get('state') ?? "",
                              isLike: data.docs[index].get('isLike') ?? false,
                              isRequestPlaced:
                                  data.docs[index].get('isRequestPlaced') ?? "",
                              email: data.docs[index].get('email') ?? "",
                              location: data.docs[index].get('location') ?? ""),
                          onTap: () {
                            // debugger();
                            Navigator.pushNamed(
                              context,
                              ProfileDetailScreen.route,
                              arguments: {
                                'model': UserModel(
                                    isVerified:
                                        data.docs[index].get('isVerified') ??
                                            false,
                                    acceptRequest:
                                        data.docs[index].get('acceptRequest') ??
                                            false,
                                    cast: data.docs[index].get('cast') ?? "",
                                    PhoneNumber:
                                        data.docs[index].get('PhoneNumber'),
                                    about: data.docs[index].get('about'),
                                    city: data.docs[index].get('city'),
                                    color: data.docs[index].get('color'),
                                    country: data.docs[index].get('country'),
                                    dateOfBirth:
                                        data.docs[index].get('dateOfBirth'),
                                    firstName:
                                        data.docs[index].get('firstName'),
                                    gender: data.docs[index].get('gender'),
                                    height: data.docs[index].get('height'),
                                    howDidYouHearAboutUs: data.docs[index]
                                        .get('howDidYouHearAboutUs'),
                                    id: data.docs[index].get('id'),
                                    lastName: data.docs[index].get('lastName'),
                                    maritalStatus:
                                        data.docs[index].get('maritalStatus'),
                                    profileImage:
                                        data.docs[index].get('profileImage'),
                                    religion: data.docs[index].get('religion'),
                                    state: data.docs[index].get('state'),
                                    isLike: data.docs[index].get('isLike'),
                                    isRequestPlaced:
                                        data.docs[index].get('isRequestPlaced'),
                                    email: data.docs[index].get('email'),
                                    location: data.docs[index].get('location')),
                              },
                            );
                          },
                        ),
                      );
                    }
                  }
                  if (profileTiles.isEmpty) {
                    return Center(
                      child: Text(
                        "No Data",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.poppinsRegular().copyWith(
                            color: AppColors.black, fontSize: 20.sp, height: 4),
                      ),
                    );
                    // / or any other loading widget
                  }
                  // debugger();
                  return Column(
                    children: profileTiles,
                  );
                }

                return Center(
                    child: Text(
                  "No Profile",
                  style: TextStyle(fontSize: 18, color: AppColors.grey),
                ));
              },
            ),
            h2
          ],
        ),
      ),
    ));
  }
}
