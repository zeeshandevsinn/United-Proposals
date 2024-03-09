import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/admin/dashboard_view.dart';
import 'package:united_proposals_app/admin/verified_person_screen.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/view/login_screen.dart';
import 'package:united_proposals_app/view/root_screen.dart';

import '../admin/admin_login_screen.dart';
import '../utils/app_colors.dart';
import '../utils/text_style.dart';

class SplashScreen extends StatefulWidget {
  static String route = "/splashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> startTimer() async {
    try {
      // Replace the following with your authentication logic
      bool isLoggedIn = await checkUserLoginStatus(); // Replace with your logic

      // if (isLoggedIn) {
      //   Get.offAllNamed(RootScreen.route); // Replace with your home screen route
      // } else {
      //   Get.offAllNamed(SignupScreen.route); // Replace with your signup screen route
      // }
      if (isLoggedIn) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (_) => DashboardViewAdmin()));
        Get.toNamed(RootScreen.route); // Replace with your home screen route
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdminSignInScreen()));
        // Get.toNamed(LoginScreen.route); // Replace with your signup screen route
      }
    } catch (e) {
      print("Error checking login status: $e");
      // Handle the error (e.g., navigate to the signup screen)
      Get.offAllNamed(LoginScreen.route);
    }
  }

  Future<bool> checkUserLoginStatus() async {
    // Replace this with your actual authentication logic
    // For example, you can use a GetX controller or another state management solution
    // to check if the user is logged in or not.
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await Future.delayed(const Duration(seconds: 5));
      return true;
      // pushUntil(context, RootScreen());
    } else {
      await Future.delayed(const Duration(seconds: 5));
      return false;
      // pushUntil(context, IntroSlider());
    } // Replace with your logic to check if the user is logged in
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.logo, scale: 4),
              Text(
                "UNITED PORPOSALS",
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsBold().copyWith(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
