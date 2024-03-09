import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/controller/provider/root_provider.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/home_widgets/profile_tile_widget.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

class FeaturedProfileScreen extends StatefulWidget {
  static String route = "/featuredProfileScreen";
  const FeaturedProfileScreen({super.key});

  @override
  State<FeaturedProfileScreen> createState() => _FeaturedProfileScreenState();
}

class _FeaturedProfileScreenState extends State<FeaturedProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Featured Profiles",
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsRegular()
                .copyWith(color: AppColors.black, fontSize: 12.sp),
          ),
        ),
        body: Consumer<RootProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    h1,
                    if (provider.userList.isEmpty)
                      Center(
                        child: Text(
                          "No Data",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.poppinsRegular().copyWith(
                              color: AppColors.black,
                              fontSize: 20.sp,
                              height: 4),
                        ),
                      )
                    else
                      ...List.generate(
                        provider.userList.length,
                        (index) => ProfileTileWidget(
                          model: UserModel(
                              isVerified: provider.userList[index].isVerified,
                              acceptRequest:
                                  provider.userList[index].acceptRequest,
                              cast: provider.userList[index].cast,
                              PhoneNumber: provider.userList[index].PhoneNumber,
                              about: provider.userList[index].about,
                              city: provider.userList[index].city,
                              color: provider.userList[index].color,
                              country: provider.userList[index].country,
                              dateOfBirth: provider.userList[index].dateOfBirth,
                              firstName: provider.userList[index].firstName,
                              gender: provider.userList[index].gender,
                              height: provider.userList[index].height,
                              howDidYouHearAboutUs:
                                  provider.userList[index].howDidYouHearAboutUs,
                              id: provider.userList[index].id,
                              lastName: provider.userList[index].lastName,
                              maritalStatus:
                                  provider.userList[index].maritalStatus,
                              profileImage:
                                  provider.userList[index].profileImage,
                              religion: provider.userList[index].religion,
                              state: provider.userList[index].state,
                              isLike: provider.userList[index].isLike,
                              isRequestPlaced:
                                  provider.userList[index].isRequestPlaced,
                              email: provider.userList[index].email,
                              location: provider.userList[index].location),
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
      ),
    );

    // Consumer<RootProvider>(builder: (context, vm, _) {
    //   debugPrint("${vm.userList.length}");
    //   return SafeArea(
    //       child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.white,
    //       iconTheme: const IconThemeData(color: Colors.black),
    //       centerTitle: true,
    //       title: Text(
    //         "Featuredjj Profiles",
    //         textAlign: TextAlign.center,
    //         style: AppTextStyles.poppinsRegular()
    //             .copyWith(color: AppColors.black, fontSize: 12.sp),
    //       ),
    //     ),
    //     body: SingleChildScrollView(
    //       padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 12.sp),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           h1,
    //           if (vm.userList.isEmpty)
    //             Center(
    //               child: Text(
    //                 "No Data",
    //                 textAlign: TextAlign.center,
    //                 style: AppTextStyles.poppinsRegular().copyWith(
    //                     color: AppColors.black, fontSize: 20.sp, height: 4),
    //               ),
    //             )
    //           else
    //             ...List.generate(
    //               vm.userList.length,
    //               (index) => ProfileTileWidget(
    //                 model: vm.userList[index],onTap: (){},
    //               ),
    //             ),
    //           h2,
    //         ],
    //       ),
    //     ),
    //   ));
    // });
  }
}
