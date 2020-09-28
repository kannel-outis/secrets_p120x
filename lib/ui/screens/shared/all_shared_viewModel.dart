import '../../../app/enums/emuns.dart';
import '../../../app/locator/locator.dart';
import '../../../app/route/routes.gr.dart';
import '../../../errors/error.dart';
import '../../../models/user_model.dart';
import '../../../models/secrets_model.dart';
import '../../../services/service_handlers/local_prefs/local_pref.dart';
import '../../../services/navigation/navigation_service.dart';
import '../../../services/service_handlers/secret_services/secrets_services.dart';
import 'package:stacked/stacked.dart';

class SharedViewModel extends FutureViewModel<List<SecretsModel>> {
  var _secretService = locator<SecretService>();
  var _localPrefs = locator<LocalPrefs>();
  var _navigatorService = locator<NavigationService>();
  UserModel _userModel;
  List<SecretsModel> _mySharedSecretsList;
  List<SecretsModel> _allSharedSecrets = [];
  DataLoadInfoState _dataLoadInfo = DataLoadInfoState.Loading;
  Exceptions _exceptions;

  ///handling requests
  ///
  void _setState(DataLoadInfoState loadInfoState) {
    _dataLoadInfo = loadInfoState;
    notifyListeners();
  }

  void _setListOfSecrets(List<SecretsModel> list) {
    _allSharedSecrets = list;
    notifyListeners();
  }

  void _setException(Exceptions e) {
    _exceptions = e;
    if (e.toString() == "Invalid Token" || e.toString() == "Access Denied!") {
      _navigatorService.goBack();
    }
    notifyListeners();
  }

  /////

//all Shared secrets
  Future<List<SecretsModel>> sharedSecrets() async {
    _exceptions = null;
    _setState(_dataLoadInfo);
    getUserData();
    try {
      var newlist = await _secretService.getAllSecrets();
      _setListOfSecrets(newlist);
      mySharedSecrets();
    } on Exceptions catch (e) {
      _setException(e);
    }
    _setState(DataLoadInfoState.Loaded);
    return _allSharedSecrets;
  }

  //Load and Extract my Secrets from all loaded secrets
  Future<List<SecretsModel>> mySharedSecrets() async {
    _mySharedSecretsList = _allSharedSecrets.where((model) {
      return model.ownerEmail == _userModel.email;
    }).toList();
    return _mySharedSecretsList;
  }

  //get user data from local Storage
  Future<UserModel> getUserData() async {
    var model = await _localPrefs.getUserData();
    if (model != null) {
      _userModel = model;
      notifyListeners();
      return _userModel;
    }
    return null;
  }

  //contols navigation
  void navigateTo() {
    _navigatorService.navigateTo(Routes.mySharedScreen);
  }

  @override
  Future<List<SecretsModel>> futureToRun() => sharedSecrets();
  Exceptions get exceptions => _exceptions;
  DataLoadInfoState get dataLoadInfo => _dataLoadInfo;
  List<SecretsModel> get secrets => _allSharedSecrets;
  List<SecretsModel> get mySharedSecretsList => _mySharedSecretsList;
}
