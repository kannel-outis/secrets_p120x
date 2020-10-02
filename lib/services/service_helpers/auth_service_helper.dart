import 'dart:convert';
import 'dart:io';

import '../.././models/error_model.dart';

import '../.././app/locator/locator.dart';
import '../.././errors/error.dart';
import '../../models/user_model.dart';
import '../.././services/service_handlers/local_prefs/local_pref.dart';
import 'package:http/http.dart' as http;

abstract class BaseAuthServiceHelper {
  Future<UserModel> signinUser(
      {String email, Map<String, dynamic> body, String url});
  Future<UserModel> register(
      {String email,
      String username,
      String password,
      String url,
      Map<String, dynamic> body});
}

class AuthServiceHelper extends BaseAuthServiceHelper {
  var _model = locator<UserModel>();
  var _localPrefs = locator<LocalPrefs>();
  var _errorModel = locator<ErrorModel>();
  @override
  Future<UserModel> signinUser(
      {String email, Map<String, dynamic> body, String url}) async {
    try {
      var encodedBody = json.encode(body);
      http.Response response = await http.post(url,
          body: encodedBody, headers: {"Content-type": "application/json"});
      if (response.statusCode == 200) {
        var fromMap = json.decode(response.body);
        _model = UserModel.fromMap(fromMap);
        _localPrefs.saveUserData(model: _model);
        return _model;
        // checks for specific response msg
      } else if (json.decode(response.body) ==
          "email or password is incorrect") {
        throw Exceptions(message: "email or password is incorrect");
      } else if (json.decode(response.body)['msg'] == "User not found") {
        throw Exceptions(message: "User not found");
      } else {
        var fromErrorMap = json.decode(response.body);
        _errorModel = ErrorModel.fromMap(fromErrorMap);
        throw Exceptions(message: _errorModel.msg);
      }
    } on SocketException {
      throw Exceptions(
          message: "No internet. Please check Connection and try again");
    }
  }

  @override
  Future<UserModel> register(
      {String email,
      String username,
      String password,
      String url,
      Map<String, dynamic> body}) async {
    try {
      var encodedBody = json.encode(body);
      http.Response response = await http.post(url,
          body: encodedBody, headers: {"Content-type": "application/json"});
      // run if success
      if (response.statusCode == 200) {
        var fromMap = json.decode(response.body);
        _model = UserModel.fromMap(fromMap);
        _localPrefs.saveUserData(model: _model);
        return _model;
        //checks for specific response msg
      } else if (json.decode(response.body)['msg'] == "User Already Exists") {
        throw Exceptions(message: "User Already Exists");
      } else {
        var fromErrorMap = json.decode(response.body);
        _errorModel = ErrorModel.fromMap(fromErrorMap);
        throw Exceptions(message: _errorModel.msg);
      }
    } on SocketException {
      throw Exceptions(
          message: "No internet. Please check Connection and try again");
    }
  }
}
