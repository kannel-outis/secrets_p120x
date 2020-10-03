import '../../../app/locator/locator.dart';
import '../../../app/route/routes.gr.dart';
import '../../../errors/error.dart';
import '../../../services/service_handlers/auth_services/auth_services.dart';
import '../../../services/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  final AuthServices _authServices = AuthServices();
  var _navigationService = locator<NavigationService>();
  String _username;
  String _email;
  String _password;
  bool _isLoading = false;
  Exceptions _exceptions;

  set setUsername(String value) {
    _username = value;
  }

  set setEmail(String value) {
    _email = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  //TODO: test here

  Future<Exceptions> signinUser() async {
    _exceptions = null;

    _isLoading = true;
    notifyListeners();
    try {
      await _authServices.signinUser(_email, _password).then((model) {
        if (model != null) {
          _navigationService.navigateTo(Routes.homeScreen);
          _isLoading = false;
          notifyListeners();
        }
      });
    } on Exceptions catch (e) {
      _isLoading = false;
      _exceptions = e;
      notifyListeners();
    }

    return _exceptions;
  }

  Future<Exceptions> registerUser() async {
    _exceptions = null;
    _isLoading = true;
    notifyListeners();
    try {
      await _authServices
          .registerUser(_username, _email, _password)
          .then((model) {
        if (model != null) {
          _navigationService.navigateTo(Routes.homeScreen);
          _isLoading = false;
          notifyListeners();
        } else {
          _isLoading = false;
          notifyListeners();
        }
      });
      //
    } on Exceptions catch (e) {
      _isLoading = false;
      _exceptions = e;
      notifyListeners();
    }

    return _exceptions;
  }

  void navigateTo(String routeName) {
    _navigationService.navigateTo(routeName);
  }

  void goBack() {
    _navigationService.goBack();
  }

  String get username => _username;
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  Exceptions get exceptions => _exceptions;
}
