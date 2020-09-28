import 'package:get_it/get_it.dart';
import 'package:secrets_p20x/models/error_model.dart';
import 'package:secrets_p20x/services/service_helpers/auth_service_helper.dart';
import '../../services/service_helpers/secret_service_helper.dart';
import '../../models/secrets_model.dart';
import '../../services/service_handlers/auth_services/auth_services.dart';
import '../../services/service_handlers/local_prefs/local_pref.dart';
import '../../services/navigation/navigation_service.dart';
import '../../models/user_model.dart';
import '../../services/service_handlers/secret_services/secrets_services.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthServices());
  locator.registerLazySingleton(() => LocalPrefs());
  locator.registerLazySingleton(() => UserModel());
  locator.registerLazySingleton(() => SecretsModel());
  locator.registerLazySingleton(() => SecretService());
  locator.registerLazySingleton(() => SecretServiceHelper());
  locator.registerLazySingleton(() => AuthServiceHelper());
  locator.registerLazySingleton(() => ErrorModel());
}
