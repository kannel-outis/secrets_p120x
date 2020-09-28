import 'dart:convert';
import 'dart:io';

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
  @override
  Future<UserModel> signinUser(
      {String email, Map<String, dynamic> body, String url}) async {
    final bool validateEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    try {
      // validate email
      if (validateEmail != false) {
        var encodedBody = json.encode(body);
        http.Response response = await http.post(url,
            body: encodedBody, headers: {"Content-type": "application/json"});
        if (response.statusCode == 200) {
          var fromMap = json.decode(response.body);
          _model = UserModel.fromMap(fromMap);
          _localPrefs.saveUserData(model: _model);
          return _model;
          // checks for specific response msg
        } else if (json.decode(response.body) == "Invalid credentials") {
          throw HttpException("Wrong email and password");
        } else if (json.decode(response.body)['msg'] == "User not found") {
          throw HttpException("User not found");
        }
      } else {
        throw FormatException("Invalide Email");
      }
    } on HttpException catch (e) {
      throw Exceptions(e.toString().substring(15));
    } on SocketException {
      throw Exceptions("No internet. Please check Connection and try again");
    } on FormatException catch (e) {
      throw Exceptions(e.toString().substring(16));
    }
    return null;
  }

  @override
  Future<UserModel> register(
      {String email,
      String username,
      String password,
      String url,
      Map<String, dynamic> body}) async {
    final bool validateEmail = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    try {
      //vaalidates email
      if (validateEmail != false) {
        // validates email and password length
        if (username.length >= 6 && password.length >= 6) {
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
          } else if (json.decode(response.body)['msg'] ==
              "User Already Exists") {
            throw HttpException("User Already Exists");
          }
        } else {
          throw FormatException("credentials must have at least 6 characters");
        }
      } else {
        throw FormatException("Invalid Email ");
      }
    } on HttpException catch (e) {
      throw Exceptions(e.toString().substring(15));
    } on SocketException {
      throw Exceptions("No internet. Please check Connection and try again");
    } on FormatException catch (e) {
      throw Exceptions(e.toString().substring(16));
    }
    return null;
  }
}
