import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_container_for_profile.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/affiliate_program_screen.dart';
import 'package:united_proposals_app/view/featured_profile/featured_profiles_view.dart';
import 'package:united_proposals_app/view/home_widgets/profile_tile_widget.dart';
import 'package:united_proposals_app/view/home_widgets/profile_widget.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isDrawerOpen = false;
  void initState() {
    var id = FirebaseAuth.instance.currentUser?.uid;
    context.read<RootProvider>().fetchUserData(id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<RootProvider>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: Column(
                  children: [
                    // TextField
                    // Text("data"),
                    h2,
                    MyWidget(
                      iconVar: Icons.text_snippet_rounded,
                      title: 'Affiliate Programs',
                      tap: () {
                        Get.toNamed(AffiliateProgramScreen.route);
                      },
                    ),
                    h0P7,
                    viewAllWidget("Featured Profiles", () {
                      Get.toNamed(FeaturedProfileScreen.route);
                    }),
                    h1,
                    Consumer<RootProvider>(
                      builder: (context, provider, child) {
                        provider.FilterUserbyRequest();
                        return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.all(6.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  provider.filteredUsers.length,
                                  (index) => ProfileWidget(
                                    model: UserModel(
                                        isVerified: provider
                                                .filteredUsers[index]
                                                .acceptRequest ??
                                            false,
                                        acceptRequest: provider
                                                .filteredUsers[index]
                                                .acceptRequest ??
                                            false,
                                        cast:
                                            provider.filteredUsers[index].cast,
                                        PhoneNumber: provider
                                            .filteredUsers[index].PhoneNumber,
                                        about:
                                            provider.filteredUsers[index].about,
                                        city:
                                            provider.filteredUsers[index].city,
                                        color:
                                            provider.filteredUsers[index].color,
                                        country: provider
                                            .filteredUsers[index].country,
                                        dateOfBirth: provider
                                            .filteredUsers[index].dateOfBirth,
                                        firstName: provider
                                            .filteredUsers[index].firstName,
                                        gender: provider
                                            .filteredUsers[index].gender,
                                        height: provider
                                            .filteredUsers[index].height,
                                        howDidYouHearAboutUs: provider
                                            .filteredUsers[index]
                                            .howDidYouHearAboutUs,
                                        id: provider.filteredUsers[index].id,
                                        lastName:
                                            provider.filteredUsers[index].lastName,
                                        maritalStatus: provider.filteredUsers[index].maritalStatus,
                                        profileImage: provider.filteredUsers[index].profileImage,
                                        religion: provider.filteredUsers[index].religion,
                                        state: provider.filteredUsers[index].state,
                                        isLike: provider.filteredUsers[index].isLike,
                                        isRequestPlaced: provider.filteredUsers[index].isRequestPlaced,
                                        email: provider.filteredUsers[index].email,
                                        location: provider.filteredUsers[index].location),
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
                      },
                    ),
                    h0P7,
                    viewAllWidget(
                      "Profiles",
                      () {
                        context.read<RootProvider>().selectedScreenValue = 0;
                        context.read<RootProvider>().update();
                        myProvider.pageController.jumpToPage(0);
                      },
                    ),
                    h1,
                    // Consumer<RootProvider>(
                    //   builder: (context, rootProvider, child) {
                    //     if (rootProvider != null &&
                    //         rootProvider.filteredUsers != null) {
                    //       return StreamBuilder(
                    //           stream: FirebaseFirestore.instance
                    //               .collection('users')
                    //               .snapshots(),
                    //           builder: (context, AsyncSnapshot snapshot) {
                    //             if (snapshot.hasData) {
                    //               QuerySnapshot data = snapshot.data;
                    //             }
                    //             return
                    //         });
                    //     } else {
                    //       // Provide a default Widget, such as Container
                    //       return Container();
                    //     }
                    //   },
                    // )
                    Consumer<RootProvider>(
                      builder: (context, provider, child) {
                        return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(6.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  provider.filteredUsers.length,
                                  (index) => ProfileTileWidget(
                                    model: UserModel(
                                        isVerified: provider
                                                .filteredUsers[index]
                                                .isVerified ??
                                            false,
                                        acceptRequest: provider
                                                .filteredUsers[index]
                                                .acceptRequest ??
                                            false,
                                        cast:
                                            provider.filteredUsers[index].cast ??
                                                "",
                                        PhoneNumber: provider
                                            .filteredUsers[index].PhoneNumber,
                                        about:
                                            provider.filteredUsers[index].about,
                                        city:
                                            provider.filteredUsers[index].city,
                                        color:
                                            provider.filteredUsers[index].color,
                                        country: provider
                                            .filteredUsers[index].country,
                                        dateOfBirth: provider
                                            .filteredUsers[index].dateOfBirth,
                                        firstName: provider.filteredUsers[index].firstName,
                                        gender: provider.filteredUsers[index].gender,
                                        height: provider.filteredUsers[index].height,
                                        howDidYouHearAboutUs: provider.filteredUsers[index].howDidYouHearAboutUs,
                                        id: provider.filteredUsers[index].id,
                                        lastName: provider.filteredUsers[index].lastName,
                                        maritalStatus: provider.filteredUsers[index].maritalStatus,
                                        profileImage: provider.filteredUsers[index].profileImage,
                                        religion: provider.filteredUsers[index].religion,
                                        state: provider.filteredUsers[index].state,
                                        isLike: provider.filteredUsers[index].isLike,
                                        isRequestPlaced: provider.filteredUsers[index].isRequestPlaced,
                                        email: provider.filteredUsers[index].email,
                                        location: provider.filteredUsers[index].location),
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
                      },
                    ),

                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance
                    //       .collection("users")
                    //       .snapshots(),
                    //   builder: (context, AsyncSnapshot snapshot) {
                    //     if (snapshot.hasData) {
                    //       QuerySnapshot data = snapshot.data;
                    //       return SingleChildScrollView(
                    //         scrollDirection: Axis.vertical,
                    //         padding: EdgeInsets.all(6.sp),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             ...List.generate(
                    //                 data.docs.length,
                    //                 (index) => ProfileTileWidget(
                    //                       model: UserModel(
                    //                           about:
                    //                               data.docs[index].get('about'),
                    //                           city:
                    //                               data.docs[index].get('city'),
                    //                           color:
                    //                               data.docs[index].get('color'),
                    //                           country: data.docs[index]
                    //                               .get('country'),
                    //                           dateOfBirth: data.docs[index]
                    //                               .get('dateOfBirth'),
                    //                           firstName: data.docs[index]
                    //                               .get('firstName'),
                    //                           gender: data.docs[index]
                    //                               .get('gender'),
                    //                           height: data.docs[index]
                    //                               .get('height'),
                    //                           PhoneNumber: data.docs[index]
                    //                               .get('PhoneNumber'),
                    //                           howDidYouHearAboutUs: data.docs[index]
                    //                               .get('howDidYouHearAboutUs'),
                    //                           id: data.docs[index].get('id'),
                    //                           lastName: data.docs[index]
                    //                               .get('lastName'),
                    //                           maritalStatus: data.docs[index]
                    //                               .get('maritalStatus'),
                    //                           profileImage: data.docs[index]
                    //                               .get('profileImage'),
                    //                           religion: data.docs[index]
                    //                               .get('religion'),
                    //                           state:
                    //                               data.docs[index].get('state'),
                    //                           isLike: data.docs[index]
                    //                               .get('isLike'),
                    //                           isRequestPlaced: data.docs[index]
                    //                               .get('isRequestPlaced'),
                    //                           email: data.docs[index].get('email'),
                    //                           location: data.docs[index].get('location')),
                    //                       onTap: () {
                    //                         Navigator.pushNamed(
                    //                           context,
                    //                           ProfileDetailScreen.route,
                    //                           arguments: {
                    //                             'model': RootProvider()
                    //                                 .filteredUsers[index]
                    //                           },
                    //                         );
                    //                       },
                    //                     ),
                    //                 growable: true)
                    //           ],
                    //         ),
                    //       );
                    //     } else {
                    //       // Provide a default Widget, such as Container
                    //       return ZBotToast.loadingShow();
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
              h2,
            ],
          ),
        ),
      ),
    );
  }

  Widget viewAllWidget(String title, Function() onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.poppinsSemiBold(
              color: AppColors.black, fontSize: 15.sp),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'View All',
            style: AppTextStyles.poppinsRegular().copyWith(
              fontSize: 10.sp,
              color: AppColors.primary,
              decoration: TextDecoration.underline,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
