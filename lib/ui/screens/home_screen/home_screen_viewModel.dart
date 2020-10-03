import '../../../app/locator/locator.dart';
import '../../../app/route/routes.gr.dart';
import '../../../errors/error.dart';
import '../../../services/service_handlers/local_prefs/local_pref.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../services/service_handlers/secret_services/secrets_services.dart';
import '../../../models/user_model.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends FutureViewModel<UserModel> {
  String _secret;
  var _localPrefs = locator<LocalPrefs>();
  var _navigatorService = locator<NavigationService>();
  bool _isLoading = false;
  UserModel _userModel;
  Exceptions _exceptions;

  set setSecret(String value) {
    _secret = value;
  }

  Future<Exceptions> shareSecret({String token}) async {
    _exceptions = null;
    _isLoading = true;
    notifyListeners();

    try {
      await SecretService()
          .shareSecret(_secret, token ?? _userModel.token)
          .then((value) {
        _isLoading = false;
        notifyListeners();
        return null;
      });
    } on Exceptions catch (e) {
      _isLoading = false;
      notifyListeners();
      _exceptions = e;
    }
    return _exceptions;
  }

  void navigateTo() {
    _navigatorService.navigateTo(Routes.allSharedSecretsScreen);
  }

  void deleteDataAndLogOut(bool willPop) async {
    await _localPrefs.deleteUserData().then((isDeleted) {
      if (isDeleted == true) {
        if (willPop != true) {
          return _navigatorService.goBack();
        }
      }
    });
  }

  //get user data from local pref
  Future<UserModel> getUserData() async {
    print("Start");
    var model = await _localPrefs.getUserData();
    if (model != null) {
      _userModel = model;
      return _userModel;
    }
    return null;
  }

  UserModel get userModel => _userModel;
  String get secret => _secret;
  bool get isLoading => _isLoading;
  Exceptions get exceptions => _exceptions;

  @override
  Future<UserModel> futureToRun() => getUserData();
}
