import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class CustomData extends StatelessWidget {
  final String title;
  final String subTitle;
  const CustomData({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.poppinsMedium(
              fontSize: 12.sp,
              color: AppColors.black,
              letterSpacing: 0.45,
            ),
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            style: AppTextStyles.poppinsRegular(
              color: AppColors.grey,
              letterSpacing: 0.45,
            ),
          ),
        ),
      ],
    );
  }
}
