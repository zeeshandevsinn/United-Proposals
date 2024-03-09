// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/bottom-sheets/congragulation_sheet.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../resources/validator.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

class UpdatePasswordSheet extends StatefulWidget {
  String? email;

  UpdatePasswordSheet({Key? key, this.email}) : super(key: key);

  @override
  State<UpdatePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<UpdatePasswordSheet> {
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  FocusNode oldPasswordFocus = FocusNode();

  bool oldPassObs = false;
  bool ispObscure = false;
  bool isObscure2 = false;

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
      ZBotToast.showToastSuccess(message: "Update your Password Successfully!");
      Navigator.pop(context);
    }).catchError((e) {
      print(e.toString());
      ZBotToast.showToastError(message: e.toString());
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              h1,
              Text(
                'Change Password',
                style: AppTextStyles.poppinsBold(
                  color: AppColors.black,
                  fontSize: 15.sp,
                ),
              ),
              h2,
              Text(
                'Must include letter, number, and symbols.',
                style: AppTextStyles.poppinsRegular(color: AppColors.black),
              ),
              h2,
              CustomTextFormField(
                controller: oldPasswordController,
                focusNode: oldPasswordFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.visiblePassword,
                validator: FieldValidator.validateOldPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Old password',
                fieldTitle: "Old Password",
                obscureText: oldPassObs,
                suffixIcon: _buildVisibilityToggle(oldPassObs),
              ),
              CustomTextFormField(
                controller: newPasswordController,
                focusNode: passwordFocus,
                inputAction: TextInputAction.next,
                inputType: TextInputType.visiblePassword,
                validator: FieldValidator.validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Enter new password',
                fieldTitle: "Password",
                obscureText: ispObscure,
                suffixIcon: _buildVisibilityToggle(ispObscure),
              ),
              CustomTextFormField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,
                inputAction: TextInputAction.done,
                inputType: TextInputType.visiblePassword,
                validator: (val) => FieldValidator.validatePasswordMatch(
                  newPasswordController.text,
                  confirmPasswordController.text,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hintText: 'Re-enter new password',
                fieldTitle: "Confirm Password",
                obscureText: isObscure2,
                suffixIcon: _buildVisibilityToggle(isObscure2),
              ),
              h3,
              CustomButton(
                  text: "Proceed",
                  tap: () {
                    if (_formKey.currentState!.validate()) {
                      debugger();
                      CHANGEPASSWORD(
                          email: widget.email,
                          newpassword: newPasswordController.text,
                          oldpassword: oldPasswordController.text);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the visibility toggle icon
  Widget _buildVisibilityToggle(bool obscure) {
    return GestureDetector(
      onTap: () {
        setState(() {
          obscure = !obscure;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 8.sp),
        child: Icon(
          obscure ? Icons.visibility_off_rounded : Icons.remove_red_eye_rounded,
          color: Colors.grey,
          size: 16.sp,
        ),
      ),
    );
  }

  // Function to change the password
  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        // Prompt the user to re-enter their password for reauthentication
        AuthCredential credential = EmailAuthProvider.credential(
          email: widget.email!,
          password: oldPasswordController.text,
        );

        await user!.reauthenticateWithCredential(credential);

        // Now that the user is reauthenticated, change the password
        await user.updatePassword(newPasswordController.text);

        // Show congratulations sheet
        Get.bottomSheet(
          CongratulationsSheet(
            onApprove: () {
              Get.back();
            },
            subTitle: 'Your password has been updated successfully.',
          ),
          isScrollControlled: true,
        );
      } catch (e) {
        ZBotToast.showToastError(message: e.toString());
        print('Error changing password: $e');
        // Handle error (e.g., invalid credentials, network issues, etc.)
      }
    }
  }
}


// // ignore_for_file: must_be_immutable

// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:united_proposals_app/utils/zbotToast.dart';
// import '../common-widgets/custom_button.dart';
// import '../common-widgets/custom_textformfield.dart';
// import '../resources/validator.dart';
// import '../utils/app_colors.dart';
// import '../utils/height_widths.dart';
// import '../utils/text_style.dart';
// import 'congragulation_sheet.dart';

// class UpdatePasswordSheet extends StatefulWidget {
//   String? email;
//   UpdatePasswordSheet({super.key, this.email});

//   @override
//   State<UpdatePasswordSheet> createState() => _ChangePasswordSheetState();
// }

// class _ChangePasswordSheetState extends State<UpdatePasswordSheet> {
//   FocusNode passwordFocus = FocusNode();

//   FocusNode confirmPasswordFocus = FocusNode();
//   FocusNode oldPasswordFocus = FocusNode();

//   bool ispObscure = false;

//   bool isObscure2 = false;
//   bool oldPassObs = false;

//   TextEditingController oldPasswordController = TextEditingController();
//   TextEditingController newPasswordController = TextEditingController();

//   TextEditingController confirmPasswordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
//       width: 100.w,
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               h1,
//               Text(
//                 'Change Password',
//                 style: AppTextStyles.poppinsBold(
//                     color: AppColors.black, fontSize: 15.sp),
//               ),
//               h2,
//               Text(
//                 'Must include letter number and symbols.',
//                 style: AppTextStyles.poppinsRegular(color: AppColors.black),
//               ),
//               h2,
//               CustomTextFormField(
//                 controller: oldPasswordController,
//                 focusNode: oldPasswordFocus,
//                 inputAction: TextInputAction.next,
//                 inputType: TextInputType.visiblePassword,
//                 validator: FieldValidator.validateOldPassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 hintText: 'Old password',
//                 fieldTitle: "Old Password",
//                 obscureText: oldPassObs,
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       oldPassObs = !oldPassObs;
//                     });
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 8.sp),
//                     child: Icon(
//                       oldPassObs
//                           ? Icons.visibility_off_rounded
//                           : Icons.remove_red_eye_rounded,
//                       color: Colors.grey,
//                       size: 16.sp,
//                     ),
//                   ),
//                 ),
//               ),
//               CustomTextFormField(
//                 controller: newPasswordController,
//                 focusNode: passwordFocus,
//                 inputAction: TextInputAction.next,
//                 inputType: TextInputType.visiblePassword,
//                 validator: FieldValidator.validatePassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 hintText: 'Enter new password',
//                 fieldTitle: "Password",
//                 obscureText: ispObscure,
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       ispObscure = !ispObscure;
//                     });
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 8.sp),
//                     child: Icon(
//                       ispObscure
//                           ? Icons.visibility_off_rounded
//                           : Icons.remove_red_eye_rounded,
//                       color: Colors.grey,
//                       size: 16.sp,
//                     ),
//                   ),
//                 ),
//               ),
//               CustomTextFormField(
//                 controller: confirmPasswordController,
//                 focusNode: confirmPasswordFocus,
//                 inputAction: TextInputAction.done,
//                 inputType: TextInputType.visiblePassword,
//                 validator: (val) => FieldValidator.validatePasswordMatch(
//                     newPasswordController.text, confirmPasswordController.text),
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 hintText: 'Re-enter new password',
//                 fieldTitle: "Confirm Password",
//                 obscureText: isObscure2,
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       isObscure2 = !isObscure2;
//                     });
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 8.sp),
//                     child: Icon(
//                       isObscure2
//                           ? Icons.visibility_off_rounded
//                           : Icons.remove_red_eye_rounded,
//                       color: Colors.grey,
//                       size: 16.sp,
//                     ),
//                   ),
//                 ),
//               ),
//               h3,
//               CustomButton(
//                 text: "Proceed",
//                 tap: () {
//                   if (_formKey.currentState!.validate()) {
//                     Get.back();
//                     Get.bottomSheet(
//                       changePassword(
//                           widget.email.toString(),
//                           oldPasswordController.text.toString(),
//                           newPasswordController.text.toString()),
//                       isScrollControlled: true,
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to change the password
//   changePassword(String email, String oldPassword, String newPassword) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;

//     try {
//       debugger();
//       // Sign in the user with email and password
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: oldPassword,
//       );

//       // Get the currently logged in user
//       User? user = userCredential.user;

//       // Change the password for the logged-in user
//       await user!.updatePassword(newPassword);
//       CongratulationsSheet(
//         onApprove: () {
//           Get.back();
//         },
//         subTitle: 'Your password has been updated successfully.',
//       );
//     } catch (e) {
//       ZBotToast.showToastError(message: e.toString());
//       print('Error changing password: $e');
//       // Handle error (e.g., invalid credentials, network issues, etc.)
//     }
//   }
// }
