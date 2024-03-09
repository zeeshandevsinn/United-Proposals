// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/admin/verified_person_screen.dart';
import 'package:united_proposals_app/common-widgets/image_widget/image_widget.dart';
import 'package:united_proposals_app/models/user_model.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/profile_detail_screen.dart';

import '../../utils/height_widths.dart';
import '../../utils/zbotToast.dart';

// import 'package:firebase_querySnapshotbase/firebase_querySnapshotbase.dart';
class AdminVerifyTileWidget extends StatefulWidget {
  final UserModel model;
  final VoidCallback onTap;
  const AdminVerifyTileWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  State<AdminVerifyTileWidget> createState() => _AdminVerifyTileWidgetState();
}

class _AdminVerifyTileWidgetState extends State<AdminVerifyTileWidget> {
  // final ref = FirebasequerySnapshotbase.instance.ref("");

  Future<void> fetchquerySnapshot() async {
    // Assuming you have a "users" collection in Firestore
    // ignore: unused_local_variable
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        // Limit the number of items to 4
        .get();

    final List<UserModel> userModels = [];

    print(userModels);
  }

  bool? isLikedLocally;
  @override
  void initState() {
    super.initState();
    // fetchquerySnapshot();
    // getIsLikeValue(FirebaseAuth.instance.currentUser!.uid, widget.model.id);
    // setupFirebaseListener();
    print(isLikedLocally);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size * 1;
    var fullName = widget.model.firstName + " " + widget.model.lastName;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size.width > 900 ? size.width * .70 : size.width * .60,
              child: GestureDetector(
                onTap: () {
                  visitProfileFn();
                },
                child: Container(
                  width: 100.w,
                  margin: EdgeInsets.only(bottom: 3.w),
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightGrey.withOpacity(0.2),
                        offset: const Offset(3, 3.0),
                        blurRadius: 10.0,
                      ),
                      BoxShadow(
                        color: AppColors.lightGrey.withOpacity(0.2),
                        offset: const Offset(-3, -3.0),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        ImageWidget(
                          profileImage: widget.model.profileImage,
                          size: 18.w,
                          isRadius: true,
                        ),
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
                                      fullName,
                                      style: AppTextStyles.poppinsMedium(
                                          fontSize: 11.sp),
                                    ),
                                    Text(
                                      widget.model.dateOfBirth.toString(),
                                      style: AppTextStyles.poppinsRegular(
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      widget.model.maritalStatus,
                                      style: AppTextStyles.poppinsRegular(
                                          fontSize: 10.sp),
                                    ),
                                    Text(
                                      widget.model.location,
                                      style: AppTextStyles.poppinsRegular(
                                          fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  InkWell(
                                    onTap: () {
                                      visitProfileFn();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5.sp),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        color: AppColors.blue,
                                      ),
                                      child: Text(
                                        "Visit Profile",
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
              ),
            ),
            Container(
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  IconButton(
                      iconSize: size.width > 900 ? 50.0 : 30.0,
                      hoverColor: Colors.red,
                      onPressed: () {},
                      icon: Icon(Icons.close)),
                  IconButton(
                      iconSize: size.width > 900 ? 50.0 : 30.0,
                      hoverColor: Colors.green,
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.model.id)
                            .update({"isVerified": true});
                        ZBotToast.showToastSuccess(
                            message: "Done Verification");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => VerifiedProfileAdmin()),
                            (route) => false);
                        setState(() {});
                      },
                      icon: Icon(Icons.done))
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void visitProfileFn() {
    // Navigator.pus
    Get.toNamed(ProfileDetailScreen.route, arguments: {"model": widget.model});
  }
}
