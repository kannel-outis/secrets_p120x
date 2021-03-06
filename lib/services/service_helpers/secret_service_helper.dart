import 'dart:convert';
import 'dart:io';

import 'package:secrets_p20x/errors/error.dart';
import 'package:secrets_p20x/models/secrets_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseSecretServiceHelper {
  Future shareSecretHelper(
      {String secret, String token, String baseUrl, Map<String, dynamic> body});
  Future<List<SecretsModel>> getAllSecretsHelper(String url);
}

class SecretServiceHelper extends BaseSecretServiceHelper {
  @override
  Future shareSecretHelper(
      {String secret,
      String token,
      String baseUrl,
      Map<String, dynamic> body}) async {
    Map<String, dynamic> postBody = body;
    var _postBodyEncoded = json.encode(postBody);
    try {
      if (secret != null) {
        http.Response response =
            await http.post(baseUrl, body: _postBodyEncoded, headers: {
          "Content-type": "application/json",
          "auth-token": token,
        });
        if (response.statusCode == 200) {
          print(response.body);
          return;
        } else {
          print(json.decode(response.body)['msg']);
          throw Exceptions(message: json.decode(response.body)['msg']);
        }
      } else {
        throw Exceptions(message: "fields can't be empty");
      }
    } on SocketException {
      throw Exceptions(message: "No internet. check connection and try again");
    }
  }

  @override
  Future<List<SecretsModel>> getAllSecretsHelper(String url) async {
    List<SecretsModel> _secretList = [];
    try {
      http.Response response =
          await http.get(url, headers: {"Content-type": "application/json"});
      if (response.statusCode == 200) {
        var map = json.decode(response.body);
        List list = map;
        list.forEach((element) {
          final SecretsModel _secret = SecretsModel.fromMap(element);
          _secretList.add(_secret);
        });
        return _secretList.reversed.toList();
      }
      return null;
    } on SocketException {
      throw Exceptions(message: "no internet, check conetction and try again");
    }
  }
}
