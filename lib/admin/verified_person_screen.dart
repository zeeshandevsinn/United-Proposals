import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/admin/admin_verift_tile_widget.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';

import '../controller/provider/root_provider.dart';
import '../models/user_model.dart';
import '../view/profile_detail_screen.dart';

class VerifiedProfileAdmin extends StatefulWidget {
  const VerifiedProfileAdmin({super.key});

  @override
  State<VerifiedProfileAdmin> createState() => _VerifiedProfileAdminState();
}

class _VerifiedProfileAdminState extends State<VerifiedProfileAdmin> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  updateAllUsersBooleanField() async {
    debugger();
    QuerySnapshot usersSnapshot = await usersCollection.get();

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Iterate through each user document and update the boolean field to false
    usersSnapshot.docs.forEach((userDoc) {
      batch.update(userDoc.reference, {'isVerified': false});
    });
// Commit the batch update
    await batch.commit();
  }

  List<UserModel> unverifiedUsers = [];
  getUnverifiedUsers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('isVerified', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // debugger();
        for (DocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
          UserModel user = UserModel(
            isVerified: userData['isVerified'] ?? false,
            about: userData['about'] ?? '',
            city: userData['city'] ?? '',
            color: userData['color'] ?? '',
            country: userData['country'] ?? '',
            dateOfBirth: userData['dateOfBirth'] ?? '',
            firstName: userData['firstName'] ?? '',
            gender: userData['gender'] ?? '',
            height: userData['height'] is double ? userData['height'] : 0.0,
            howDidYouHearAboutUs: userData['howDidYouHearAboutUs'] ?? '',
            id: userData['id'] ?? '',
            lastName: userData['lastName'] ?? '',
            maritalStatus: userData['maritalStatus'] ?? '',
            profileImage: userData['profileImage'] ?? '',
            religion: userData['religion'] ?? '',
            state: userData['state'] ?? '',
            location: userData['location'] ?? '',
            PhoneNumber: userData['PhoneNumber'] ?? '',
            cast: userData['cast'] ?? '',
            email: userData['email'] ?? '',
            isLike: userData['isLike'] is bool ? userData['isLike'] : false,
            isRequestPlaced: userData['isRequestPlaced'] is bool
                ? userData['isRequestPlaced']
                : false,
            acceptRequest: userData['acceptRequest'] is bool
                ? userData['acceptRequest']
                : false,
          );
          setState(() {});
          unverifiedUsers.add(user);
        }
      }
    } catch (e) {
      print('Error getting unverified users: $e');
    }

    return unverifiedUsers;
  }

  List<UserModel> usersList = [];

  @override
  void initState() {
    // TODO: implement initState
    unverifiedUsers = [];
    getUnverifiedUsers();
    super.initState();
  }

  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size * 1;
    return SafeArea(
      child: Scaffold(
          appBar: GlobalWidgets.appBar("Verified Profiles"),
          body:
              // Container(
              //   color: Colors.black,
              //   child: Center(
              //     child: Text(
              //       "Verified User",
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
              //           fontSize: 24.0),
              //     ),
              //   ),
              // )
              SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Consumer<RootProvider>(
                        builder: (context, provider, child) {
                          // provider.FilterUserbyRequest();
                          if (unverifiedUsers.isEmpty) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return SingleChildScrollView(
                                padding: EdgeInsets.all(6.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                      unverifiedUsers.length,
                                      (index) => AdminVerifyTileWidget(
                                        model: UserModel(
                                            isVerified: unverifiedUsers[index]
                                                .isVerified,
                                            acceptRequest:
                                                unverifiedUsers[index]
                                                    .acceptRequest,
                                            cast: unverifiedUsers[index].cast,
                                            PhoneNumber: unverifiedUsers[index]
                                                .PhoneNumber,
                                            about: unverifiedUsers[index].about,
                                            city: unverifiedUsers[index].city,
                                            color: unverifiedUsers[index].color,
                                            country:
                                                unverifiedUsers[index].country,
                                            dateOfBirth: unverifiedUsers[index]
                                                .dateOfBirth,
                                            firstName: unverifiedUsers[index]
                                                .firstName,
                                            gender:
                                                unverifiedUsers[index].gender,
                                            height:
                                                unverifiedUsers[index].height,
                                            howDidYouHearAboutUs:
                                                unverifiedUsers[index]
                                                    .howDidYouHearAboutUs,
                                            id: unverifiedUsers[index].id,
                                            lastName:
                                                unverifiedUsers[index].lastName,
                                            maritalStatus:
                                                unverifiedUsers[index]
                                                    .maritalStatus,
                                            profileImage: unverifiedUsers[index]
                                                .profileImage,
                                            religion:
                                                unverifiedUsers[index].religion,
                                            state: unverifiedUsers[index].state,
                                            isLike:
                                                unverifiedUsers[index].isLike,
                                            isRequestPlaced:
                                                unverifiedUsers[index]
                                                    .isRequestPlaced,
                                            email: unverifiedUsers[index].email,
                                            location: unverifiedUsers[index]
                                                .location),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            ProfileDetailScreen.route,
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
