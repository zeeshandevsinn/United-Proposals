import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import '../utils/height_widths.dart';

class MyWidget extends StatelessWidget {
  final IconData iconVar;
  final String title;
  final VoidCallback? tap;
  const MyWidget({super.key, required this.iconVar, required this.title, required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
          margin: EdgeInsets.only(bottom: 5.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          // height: 6.h,
          width: double.infinity,
          child: Row(
            children: [
              Icon(iconVar, size: 14.sp),
              w2,
              Text(title, style: AppTextStyles.poppinsMedium(fontSize: 10.sp)),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
              )
            ],
          ),
        ),
      ),
    );
  }
}
