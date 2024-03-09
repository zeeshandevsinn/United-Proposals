// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/admin/dashboard_view.dart';
import 'package:united_proposals_app/common-widgets/custom_textformfield.dart';
import 'package:united_proposals_app/controller/provider/auth_provider.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/resources/validator.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/root_screen.dart';

import '../bottom-sheets/forgot_password_sheet.dart';
import '../common-widgets/custom_button.dart';
import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class AdminSignInScreen extends StatefulWidget {
  static String route = "/AdminSignInScreen";

  const AdminSignInScreen({super.key});

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final _formKey =
      GlobalKey<FormState>(); //used when login press and show email empty
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController =
      TextEditingController(/* text: 'hhhhhh@hhh.hhhm' */);
  TextEditingController passwordController =
      TextEditingController(/* text: '12345@' */);

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool ispObscure = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthVM>(builder: (context, vm, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, height: 25.h),
                  h2,
                  Text(
                    "Admin Login",
                    style: AppTextStyles.poppinsBold(
                      color: AppColors.primary,
                      fontSize: 18.sp,
                    ),
                  ),
                  h2,
                  CustomTextFormField(
                    fieldTitle: "Email",
                    controller: emailController,
                    hintText: 'Enter email',
                    focusNode: emailFocus,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.emailAddress,
                    validator: FieldValidator.validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    focusNode: passwordFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    validator: FieldValidator.validatePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: 'Enter password',
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
                  h2,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        {
                          // Get.bottomSheet(ChangePasswordSheet());
                          Get.bottomSheet(
                            const ForgotPasswordSheet(
                              title: 'Forgot Password?',
                              subTitle:
                                  'Enter your reqistered Email ID We will send you a link to reset your password',
                              labelText: 'Email',
                              placeHolder: 'Enter email',
                              text: 'Proceed',
                            ),
                            isScrollControlled: true,
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Forgot Password?",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.poppinsMedium(
                              fontSize: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  h2,
                  CustomButton(
                    text: "Login",
                    tap: () async {
                      if (_formKey.currentState!.validate()) {
                        // await login(vm);
                        if (emailController.text !=
                            "admin@unitedproposal.com") {
                          ZBotToast.showToastError(
                              message: "Your Email was Wrong");
                        } else if (passwordController.text != "Not77Secret%&") {
                          ZBotToast.showToastError(
                              message: "Your Password was Wrong");
                        } else
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => DashboardViewAdmin()),
                              (route) => false);
                        // SignInByFirebase(emailController.text.toString(),
                        //     passwordController.text.toString());
                      }
                      // Get.toNamed(UpdateProfileScreen.route);
                    },
                  ),
                  h2,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  SignInByFirebase(email, password) async {
    try {
      ZBotToast.loadingShow();
      var data = await _auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());

      // ignore: unnecessary_null_comparison
      if (data != null) {
        ZBotToast.loadingClose();
        ZBotToast.showToastSuccess(message: "Login Succesfully");
        // Get.toNamed(.route);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RootScreen()));
      }
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }
}
