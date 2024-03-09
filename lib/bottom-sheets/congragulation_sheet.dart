import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class CongratulationsSheet extends StatefulWidget {
  final void Function() onApprove;
  final String subTitle;
  final bool? buttonShow;

  const CongratulationsSheet(
      {super.key, required this.onApprove, required this.subTitle, this.buttonShow});

  @override
  State<CongratulationsSheet> createState() => _CongratulationsSheetState();
}

class _CongratulationsSheetState extends State<CongratulationsSheet> {
  @override
  void initState() {
    initFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(26.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.16),
            offset: const Offset(0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          h1,
          Icon(
            Icons.thumb_up_alt_outlined,
            color: AppColors.primary,
            size: 45.sp,
          ),
          h3,
          Text(
            "Congratulations",
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsBold(color: AppColors.black, fontSize: 15.sp),
          ),
          h1P5,
          Text(
            widget.subTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsRegular(
              fontSize: 12.sp,
              color: AppColors.grey,
            ),
          ),
          h5,
          if (widget.buttonShow ?? false)
            SizedBox(
              width: 90.w,
              child: CustomButton(
                text: 'Login',
                tap: widget.onApprove,
              ),
            ),
          h1,
        ],
      ),
    );
  }

  void initFn() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!(widget.buttonShow ?? false)) {
        Future.delayed(
          const Duration(seconds: 3),
          () => widget.onApprove(),
        );
      }
    });
  }
}
