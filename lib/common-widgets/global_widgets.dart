import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/favourite_screen.dart';
import 'package:united_proposals_app/view/notification/view/notification_view.dart';

class GlobalWidgets {
  static showSnackBar(context, text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar((snackBar));
  }

  static Widget authBottomWidget(
      String firstTxt, String scndTxt, Function() onTap) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            firstTxt,
            style: AppTextStyles.poppinsMedium(
                fontSize: 10.sp, color: Colors.black),
          ),
          Text(
            scndTxt,
            style: AppTextStyles.poppinsMedium(
                fontSize: 12.sp,
                color: AppColors.primary,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static AppBar appBar(String text,
      {Function()? onTap, bool? showbackButton = true, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 2,
      title: Text(
        text,
        style: AppTextStyles.poppinsSemiBold(fontSize: 13.sp),
      ),
      leading: (showbackButton ?? false)
          ? IconButton(
              padding: EdgeInsets.zero,
              // iconSize: 15.sp,
              onPressed: onTap ??
                  () {
                    Get.back();
                  },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.black,
              ))
          : null,
      actions: actions,
    );
  }

  static AppBar homeAppBar(String title) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 2,
      leadingWidth: 35.w,
      leading: Container(
        margin: EdgeInsets.only(left: 2.w),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AppTextStyles.poppinsMedium(),
        ),
      ),
      title: Image.asset(AppImages.logo, height: 50, width: 50),
      centerTitle: true,
      actions: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(.16),
                spreadRadius: 3,
                blurRadius: 12,
                offset: const Offset(1, 1),
              ),
              BoxShadow(
                color: AppColors.grey.withOpacity(.16),
                spreadRadius: 3,
                blurRadius: 12,
                offset: const Offset(-1, -1),
              )
            ],
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(NotificationView.route);
            },
            child: ImageIcon(
              AssetImage(AppImages.notiIcon),
              color: AppColors.primary,
              size: 14.sp,
            ),
          ),
        ),
        w2,
        Container(
          padding: const EdgeInsets.all(8),
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(.16),
                spreadRadius: 1,
                offset: const Offset(1, 1),
              ),
              BoxShadow(
                color: AppColors.grey.withOpacity(.16),
                spreadRadius: 3,
                blurRadius: 12,
                offset: const Offset(-1, -1),
              )
            ],
            color: Colors.white,
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(FavouriteProfileScreen.route);
            },
            child: Icon(
              Icons.favorite,
              color: AppColors.primary,
              size: 14.sp,
            ),
          ),
        ),
        w2,
      ],
    );
  }
}
