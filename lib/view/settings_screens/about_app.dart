import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/resources/dummy.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class AboutApplicationView extends StatefulWidget {
  static String route = "/about_application_view";

  const AboutApplicationView({Key? key}) : super(key: key);

  @override
  State<AboutApplicationView> createState() => _AboutApplicationViewState();
}
//

class _AboutApplicationViewState extends State<AboutApplicationView> {
  List<String> socials = [
    AppImages.facebook,
    AppImages.insta,
    AppImages.google,
    AppImages.twitter,
  ];
  List<String> data = [
    "Facebook",
    "Instagram",
    "Google",
    "Twitter",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar("About the Application"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10),
        children: [
          h2,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
            decoration: AppDecoration.decoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppImages.logo, height: 4.5.h),
                w1,
                Text(
                  "United Proposal",
                  style: AppTextStyles.poppinsBold(color: AppColors.black),
                ),
                Expanded(
                  child: Text(
                    'Version 0.0.1.1',
                    textAlign: TextAlign.end,
                    style: AppTextStyles.poppinsRegular(
                      color: AppColors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          h2,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
            decoration: AppDecoration.decoration(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingsText(title: "Website"),
                      h1,
                      Text(
                        "www.unitedproposal.com",
                        style: AppTextStyles.poppinsRegular(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // copy
                    Clipboard.setData(const ClipboardData(text: "www.unitedproposal.com"));
                    Get.snackbar(
                      'Website Copied',
                      "www.unitedproposal.com",
                      snackbarStatus: (status) {
                        debugPrint(status.toString());
                      },
                      snackPosition: SnackPosition.TOP,
                      icon: const Icon(Icons.file_copy_sharp),
                      shouldIconPulse: true,
                      barBlur: 5,
                      backgroundColor: AppColors.primary.withOpacity(.34),
                      duration: const Duration(seconds: 1),
                    );
                  },
                  child: Icon(
                    Icons.copy_rounded,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
          ),
          h2,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
            decoration: AppDecoration.decoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                headingsText(title: "Follow us "),
                h2P5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    socials.length,
                    (index) => Flexible(
                      child: Column(
                        children: [
                          Image.asset(
                            socials[index],
                            height: 4.h,
                            width: 4.h,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            data[index],
                            textAlign: TextAlign.center,
                            style: AppTextStyles.poppinsRegular(fontSize: 9.5.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          h2,
          ...List.generate(2, (index) => about("About United Proposal","United Proposals is not just an app but a way to find your soulmates on the Pakistan most trusted platform with 100% verified profiles. If you are single and want a partner that make your life beautiful by finding the partner of your choice. Your trust is our first priority and to get the real match you need to get yourself verified to have access with other verified profiles. Connect and find your partner just one click away.")),
          h4,
        ],
      ),
    );
  }

  Widget about(String title, String txt) {
    return Column(
      children: [
        Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(.8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: AppTextStyles.poppinsRegular(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
        Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.1),
                offset: const Offset(-1, -1),
                blurRadius: 6,
              ),
              BoxShadow(
                color: AppColors.grey.withOpacity(0.1),
                offset: const Offset(1, 1),
                blurRadius: 6,
              ),
            ],
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Text(
            txt,
            style: AppTextStyles.poppinsRegular(
              fontSize: 10.sp,
              color: AppColors.grey,
              letterSpacing: 0.6,
            ),
          ),
        ),
        h2,
      ],
    );
  }

  Text headingsText({required String title}) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: AppTextStyles.poppinsMedium(),
    );
  }
}
