import 'package:flutter_test/flutter_test.dart';
import 'package:secrets_p20x/app/locator/locator.dart';
import 'package:secrets_p20x/errors/error.dart';
import 'package:secrets_p20x/ui/screens/authentication/auth_viewModel.dart';
import 'package:secrets_p20x/ui/screens/home_screen/home_screen_viewModel.dart';

void main() {
  setupLocator();
  group("first Test", () {
    group('testing authentication', () {
      test('return null with login success', () async {
        var model = AuthViewModel();
        model.setEmail = "test2@test.com";
        model.setPassword = "Emirdilony1234*";
        expect(await model.signinUser(), null);
      });

      test('returns "Exceptions(message: "User not found")" when login fails',
          () async {
        var model = AuthViewModel();
        model.setEmail = "testNotFound@test.com"; //wrong email
        model.setPassword = "Emirdilony1234*";
        expect(await model.signinUser(), Exceptions(message: "User not found"));
      });

      test(
          'returns "Exceptions(message: "User Already Exists")" when reqistration fails',
          () async {
        var model = AuthViewModel();
        model.setEmail = "test11test12@test.com";
        model.setUsername = "Eimr dilony";
        model.setPassword = "Emirdilony1234*";
        expect(await model.registerUser(),
            Exceptions(message: "User Already Exists"));
      });

      test('returns null when reqistration passes', () async {
        var model = AuthViewModel();
        model.setEmail = "newTestUser2fake233@test.com";
        model.setUsername = "Eimr dilony";
        model.setPassword = "Emirdilony1234*";
        expect(await model.registerUser(), null);
      });
    });

    group('Sharing secrets', () {
      test('should return null if true', () async {
        var model = HomeScreenViewModel();
        model.setSecret = "testing secrets";

        expect(
            await model.shareSecret(
                token:
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVmNzIzN2Q1M2MxNDVhMDAwNGIyYWJlZCIsImlhdCI6MTYwMTYyNDk1NywiZXhwIjoxNjAxNjI4NTU3fQ.Gq26-RwtQE1rSWVk51lzHAiYUT4XGnh3SAqug27LIbc"),
            null);
      });

      test('returns  "Exceptions("Invakid Token")"', () async {
        var model = HomeScreenViewModel();
        model.setSecret = "testing secret fail";
        expect(await model.shareSecret(token: "invalidTokenHere"),
            Exceptions(message: "Invalid Token"));
      });
    });
  });
}
