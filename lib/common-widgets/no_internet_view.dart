import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:united_proposals_app/common-widgets/custom_button.dart';
import 'package:united_proposals_app/utils/app_colors.dart';
import 'package:united_proposals_app/utils/text_style.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  NoInternetScreenState createState() => NoInternetScreenState();
}

class NoInternetScreenState extends State<NoInternetScreen> {
  bool isChecking = false;
  final Connectivity _connectivity = Connectivity();

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      setState(() {
        isChecking = true;
      });
      result = await _connectivity.checkConnectivity();
      setState(() {
        isChecking = false;
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        {
          ZBotToast.showToastSuccess(
            message: 'connection_restored',
          );
          Navigator.pop(context);
        }
        break;
      case ConnectivityResult.mobile:
        {
          ZBotToast.showToastSuccess(
            message: 'connection_restored',
          );
          Navigator.pop(context);
        }
        break;
      case ConnectivityResult.none:
        break;
      default:
        break;
    }
    debugPrint(result.toString());
  }

  void startConnectionStream() {}

  Future<bool> checkBeforeGoingBack() async {
    ConnectivityResult result;
    result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  @override
  void initState() {
    initConnectivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: checkBeforeGoingBack,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text("Jrny Tgthr")),
        body: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * .1,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Center(
                        child: Icon(
                      Icons
                          .signal_wifi_statusbar_connected_no_internet_4_rounded,
                      size: 25.sp,
                    )),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * .05),
                      width: Get.width,
                      child: Text(
                        "no_internet_connection",
                        style: AppTextStyles.poppinsRegular(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              isChecking
                  ? const SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : CustomButton(
                      textColor: AppColors.white,
                      tap: () {
                        initConnectivity();
                      },
                      text: 'retry',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
