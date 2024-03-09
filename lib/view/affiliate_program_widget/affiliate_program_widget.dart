// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/models/affiliate_program_model.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/visit_screens/detailed_affiliate_screen.dart';

class AffiliateProgramWidget extends StatefulWidget {
  AffilateProgramModel model;

  AffiliateProgramWidget({super.key, required this.model});

  @override
  State<AffiliateProgramWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<AffiliateProgramWidget> {
  @override
  Widget build(BuildContext context) {
    // String profileImage = widget.model.profileImage.toString();
    return GestureDetector(
      onTap: () {
        debugPrint('clicked');
        visitProfileFn();
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(bottom: 3.w),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
        decoration: AppDecoration.decoration(radius: 14),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 18.w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.model.profileImage ??
                            "data:image/jpeg;base64,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"),
                        fit: BoxFit.contain)),
              ),
              // Container(
              //     width: 18.w,
              //     height: 18.w,
              //     child: Image.network(
              //         "https://pixels.com/shop/posters/proposals+image")),
              // ImageWidget(
              //   profileImage: widget.model.profileImage ??
              //       "https://pixels.com/shop/posters/proposals+image",
              //   size: 18.w,
              //   isRadius: true,
              // ),
              w2,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.model.fullName.toString(),
                            style: AppTextStyles.poppinsMedium(fontSize: 10.sp),
                          ),
                          Text(
                            widget.model.location.toString(),
                            style: AppTextStyles.poppinsRegular(
                                fontSize: 10.sp, color: Colors.grey),
                          ),
                          Text(
                            widget.model.phoneNumber ?? "",
                            style: AppTextStyles.poppinsRegular(
                                fontSize: 10.sp, color: Colors.grey),
                          ),
                          Text(
                            widget.model.category ?? "",
                            style: AppTextStyles.poppinsRegular(
                                fontSize: 10.sp, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            visitProfileFn();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.sp, vertical: 5.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColors.blue,
                            ),
                            child: Text(
                              "Visit",
                              style: AppTextStyles.poppinsMedium(
                                fontSize: 8.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void visitProfileFn() {
    Get.toNamed(DetailedAffiliateScreen.route,
        arguments: {"model": widget.model});
  }
}
