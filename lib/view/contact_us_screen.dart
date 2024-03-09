import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/resources/app_decoration.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common-widgets/custom_textformfield.dart';
import '../utils/app_colors.dart';
import '../utils/height_widths.dart';
import '../utils/text_style.dart';

class ContactUsScreen extends StatefulWidget {
  static String route = "/ContactUsScreen";
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  var titleController = TextEditingController();
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidgets.appBar('Contact Us'),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 8.sp),
                margin: EdgeInsets.only(bottom: 5.sp),
                decoration: AppDecoration.decoration(radius: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 18.sp,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: AppTextStyles.poppinsMedium(fontSize: 12.sp),
                          ),
                          Text(
                            'info@unitedproposals.com',
                            style: AppTextStyles.poppinsRegular(
                                color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              h4,
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: AppDecoration.decoration(radius: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: titleController,
                      hintText: 'Title',
                    ),
                    h2,
                    CustomTextFormField(
                      controller: messageController,
                      hintText: 'Write here',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              h2,
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(12.sp),
          child: CustomButton(
            text: "Send",
            tap: () async {
              String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }

              final Uri emailuri = Uri(
                  scheme: 'mailto',
                  path: 'info@unitedproposals.com',
                  query: encodeQueryParameters(<String, String>{
                    'subject': titleController.text,
                    'body': messageController.text,
                  }));
              try {
                launchUrl(emailuri);
              } catch (e) {
                print(e.toString());
              }

//  if(await canLaunchUrl(emailuri)){
//               launchUrl(emailuri);

//                 }else{
//                   throw Exception('Could not launch $emailuri');
//                 }

              // // if (_formKey.currentState!.validate()) {
              // // Get.offAllNamed(LoginScreen.route);
              // Get.back();
              // // }
            },
          ),
        ),
      ),
    );
  }
}
