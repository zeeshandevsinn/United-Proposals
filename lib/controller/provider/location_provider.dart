import 'dart:developer';

// import 'package:bhai_chara/utils/showSnack.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:united_proposals_app/controller/locationManager.dart';

import '../../utils/zbotToast.dart';

// import '../../services/Screen_Manager.dart';

class LocationProvider extends ChangeNotifier {
  bool isLoading = false;

  String currentAddress = "";
  // ignore: unused_field
  Position? _currentPosition;
  Location(context, _currentPosition, _currentAddress) async {
    // debugger();
    try {
      isLoading = true;
      notifyListeners();

      var data = await LocationManager.geoLocation(
          context, _currentPosition, _currentAddress);
      if (data != null) {
        currentAddress = data;
        ZBotToast.showToastSuccess(message: "Location Update Successfully");
        // showSnack(context: context, text: );
        isLoading = false;
        notifyListeners();
        return currentAddress;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      ZBotToast.showToastError(message: e.toString());
    }
  }
}
