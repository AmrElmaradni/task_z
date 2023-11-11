import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

class SharedMethods {
  static Future<UserModel?> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      return UserModel.fromJson(json.decode(prefs.getString('user')!));
    } else {
      return null;
    }
  }

  static save(UserModel value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(value.toJson()));
  }

  static remove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }
}
