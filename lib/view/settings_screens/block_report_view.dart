import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/common-widgets/custom_textformfield.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:united_proposals_app/resources/validator.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class BlockReportScreen extends StatefulWidget {
  const BlockReportScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlockReportScreenState createState() => _BlockReportScreenState();
}

class _BlockReportScreenState extends State<BlockReportScreen> {
  List<String> blockedUsers = []; // List of blocked user IDs

  // Function to block a user
  void blockUser(String userId) {
    setState(() {
      blockedUsers.add(userId);
    });
  }

  // Function to report a user
  void reportUser(String userId) {
    // Implement reporting logic here
  }

  // Function to check if a user is blocked
  bool isUserBlocked(String userId) {
    return blockedUsers.contains(userId);
  }

  TextEditingController aboutController = TextEditingController();
  FocusNode aboutFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12.sp),
          margin: EdgeInsets.all(12.sp),
          decoration: AppDecoration.decoration(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Block Report Form',
                      style: AppTextStyles.poppinsBold(),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.black,
                            )),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Please provide the following information:',
                  style: AppTextStyles.poppinsRegular(),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: aboutController,
                  hintText: 'Reason for Blocking',
                  focusNode: aboutFocus,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.text,
                  validator: FieldValidator.validateEmpty,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Block & Submit Report",
                  tap: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
