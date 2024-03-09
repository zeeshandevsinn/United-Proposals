import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:united_proposals_app/utils/zbotToast.dart';

class SharedPrefsHelper {
  static const String _favoriteKey = 'favoriteKey';
  // Future<void> initSharedPreferences() async {
  //  SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {});
  // }
  static const List<String> getfavorites = [];
  static getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fav = prefs.getStringList(_favoriteKey)!;
    getfavorites.add(fav as String);

    return getfavorites;
  }

  static addFavorite(String userId) async {
    // debugger();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> favorites = await getFavorites();
      favorites.add(userId);
      prefs.setStringList(_favoriteKey, favorites);
    } catch (e) {
      ZBotToast.showToastError(message: e.toString());
    }
  }
}
