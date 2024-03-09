import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/bottom-sheets/app_sheet.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/login_screen.dart';
import 'package:united_proposals_app/view/settings_screens/about_app.dart';
import 'package:united_proposals_app/view/settings_screens/profile_visibility_controls.dart';
import 'package:united_proposals_app/view/update_profile.dart';

import '../../bottom-sheets/forgot_password_sheet.dart';
import '../../bottom-sheets/update_password.dart';
import '../../common-widgets/custom_container_for_profile.dart';
import '../../utils/height_widths.dart';
import '../contact_us_screen.dart';
import 'privacy_policy_screen.dart';
import 'term_of_use_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    getUserProfile();
    super.initState();
  }

  getUserProfile() async {
    // ZBotToast.loadingShow();
    // debugger();
    try {
      var id = FirebaseAuth.instance.currentUser?.uid;
      var data =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      // debugger();
      // log(data.data() as String);
      if (data.exists) {
        userDetails = data;
      } else {
        userDetails = null;
      }
      // ZBotToast.loadingClose();
      setState(() {});
    } catch (e) {
      userDetails = null;
    }
  }

  var userDetails;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Column(
              children: [
                h2,

                if (userDetails != null)
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(.2),
                            radius: 70,
                            backgroundImage: NetworkImage(
                                userDetails.get('profileImage') ??
                                    AppImages.dummyImage),
                            onBackgroundImageError: (exception, stackTrace) {
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(.8),
                                      width: 1),
                                ),
                                child: const Icon(
                                  Icons.error,
                                  color: AppColors.black,
                                ),
                              );
                            },
                          ),
                        ),
                        h3,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userDetails.get('firstName') ?? "",
                              style: AppTextStyles.poppinsBold(fontSize: 15.sp),
                            ),
                            Text(" "),
                            Text(
                              userDetails.get('lastName') ?? "",
                              style: AppTextStyles.poppinsBold(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Text(userDetails.get('email') ?? "",
                            style: AppTextStyles.poppinsRegular()),
                      ],
                    ),
                  )
                else
                  Container(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Update your Profile Please!",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.poppinsRegular().copyWith(
                                color: AppColors.black,
                                fontSize: 20.sp,
                                height: 4),
                          ),
                        ),
                      ],
                    ),
                  ),

                // StreamBuilder(
                //     stream: FirebaseFirestore.instance
                //         .collection('users')
                //         .snapshots(),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         String uid =
                //             FirebaseAuth.instance.currentUser!.uid.toString();
                //         QuerySnapshot data = snapshot.data!;
                //         for (var i = 0; i < data.docs.length; i++) {
                //           if (data.docs[i].get('id') == uid) {
                //             return   }
                //         }
                //       }
                //       return Container(
                //         child: Column(
                //           children: [
                //             Center(
                //               child: CircleAvatar(
                //                 backgroundColor:
                //                     AppColors.primary.withOpacity(.2),
                //                 radius: 70,
                //                 backgroundImage:
                //                     NetworkImage(AppImages.dummyImage),
                //                 onBackgroundImageError:
                //                     (exception, stackTrace) {
                //                   Container(
                //                     decoration: BoxDecoration(
                //                       shape: BoxShape.circle,
                //                       borderRadius: BorderRadius.circular(100),
                //                       border: Border.all(
                //                           color:
                //                               AppColors.primary.withOpacity(.8),
                //                           width: 1),
                //                     ),
                //                     child: const Icon(
                //                       Icons.error,
                //                       color: AppColors.black,
                //                     ),
                //                   );
                //                 },
                //               ),
                //             ),
                //             h3,
                //             Text(
                //               "Null",
                //               style: AppTextStyles.poppinsBold(fontSize: 15.sp),
                //             ),
                //             Text('Null', style: AppTextStyles.poppinsRegular()),
                //           ],
                //         ),
                //       );
                //     }),

                h4,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h1,
                        MyWidget(
                          iconVar: Icons.remove_red_eye,
                          title: 'Profile Visibility Controls ',
                          tap: () {
                            Get.toNamed(ProfileVisibilityControls.route);
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.person_rounded,
                          title: 'Update profile ',
                          tap: () {
                            Get.toNamed(UpdateProfileScreen.route);
                          },
                        ),
                        // MyWidget(
                        //   iconVar: Icons.text_snippet_rounded,
                        //   title: 'Affiliate Programs',
                        //   tap: () {
                        //     Get.toNamed(AffiliateProgramScreen.route);
                        //   },
                        // ),
                        MyWidget(
                          iconVar: Icons.text_snippet_rounded,
                          title: 'Terms of use',
                          tap: () {
                            Get.toNamed(TermOfUseScreen.route);
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.privacy_tip_rounded,
                          title: 'Privacy Policy ',
                          tap: () {
                            Get.toNamed(PrivacyPolicyScreen.route);
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.contact_page,
                          title: 'Contact Us',
                          tap: () {
                            Get.toNamed(ContactUsScreen.route);
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.assessment,
                          title: 'About App',
                          tap: () {
                            Get.toNamed(AboutApplicationView.route);
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.lock,
                          title: 'Change Password',
                          tap: () {
                            // debugger();
                            Get.bottomSheet(
                              UpdatePasswordSheet(
                                email: userDetails.get('email') ?? "",
                              ),
                              isScrollControlled: true,
                            );
                          },
                        ),
                        MyWidget(
                          iconVar: Icons.delete_rounded,
                          title: 'Delete Account ',
                          tap: () {
                            Get.bottomSheet(
                              const ForgotPasswordSheet(
                                isFromDelete: true,
                                title: 'Delete Account',
                                subTitle:
                                    'Deleting your account will remove all your data from our database. It cannot be undone',
                                labelText: 'Password',
                                placeHolder: 'Enter Password',
                                text: 'Delete Account',
                              ),
                            );
                          },
                        ),
                        h4,
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(
                              AppBottomSheet(
                                  title: "Logout",
                                  subtitle: "Are you sure you want to logout?",
                                  onLeftTap: () => Get.back(),
                                  onRightTap: () {
                                    FirebaseAuth.instance.signOut();
                                    Get.offAllNamed(LoginScreen.route);
                                  }),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 8.sp),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: double.infinity,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 18.sp,
                                  color: AppColors.primary,
                                ),
                                w3,
                                Text(
                                  "Logout",
                                  style: AppTextStyles.poppinsRegular(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        h2,
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
