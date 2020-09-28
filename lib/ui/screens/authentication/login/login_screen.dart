import 'package:flutter/material.dart';
import '../../../../app/route/routes.gr.dart';
import '../../../../ui/fonts/my_flutter_app_icons.dart';
import '../../../../ui/widgets/submit_button.dart';
import '../../../../ui/widgets/text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../auth_viewModel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController emailEditingController;
  TextEditingController passwordEditingController;

  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.shortestSide;
    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          child: ViewModelBuilder<AuthViewModel>.reactive(
            viewModelBuilder: () => AuthViewModel(),
            builder: (context, model, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: deviceWidth * .4),
                  Center(
                    child: Icon(MyFlutterApp.key,
                        color: Theme.of(context).accentColor, size: 80),
                  ),
                  SizedBox(height: deviceWidth * .01),
                  Center(
                    child: Text("Secrets!", style: TextStyle(fontSize: 50)),
                  ),
                  SizedBox(height: deviceWidth * .1),
                  CustomTextFormField(
                    controller: emailEditingController,
                    labelText: "Email Address",
                    textInputType: TextInputType.emailAddress,
                    onChanged: (String value) {
                      model.setEmail = value;
                    },
                  ),
                  SizedBox(height: deviceWidth * .08 - 10),
                  CustomTextFormField(
                    controller: passwordEditingController,
                    labelText: "Password",
                    obscureText: true,
                    onChanged: (String value) {
                      model.setPassword = value;
                    },
                  ),
                  SizedBox(height: deviceWidth * .08 - 10),
                  SubmitButton(
                    isLoading: model.isLoading,
                    labelText: "LOGIN",
                    onPressed: () {
                      var result = model.signinUser();
                      result.then((value) {
                        if (value != null) {
                          _key.currentState.showSnackBar(SnackBar(
                              content: Text(model.exceptions.toString())));
                        }
                      });
                      // }
                      //  else {
                      //   _key.currentState.showSnackBar(
                      //       SnackBar(content: Text("Invalid Email")));
                      // }
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("not yet registered? "),
                        GestureDetector(
                          onTap: () {
                            model.navigateTo(Routes.registerScreen);
                          },
                          child: Text("REGISTER HERE!",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
