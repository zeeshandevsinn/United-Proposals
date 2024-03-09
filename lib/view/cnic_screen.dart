import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/controller/provider/location_provider.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';
import 'package:united_proposals_app/view/root_screen.dart';

import '../common-widgets/custom_button.dart';
import '../controller/provider/auth_provider.dart';
import '../services/image_picker/image_picker_option.dart';

class CNICScreen extends StatefulWidget {
  static String route = "/CNICScreen";
  const CNICScreen({super.key});

  @override
  State<CNICScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<CNICScreen> {
  File? frontImage;
  File? backImage;
  dynamic args;
  bool? isFromLogin;
  File? profileImage;
  File? backProfileImage;

  String? frontImageUrl;
  String? backImageUrl;

  String? _currentAddress;
  Position? currentPosition;

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ZBotToast.showToastError(message: "Click exit again!");
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["isFromLogin"] != null) {
          isFromLogin = args["isFromLogin"];
        }
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await onWillPop(),
      child: SafeArea(
        child: Consumer<AuthVM>(builder: (context, authVm, _) {
          return Scaffold(
            appBar: GlobalWidgets.appBar("Insert Your CNIC pic"),
            body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 11.0, horizontal: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  h1,
                  Text(
                    'CNIC or Licence Front side image:',
                    style: AppTextStyles.poppinsMedium(),
                  ),
                  h2,
                  pickImageWidget(authVm),
                  h2,
                  Text(
                    'CNIC or Licence Back side image:',
                    style: AppTextStyles.poppinsMedium(),
                  ),
                  h2,
                  Center(child: pickImageWidget2(authVm)),
                  h4,
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
              child: CustomButton(
                text: "Register",
                tap: () async {
                  ZBotToast.loadingShow();
                  var loc = context.read<LocationProvider>();

                  await loc.Location(context, currentPosition, _currentAddress);
                  ZBotToast.loadingShow();
                  await frontImageCNICStore(frontImage!);
                  await BackImageCNICStore(backImage!);
                  var uid = FirebaseAuth.instance.currentUser?.uid;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .update({"location": loc.currentAddress});

                  ZBotToast.loadingClose();
                  //   // Navigate to RootScreen
                  Get.toNamed(RootScreen.route);
                  // try {
                  //   // Upload images to Firebase Storage if not already uploaded
                  //   if (frontImage != null && backImage != null) {
                  //     await uploadImages();
                  //   }

                  //   // Store image URLs in Firestore's "cnic" collection
                  //   await FirebaseFirestore.instance.collection('cnic').add({
                  //     'frontImageUrl': frontImageUrl,
                  //     'backImageUrl': backImageUrl,
                  //   });

                  // } catch (error) {
                  //   // Handle errors here
                  //   print("Error storing data: $error");
                  //   ZBotToast.showToastError(message: "Error storing data. Please try again.");
                  // }
                },
              ),
            ),
          );
        }),
      ),
    );
  }

  frontImageCNICStore(File image) async {
    final ref1 = FirebaseStorage.instance.ref().child('cnic/${image.path}');
    final uploadTask1 = ref1.putFile(image);
    final downloadURL =
        await uploadTask1.then((snapshot) => snapshot.ref.getDownloadURL());

    // Store image URL in Firestore
    FirebaseFirestore.instance.collection('cnic').add({
      'imageUrl_front': downloadURL,
    });
  }

  BackImageCNICStore(File image) async {
    //   // Upload image to Firebase Storage
    final ref2 = FirebaseStorage.instance.ref().child('cnic/${image.path}');
    final uploadTask2 = ref2.putFile(image);
    final downloadURL =
        await uploadTask2.then((snapshot) => snapshot.ref.getDownloadURL());

    // Store image URL in Firestore
    FirebaseFirestore.instance.collection('cnic').add({
      'imageUrl_back': downloadURL,
    });
  }

  Widget pickImageWidget(AuthVM vm) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        final File? pickedImage = await Get.dialog<File>(ImagePickerOption(
          uploadImage: (value) async {
            if (value != null) {
              profileImage = value;
              vm.update();
              setState(() {});
              frontImage = value;
              // await uploadImage(profileImage!);

              // if (num == 1) {
              //   // Upload image to Firebase Storage

              // if (num == 2) {
              //   // Upload image to Firebase Storage
              //   final ref2 = FirebaseStorage.instance
              //       .ref()
              //       .child('cnic_back/${value.path}');
              //   final uploadTask2 = ref2.putFile(value);
              //   final downloadURL = await uploadTask2
              //       .then((snapshot) => snapshot.ref.getDownloadURL());

              //   // Store image URL in Firestore
              //   FirebaseFirestore.instance.collection('cnic_back').add({
              //     'imageUrl_back': downloadURL,
              //   });
              // }
            }
          },
          isPhotoPicked: profileImage == null ? false : true,
          removeImageFn: () {
            profileImage = null;
            setState(() {});
            Navigator.pop(context);
          },
        ));
        // Get.dialog(
        //   ImagePickerOption(
        //     // uploadImage: (value) async {
        //     //   // if (value != null) {
        //     //   //   profileImage = value;
        //     //   //   vm.update();
        //     //   //   setState(() {});
        //     //   // }
        //     // },
        //     isPhotoPicked: profileImage == null ? false : true,
        //     removeImageFn: () {
        //       profileImage = null;
        //       setState(() {});
        //       Navigator.pop(context);
        //     },
        //   ),
        // );
      },
      child: Container(
        alignment: Alignment.center,
        width: 80.sp,
        height: 80.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(width: 3.0, color: AppColors.primary),
        ),
        child: Container(
          width: 70.sp,
          height: 70.sp,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColors.blue.withOpacity(.08)),
          child: profileImage == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Icon(
                    Icons.add,
                    size: 25.sp,
                    color: AppColors.primary,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.file(
                    File(profileImage?.path ?? ""),
                    width: 40.sp,
                    height: 40.sp,
                  )),
        ),
      ),
    );
  }

  Widget pickImageWidget2(AuthVM vm) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        final File? pickedImage = await Get.dialog<File>(ImagePickerOption(
          uploadImage: (value) async {
            if (value != null) {
              backProfileImage = value;
              vm.update();
              setState(() {});
              backImage = value;
              // await uploadImage(profileImage!);
              // if (num == 1) {
              //   // Upload image to Firebase Storage
              //   final ref1 = FirebaseStorage.instance
              //       .ref()
              //       .child('cnic_front/${value.path}');
              //   final uploadTask1 = ref1.putFile(value);
              //   final downloadURL = await uploadTask1
              //       .then((snapshot) => snapshot.ref.getDownloadURL());

              //   // Store image URL in Firestore
              //   FirebaseFirestore.instance.collection('cnic_front').add({
              //     'imageUrl_front': downloadURL,
              //   });
              // }
              // if (num == 2) {
              //   // Upload image to Firebase Storage
              //   final ref2 = FirebaseStorage.instance
              //       .ref()
              //       .child('cnic_back/${value.path}');
              //   final uploadTask2 = ref2.putFile(value);
              //   final downloadURL = await uploadTask2
              //       .then((snapshot) => snapshot.ref.getDownloadURL());

              //   // Store image URL in Firestore
              //   FirebaseFirestore.instance.collection('cnic_back').add({
              //     'imageUrl_back': downloadURL,
              //   });
              // }
            }
          },
          isPhotoPicked: backProfileImage == null ? false : true,
          removeImageFn: () {
            profileImage = null;
            setState(() {});
            Navigator.pop(context);
          },
        ));
        // Get.dialog(
        //   ImagePickerOption(
        //     // uploadImage: (value) async {
        //     //   // if (value != null) {
        //     //   //   profileImage = value;
        //     //   //   vm.update();
        //     //   //   setState(() {});
        //     //   // }
        //     // },
        //     isPhotoPicked: profileImage == null ? false : true,
        //     removeImageFn: () {
        //       profileImage = null;
        //       setState(() {});
        //       Navigator.pop(context);
        //     },
        //   ),
        // );
      },
      child: Container(
        alignment: Alignment.center,
        width: 80.sp,
        height: 80.sp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(width: 3.0, color: AppColors.primary),
        ),
        child: Container(
          width: 70.sp,
          height: 70.sp,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColors.blue.withOpacity(.08)),
          child: backProfileImage == null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Icon(
                    Icons.add,
                    size: 25.sp,
                    color: AppColors.primary,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.file(
                    File(backProfileImage?.path ?? ""),
                    width: 40.sp,
                    height: 40.sp,
                  )),
        ),
      ),
    );
  }

  Future<void> uploadImages() async {
    try {
      // ... upload logic
      final ref1 = FirebaseStorage.instance
          .ref()
          .child('cnic_front/${frontImage!.path}');
      final uploadTask1 = ref1.putFile(frontImage!);
      frontImageUrl =
          await uploadTask1.then((snapshot) => snapshot.ref.getDownloadURL());

      final ref2 =
          FirebaseStorage.instance.ref().child('cnic_back/${backImage!.path}');
      final uploadTask2 = ref2.putFile(backImage!);
      backImageUrl =
          await uploadTask2.then((snapshot) => snapshot.ref.getDownloadURL());
    } catch (error) {
      print("Error uploading images: $error");
      ZBotToast.showToastError(
          message: "Error uploading images. Please try again.");
    }
  }
}
