import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';

class ProfileVisibilityControls extends StatefulWidget {
  static String route = "/profileVisibilityControls";
  const ProfileVisibilityControls({super.key});

  @override
  State<ProfileVisibilityControls> createState() =>
      _ProfileVisibilityControlsState();
}

class _ProfileVisibilityControlsState extends State<ProfileVisibilityControls> {
  List<String> title = ["Public", "Private", "Hidden"];
  List<String> desc = [
    "Profile can be seen by all registered members.",
    "Profile can only be seen by matched members or those you've interacted with.",
    "Temporarily hide your profile from all members.",
  ];
  List<String> titlePhoto = ["Public", "Private"];
  List<String> descPhoto = [
    "Visible to all.",
    "Visible only to matches.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar("Profile Visibility Controls"),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.sp, top: 8.sp),
            child: Text(
              'Profile Visibility',
              style: AppTextStyles.poppinsMedium(),
            ),
          ),
          ...List.generate(
            title.length,
            (index) => visibilityTileWidget(
              title[index],
              desc[index],
              visibility,
              (newValue) => updateVisibility(newValue!),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.sp),
            child: Text(
              'Photo Privacy Settings',
              style: AppTextStyles.poppinsMedium(),
            ),
          ),
          ...List.generate(
            titlePhoto.length,
            (index) => visibilityTileWidget(
              titlePhoto[index],
              descPhoto[index],
              photoPrivacy,
              (newValue) => updatePhotoPrivacy(newValue!),
            ),
          ),
        ],
      ),
    );
  }

  ListTile visibilityTileWidget(String title, String desc, String value,
      void Function(String?)? onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(desc),
      leading: Radio(
        activeColor: AppColors.primary,
        value: title,
        groupValue: value,
        onChanged: onChanged,
      ),
    );
  }

  String visibility = 'Public';
  String photoPrivacy = 'Public';
  List<String> selectedProfileSections = [];
  List<String> blockedUsers = [];

  void updateVisibility(String newVisibility) {
    setState(() {
      visibility = newVisibility;
    });
  }

  void updatePhotoPrivacy(String newPrivacy) {
    setState(() {
      photoPrivacy = newPrivacy;
    });
  }

  void updateSelectedSections(String section) {
    setState(() {
      if (selectedProfileSections.contains(section)) {
        selectedProfileSections.remove(section);
      } else {
        selectedProfileSections.add(section);
      }
    });
  }

  void blockUser(String userId) {
    setState(() {
      blockedUsers.add(userId);
    });
  }

  bool isUserBlocked(String userId) {
    return blockedUsers.contains(userId);
  }
}

List<String> profileSections = [
  'Income',
  'Family Info',
  'Hobbies',
  'Education'
];
// List<String> profilePrivacyDesc = [
//   'Visible to all.',
//   'Visible only to matches.',
//   'Visible only to matched members or those you\'ve interacted with.',
//   'Temporarily hide your profile from all members.',
// ];