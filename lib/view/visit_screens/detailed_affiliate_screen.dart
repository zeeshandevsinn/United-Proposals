import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/global_widgets.dart';
import '../../common-widgets/custom_button.dart';
import '../../common-widgets/custom_data.dart';
import '../../models/affiliate_program_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/height_widths.dart';
import '../../utils/text_style.dart';

class DetailedAffiliateScreen extends StatefulWidget {
  static String route = "/DetailedAffiliateScreen";

  @override
  State<DetailedAffiliateScreen> createState() =>
      _DetailedAffiliateScreenState();
}

class _DetailedAffiliateScreenState extends State<DetailedAffiliateScreen> {
  AffilateProgramModel? model;

  dynamic args;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        if (args["model"] != null) {
          model = args["model"];
        }

        debugPrint(" imagfe ${model?.profileImage}");
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GlobalWidgets.appBar('${model?.fullName}\'s Detail'),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
          child: CustomButton(
            text: "Call now",
            tap: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model?.profileImage ?? "",
                    ),
                  ),
                ),
              ),
              h2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Information',
                      style: AppTextStyles.poppinsBold(fontSize: 13.sp),
                    ),
                    h1,
                    Text(
                      'About',
                      style: AppTextStyles.poppinsMedium(),
                    ),
                    Text(
                      model!.about.toString(),
                      style: AppTextStyles.poppinsRegular(
                        color: AppColors.grey,
                        letterSpacing: 0.45,
                      ),
                    ),
                    h1,
                    CustomData(title: 'Name:', subTitle: "${model?.fullName}"),
                    h1,
                    CustomData(
                        title: 'Location:',
                        subTitle: model?.location.toString() ?? ""),
                    h1,
                    CustomData(
                        title: 'Number:', subTitle: "${model?.phoneNumber}"),
                    h1,
                    CustomData(title: 'Email:', subTitle: "${model?.email}"),
                    h1,
                    h2,
                    CustomData(
                        title: 'Location:',
                        subTitle: model?.location.toString() ?? ""),
                    h4,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
