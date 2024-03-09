import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class AppBottomSheet extends StatefulWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final String? buttonLeft;
  final String? buttonRight;
  final Function()? onLeftTap;
  final Function()? onRightTap;
  final double? subtitleFontSize;
  final Color? leftButtonColor;
  final Color? rightButtonColor;

  const AppBottomSheet({
    Key? key,
    this.image,
    this.title,
    this.subtitle,
    this.buttonLeft,
    this.buttonRight,
    this.onLeftTap,
    this.onRightTap,
    this.subtitleFontSize,
    this.leftButtonColor,
    this.rightButtonColor,
  }) : super(key: key);

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(26), topLeft: Radius.circular(26)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            h2,
            Icon(
              Icons.help_center_outlined,
              size: 50.sp,
              color: AppColors.primary,
            ),
            h2,
            Text(
              widget.title ?? "",
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBold(
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Visibility(
              visible: widget.subtitle == null ? false : true,
              child: Text(
                widget.subtitle ?? '',
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsRegular(
                  fontSize: 13.sp,
                  color: AppColors.grey,
                  letterSpacing: 0.45,
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CustomButton(
                    color: widget.leftButtonColor ?? AppColors.blue,
                    text: widget.buttonLeft ?? "No",
                    tap: widget.onLeftTap ?? () => Get.back(),
                    textColor: AppColors.white,
                  )),
                  w2,
                  Expanded(
                      child: CustomButton(
                    color: widget.rightButtonColor ?? AppColors.primary,
                    text: widget.buttonRight ?? "Yes",
                    tap: widget.onRightTap ?? () {},
                    textColor: AppColors.white,
                  )),
                ],
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ));
  }
}
