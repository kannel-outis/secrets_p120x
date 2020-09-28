import 'dart:convert';

import '../../../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalPref {
  Future<UserModel> saveUserData({UserModel model});
  Future<UserModel> getUserData();
  Future<bool> deleteUserData();
}

class LocalPrefs extends LocalPref {
  final String key = "value";
  @override
  Future<bool> deleteUserData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return await _prefs.clear();
  }

  @override
  Future<UserModel> getUserData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final userData = _prefs.getString(key);
    if (userData != null) {
      final value = UserModel.fromMap(json.decode(userData));
      return Future.value(value);
    } else {
      final value = UserModel(email: "", id: "", name: "", token: "");
      return Future.value(value);
    }
  }

  @override
  Future<UserModel> saveUserData({UserModel model}) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final value = json.encode(model.toMap());
    _prefs.setString(key, value);
    return Future.value(model);
  }
}
