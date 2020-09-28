import '../../../app/locator/locator.dart';
import '../../../services/service_helpers/secret_service_helper.dart';
import '../../../models/secrets_model.dart';

abstract class BaseSecretService {
  Future shareSecret(String secret, String token);
  Future<List<SecretsModel>> getAllSecrets();
}

class SecretService extends BaseSecretService {
  final url = "https://whispering-headland-51917.herokuapp.com/api/secrets";
  var helper = locator<SecretServiceHelper>();

  @override
  Future<List<SecretsModel>> getAllSecrets() {
    return helper.getAllSecretsHelper(url);
  }

  @override
  Future shareSecret(String secret, String token) {
    return helper.shareSecretHelper(
      secret: secret,
      token: token,
      baseUrl: url,
      body: {
        "content": secret,
      },
    );
  }
}
