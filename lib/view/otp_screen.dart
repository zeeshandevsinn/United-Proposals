import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import '../bottom-sheets/change_password_sheet.dart';
import '../common-widgets/custom_button.dart';
import '../resources/validator.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

class OtpScreen extends StatefulWidget {
  //String route = "/otpscreen";
  final String? email;
  final bool isEmail;
  final VoidCallback onTap;
  const OtpScreen(
      {super.key, this.email, required this.isEmail, required this.onTap});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

final formKey = GlobalKey<FormState>();
final TextEditingController textEditingController = TextEditingController();
const interval = Duration(seconds: 1);
const int timerMaxSeconds = 59;
final Timer _timer = Timer(const Duration(seconds: 0), () {});
int currentSeconds = 0;
String currentText = "";

@override
void initState() {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    startTimeout();
  });
//  super.initState();
}

void startTimeout() {
  var duration = interval;
  Timer.periodic(duration, (timer) {
    currentSeconds = timer.tick;
    if (timer.tick >= timerMaxSeconds) timer.cancel();
    //  setState(() {});
  });
}

@override
void dispose() {
  _timer.cancel();
  // super.dispose();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
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
              h2,
              Text(
                "Enter OTP",
                style: AppTextStyles.poppinsBold(
                  fontSize: 15.sp,
                ),
              ),
              h2,
              (widget.isEmail)
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "Enter the OTP code that you have received on your email address",
                          style: AppTextStyles.poppinsRegular(
                            color: AppColors.grey,
                          ),
                          children: <TextSpan>[
                            const TextSpan(text: " "),
                            TextSpan(
                              text: widget.email!.replaceRange(
                                  2,
                                  widget.email!.split("@").first.length,
                                  "******"),
                              style: AppTextStyles.poppinsRegular(
                                fontSize: 12.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "Enter the OTP code that you have received on your phone number",
                          style: AppTextStyles.poppinsRegular(
                            fontSize: 12.sp,
                            color: AppColors.grey,
                          ),
                          children: <TextSpan>[
                            const TextSpan(text: " "),
                            TextSpan(
                              text: widget.email!,
                              style: AppTextStyles.poppinsRegular(
                                fontSize: 12.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              if (widget.isEmail == false)
                Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                  child: Text(
                    "Change Number",
                    style: AppTextStyles.poppinsRegular(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black)
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              if (widget.isEmail == true) h3,
              Form(key: formKey, child: otpCodeWidget()),
              h3,
              CustomButton(text: "Proceed", tap: () => onTapSubmitFN()),
              h2,
            ],
          ),
        ),
      ),
    );
  }

  Widget otpCodeWidget() {
    return Column(
      children: [
        PinCodeTextField(
          textStyle: AppTextStyles.poppinsRegular().copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp),
          appContext: context,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 30.sp,
              fieldWidth: 30.sp,
              errorBorderColor: Colors.red,
              inactiveColor: AppColors.grey,
              activeColor: AppColors.blue.withOpacity(.3),
              selectedColor: AppColors.blue.withOpacity(.3),
              selectedFillColor: AppColors.grey.withOpacity(.1),
              disabledColor: AppColors.primary,
              activeFillColor: AppColors.blue.withOpacity(.1),
              inactiveFillColor: AppColors.grey.withOpacity(.1)),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: AppColors.white,
          cursorColor: AppColors.primary,
          enableActiveFill: true,
          controller: textEditingController,
          keyboardType: TextInputType.number,
          validator: (value) =>
              FieldValidator.validateOTP(textEditingController.text),
          onCompleted: (v) {},
          onChanged: (value) {
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive code?",
              style: AppTextStyles.poppinsRegular(
                  fontSize: 12.sp, color: AppColors.black),
            ),
            Text(' $timerText',
                style: AppTextStyles.poppinsRegular(
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600)),
          ],
        ),
        h1,
        GestureDetector(
          onTap: () async {
            if (currentSeconds == timerMaxSeconds) {
              startTimeout();
            }
          },
          child: Text('Resend?',
              style: AppTextStyles.poppinsBold(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: currentSeconds == timerMaxSeconds
                    ? AppColors.primary
                    : AppColors.black,
              ).copyWith(decoration: TextDecoration.underline)),
        )
      ],
    );
  }

  void onTapSubmitFN() {
    if (formKey.currentState!.validate()) {
      Get.back();
      Get.bottomSheet(
        ChangePasswordSheet(
            // email: widget.email.toString(),
            ),
        isScrollControlled: true,
      );
    }
  }

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  void stopTimeout() {
    _timer.cancel();
    setState(() {});
  }
}
