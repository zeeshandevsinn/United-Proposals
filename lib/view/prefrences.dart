// Prefrences dart:
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static saveitem(item) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString("fav", jsonEncode(item));
    // print("data saved");
    // print(item);
  }

  static getitem() async {
    var pref = await SharedPreferences.getInstance();
    var data = pref.getString("fav");
    if (data != null) {
      return jsonDecode(data);
    }
    return [];
  }

  static clearPreferences(index) async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    getitem();
  }
}
