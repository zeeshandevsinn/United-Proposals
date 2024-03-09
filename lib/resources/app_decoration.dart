import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class AppDecoration {
  static InputDecoration fieldDecoration(
      {Widget? preIcon,
      String? hintText,
      Widget? suffixIcon,
      double? radius,
      double? iconMinWidth,
      double? verticalPadding,
      Color? fillColor}) {
    return InputDecoration(
      // verticalPadding
      prefixIconConstraints: BoxConstraints(
        minWidth: iconMinWidth ?? 42,
      ),
      isDense: true,
      fillColor: AppColors.primary.withOpacity(.05),
      filled: true,
      focusColor: Colors.red,

      hintText: hintText ?? "Select",
      // contentPadding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 12),
      suffixIcon: suffixIcon != null ? Container(child: suffixIcon) : null,

      hintStyle: AppTextStyles.poppinsRegular(fontSize: 11.sp, color: Colors.grey),
      errorStyle: AppTextStyles.poppinsRegular(fontSize: 9.sp, color: Colors.red),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8)),
    );
  }

  static BoxDecoration decoration({double? radius}) {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(radius ?? 8),
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
    );
  }
}
