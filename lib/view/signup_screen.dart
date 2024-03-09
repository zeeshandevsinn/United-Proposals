import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/bottom-sheets/otp_sheet.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/resources/validator.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/login_screen.dart';
import 'package:united_proposals_app/view/update_profile.dart';

import '../common-widgets/custom_button.dart';
import '../common-widgets/custom_textformfield.dart';
import '../controller/provider/auth_provider.dart';
import '../controller/provider/root_provider.dart';

class SignupScreen extends StatefulWidget {
  static String route = "/signupScreen";
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  showSnackBar(context, text) {
    var snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar((snackBar));
  }

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController dateCon = TextEditingController();
  DateTime? selectedDate;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmpasswordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode dateFocus = FocusNode();
  FocusNode genderFn = FocusNode();

  bool isObscure1 = false;
  bool isObscure2 = false;

  bool isChecked = false;
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  TextEditingController phoneNumberController = TextEditingController();

  FocusNode numberFN = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthVM, RootProvider>(builder: (context, authVm, vm, _) {
      return SafeArea(
        child: Scaffold(
          appBar: GlobalWidgets.appBar(
            "Sign Up",
            onTap: () {
              Get.offAllNamed(LoginScreen.route);
            },
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 12.sp),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  h3,
                  CustomTextFormField(
                    fieldTitle: "Full Name",
                    controller: nameController,
                    hintText: 'Enter name',
                    focusNode: nameFocus,
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.name,
                    validator: FieldValidator.validateEmpty,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
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
                  h1,
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
                  ),
                  CustomTextFormField(
                    controller: confirmpasswordController,
                    focusNode: confirmpasswordFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.visiblePassword,
                    validator: (val) => FieldValidator.validatePasswordMatch(
                        confirmpasswordController.text,
                        passwordController.text),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: 'Enter confirm password',
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
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          checkColor: AppColors.white,
                          activeColor: AppColors.primary,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          'I agree to the Privacy Policy and T&C.',
                        ),
                      ],
                    ),
                  ),
                  h1,
                  CustomButton(
                    text: "Sign up",
                    tap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!isChecked) {
                          ZBotToast.showToastError(
                              message:
                                  "Please agree to the Privacy Policy and T&C.");
                        } else {
                          // _auth
                          //     .createUserWithEmailAndPassword(
                          //         email: emailController.text.toString(),
                          //         password: passwordController.text.toString())
                          //     .then((value) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: ((context) =>
                          //               UpdateProfileScreen())));
                          // }).onError((error, stackTrace) {
                          //   ZBotToast.showToastError(message: error.toString());
                          // });
                          await signupByFirebase(
                              emailController.text.toString(),
                              passwordController.text.toString());
                          // await singup(authVm);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 8.sp),
            child: GlobalWidgets.authBottomWidget(
              "Already have an account?",
              '  LogIn',
              () => Get.offAllNamed(LoginScreen.route),
            ),
          ),
        ),
      );
    });
  }

  signupByFirebase(email, password) async {
    try {
      ZBotToast.loadingShow();
      var _auth = FirebaseAuth.instance;

      var data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      ZBotToast.loadingClose();
      if (data != null) {
        ZBotToast.showToastSuccess(message: "SignUp Successfully");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => UpdateProfileScreen(
                      email: emailController.text.toString(),
                    ))));
      }
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }

  Future<void> singup(AuthVM vm) async {
    ZBotToast.loadingShow();
    Map body = {
      "fullname": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "confirmpassword": confirmpasswordController.text.trim(),
    };
    // debugger();
    debugPrint("body:");
    debugPrint("$body");

    bool check = await vm.singup(body: body);

    if (check) {
      bool isOtpReceived =
          await vm.otp(body: {"email": emailController.text.trim()});
      if (isOtpReceived) {
        debugPrint("");
        Get.bottomSheet(
          OTPSheet(
            email: emailController.text,
            onTap: () {
              Get.back();
            },
            isEmail: true,
          ),
          isScrollControlled: true,
        );

        ZBotToast.loadingClose();
      }
    }
  }
}
