import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/controller/provider/noti_provider.dart';
import 'package:united_proposals_app/resources/app_images.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/height_widths.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/view/chat_work/view/chat_view.dart';
import 'package:united_proposals_app/view/notification/model/noti_model.dart';
import 'package:united_proposals_app/view/request_screen.dart';

import '../../../controller/provider/root_provider.dart';
import '../api/notification_apis.dart';

class NotiWidget extends StatefulWidget {
  final NotiModel model;
  var id;
  NotiModel text;
   NotiWidget({super.key, required this.model, required this. text, this.id});

  @override
  State<NotiWidget> createState() => _NotiWidgetState();
}

class _NotiWidgetState extends State<NotiWidget> {
  // bool isRead = false;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(UniqueKey()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: .22,
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            onPressed: (s) async{
              // context.read<NotiProvider>().notifications.remove(widget.text);
              // context.read<NotiProvider>().update();
              await NotificationApi.removeNotifcation(widget.id);              
            },
            child: Container(
                width: 14.w,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                    color: AppColors.lightRed.withOpacity(.8),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.delete,
                  color: AppColors.red,
                  size: 20.sp,
                )),
          ),
        ],
      ),
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () => notiOnTapFN(widget.text),
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: (widget.text?.isSeen ?? false)
                ? AppColors.white
                : AppColors.primary.withOpacity(.35),
            boxShadow: (widget.text?.isSeen ?? false)
                ? [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.26),
                      offset: const Offset(0, 0),
                      blurRadius: 12.0,
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                  // boxShadow: (widget.text.isSeen ?? false)
                  //     ? [
                  //         BoxShadow(
                  //           color: AppColors.black.withOpacity(0.05),
                  //           offset: const Offset(3, 3),
                  //           blurRadius: 6,
                  //         ),
                  //         BoxShadow(
                  //           color: AppColors.black.withOpacity(0.05),
                  //           offset: const Offset(-3, -3),
                  //           blurRadius: 6,
                  //         ),
                  //       ]
                  //     : [],
                ),
                child: Image.asset(
                  AppImages.notiIcon,
                  scale: 3.8,
                ),
              ),
              w4,
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('dd-MM-yyyy  hh:mm a')
                          .format(widget.text.createdAt!.toDate()),
                      style: AppTextStyles.poppinsRegular(
                        fontSize: 10.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    h0P7,
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.poppinsRegular(
                          fontSize: 10.sp,
                          color: AppColors.red,
                        ),
                        children: [
                          // boldSpan(widget.text.from),
                          boldSpan(widget.text.title),
                          // boldSpan(widget.text.event),
                          // simpleSpan(widget.text.event),
                        ],
                      ),
                    ),
                          Text(widget.text.event!),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan simpleSpan(title) {
    return TextSpan(
      text: title,
      style: AppTextStyles.poppinsRegular(
        fontSize: 10.sp,
        color: AppColors.grey,
      ),
    );
  }

  TextSpan boldSpan(title) {
    return TextSpan(
      text: title,
      style: AppTextStyles.poppinsRegular(
        fontWeight: FontWeight.w500,
        fontSize: 10.sp,
        color: AppColors.black,
      ),
    );
  }

  void notiOnTapFN(NotiModel notiModel) {
    if (widget.text.title!.contains("Friend Request")) {      
      context.read<RootProvider>().selectedScreenValue = 1;
      context.read<RootProvider>().pageController.jumpToPage(1);
      Navigator.pop(context);
    }else{
      context.read<RootProvider>().selectedScreenValue = 3;
      context.read<RootProvider>().pageController.jumpToPage(3);
      Navigator.pop(context);
      
    }
    // setState(() {});
  }
}
