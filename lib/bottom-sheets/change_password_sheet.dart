// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../resources/validator.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';
import '../utils/zbotToast.dart';

class ChangePasswordSheet extends StatefulWidget {
  // String email;
  String? email;
  ChangePasswordSheet({super.key, this.email});

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  FocusNode passwordFocus = FocusNode();

  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();
  // FocusNode

  bool ispObscure = false;

  bool isObscure2 = false;

  bool ispOldObscure = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var auth = FirebaseAuth.instance;
  var currentuser = FirebaseAuth.instance.currentUser;
  CHANGEPASSWORD({email, oldpassword, newpassword}) async {
    // debugger();
    var cred =
        EmailAuthProvider.credential(email: email, password: oldpassword);

    await currentuser!.reauthenticateWithCredential(cred).then((value) {
      currentuser!.updatePassword(newpassword);
    }).catchError((e) {
      print(e.toString());
      ZBotToast.showToastError(message: e.toString());
    });
  }

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            h1,
            Text(
              'Update Password',
              style: AppTextStyles.poppinsBold(
                  color: AppColors.black, fontSize: 15.sp),
            ),
            h2,
            Text(
              'Must include letter number and symbols.',
              style: AppTextStyles.poppinsRegular(color: AppColors.black),
            ),
            h2,
            CustomTextFormField(
              controller: oldPasswordController,
              focusNode: oldPasswordFocus,
              inputAction: TextInputAction.next,
              inputType: TextInputType.visiblePassword,
              validator: FieldValidator.validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: 'Enter Old password',
              fieldTitle: "Password",
              obscureText: ispOldObscure,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    ispOldObscure = !ispOldObscure;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: Icon(
                    ispObscure
                        ? Icons.visibility_off_rounded
                        : Icons.remove_red_eye_rounded,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            CustomTextFormField(
              controller: newPasswordController,
              focusNode: passwordFocus,
              inputAction: TextInputAction.next,
              inputType: TextInputType.visiblePassword,
              validator: FieldValidator.validatePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: 'Enter New password',
              fieldTitle: "Password",
              obscureText: ispObscure,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    ispObscure = !ispObscure;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: Icon(
                    ispObscure
                        ? Icons.visibility_off_rounded
                        : Icons.remove_red_eye_rounded,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            CustomTextFormField(
              controller: confirmPasswordController,
              focusNode: confirmPasswordFocus,
              inputAction: TextInputAction.done,
              inputType: TextInputType.visiblePassword,
              validator: (val) => FieldValidator.validatePasswordMatch(
                  confirmPasswordController.text, newPasswordController.text),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              hintText: 'Re-enter New Password',
              fieldTitle: "Confirm Password",
              obscureText: isObscure2,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure2 = !isObscure2;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 8.sp),
                  child: Icon(
                    isObscure2
                        ? Icons.visibility_off_rounded
                        : Icons.remove_red_eye_rounded,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            h3,
            CustomButton(
                text: "Proceed",
                tap: () {
                  if (_formKey.currentState!.validate()) {
                    CHANGEPASSWORD(
                        email: widget.email,
                        newpassword: newPasswordController.text,
                        oldpassword: oldPasswordController.text);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
