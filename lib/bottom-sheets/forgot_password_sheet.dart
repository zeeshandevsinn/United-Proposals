// ignore_for_file: must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/splash_screen.dart';
import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../controller/provider/auth_provider.dart';
import '../resources/validator.dart';

class ForgotPasswordSheet extends StatefulWidget {
  final String title;
  final String subTitle;
  final String text;
  final String labelText;
  final String placeHolder;
  final bool? isFromDelete;

  const ForgotPasswordSheet({
    super.key,
    required this.title,
    required this.subTitle,
    required this.text,
    required this.labelText,
    required this.placeHolder,
    this.isFromDelete = false,
  });

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  FocusNode emailFocus = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();
  bool isObscure1 = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> deleteAccount(String password) async {
    try {
      ZBotToast.loadingShow();
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      debugger();
      if (user != null) {
        // Reauthenticate user with their current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);

        // Delete the user account

        var uid = FirebaseAuth.instance.currentUser?.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
        await user.delete();

        ZBotToast.loadingClose();
        ZBotToast.showToastSuccess(message: "Account deleted successfully!");
        // print("");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashScreen()),
            (Route<dynamic> route) => false);
        Get.toNamed(SplashScreen.route);
      } else {
        ZBotToast.loadingClose();
        ZBotToast.showToastError(message: "User not signed in.");
      }
    } catch (e) {
      ZBotToast.showToastError(message: "Error deleting account:$e.");
    }
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password resent link sent! check your mail"),
            );
          });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.toString()));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthVM>(builder: (context, vm, _) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
        width: 100.w,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              h2,
              Text(
                widget.title,
                style: AppTextStyles.poppinsBold(
                    color: AppColors.black, fontSize: 15.sp),
              ),
              h2,
              Text(
                widget.subTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsRegular(color: AppColors.black),
              ),
              h2,
              if (widget.isFromDelete ?? false)
                CustomTextFormField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.visiblePassword,
                  validator: FieldValidator.validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'Enter password',
                  fieldTitle: "Password",
                  obscureText: isObscure1,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure1 = !isObscure1;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.sp),
                      child: Icon(
                        isObscure1
                            ? Icons.visibility_off_rounded
                            : Icons.remove_red_eye_rounded,
                        color: Colors.grey,
                        size: 16.sp,
                      ),
                    ),
                  ),
                )
              else
                CustomTextFormField(
                  fieldTitle: widget.labelText,
                  controller: emailController,
                  hintText: widget.placeHolder,
                  focusNode: emailFocus,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                  validator: FieldValidator.validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              h3,
              if (widget.isFromDelete ?? false)
                CustomButton(
                  text: widget.text,
                  // tap: passwordReset(),
                  tap: () {
                    if (_formKey.currentState!.validate()) {
                      deleteAccount(passwordController.text);
                      // debugger();
                      // otp(vm, emailController.text);
                      // if (widget.isFromDelete ?? false) {
                      //   Get.back();
                      //   Get.offAllNamed(LoginScreen.route);
                      // } else {
                      //   Get.back();
                      //   Get.bottomSheet(
                      //     OTPSheet(
                      //       email: emailController.text,
                      //       onTap: () {},
                      //       isEmail: true,
                      //     ),
                      //     isScrollControlled: true,
                      //   );
                      // }
                    }
                  },
                )
              else
                CustomButton(
                  text: widget.text,
                  // tap: passwordReset(),
                  tap: () {
                    if (_formKey.currentState!.validate()) {
                      passwordReset();
                      // debugger();
                      // otp(vm, emailController.text);
                      // if (widget.isFromDelete ?? false) {
                      //   Get.back();
                      //   Get.offAllNamed(LoginScreen.route);
                      // } else {
                      //   Get.back();
                      //   Get.bottomSheet(
                      //     OTPSheet(
                      //       email: emailController.text,
                      //       onTap: () {},
                      //       isEmail: true,
                      //     ),
                      //     isScrollControlled: true,
                      //   );
                      // }
                    }
                  },
                ),
              h3,
            ],
          ),
        ),
      );
    });
  }

//   Future<void> otp(
//     AuthVM vm,
//     String email,
//   ) async {
//     ZBotToast.loadingShow();
//     var body = {
//       'email': email,
//     };
//     bool chack = await vm.otp(body: body);
//     if (chack) {
//       ZBotToast.loadingClose();
//     }
//   }
// }
}
