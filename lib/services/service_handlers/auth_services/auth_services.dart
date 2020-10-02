import 'package:secrets_p20x/errors/error.dart';

import '../../../services/service_helpers/auth_service_helper.dart';
import '../../../app/locator/locator.dart';
import '../../../models/user_model.dart';

class AuthServices {
  var _authHelper = locator<AuthServiceHelper>();

  final _baseUrl = "https://whispering-headland-51917.herokuapp.com/api";
  Future<UserModel> signinUser(String email, String password) async {
    if (email != null && password != null) {
      return _authHelper.signinUser(
          email: email,
          body: {
            "email": email,
            "password": password,
          },
          url: _baseUrl + "/user/login");
    } else {
      throw Exceptions(message: "Fields can be empty");
    }
  }

  Future<UserModel> registerUser(
      String username, String email, String password) async {
    if (email != null && password != null && username != null) {
      return _authHelper.register(
          email: email,
          password: password,
          username: username,
          url: _baseUrl + "/user/register",
          body: {
            "name": username,
            "email": email,
            "password": password,
          });
    } else {
      throw Exceptions(message: "Fields can be empty");
    }
  }
}
