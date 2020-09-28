import 'package:flutter/material.dart';
import '../../../../ui/fonts/my_flutter_app_icons.dart';
import '../../../../ui/widgets/submit_button.dart';
import '../../../../ui/widgets/text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../auth_viewModel.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController emailEditingController;
  TextEditingController passwordEditingController;
  TextEditingController usernamEditingController;

  @override
  void initState() {
    super.initState();
    emailEditingController = TextEditingController();
    passwordEditingController = TextEditingController();
    usernamEditingController = TextEditingController();
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
                  SizedBox(height: deviceWidth * .3),
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
                    controller: usernamEditingController,
                    labelText: "Username",
                    onChanged: (String value) {
                      model.setUsername = value;
                    },
                  ),
                  SizedBox(height: deviceWidth * .08 - 10),
                  CustomTextFormField(
                    controller: emailEditingController,
                    labelText: "Email",
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
                    labelText: "REGISTER",
                    onPressed: () {
                      var result = model.registerUser();
                      result.then((value) {
                        if (value != null) {
                          _key.currentState.showSnackBar(SnackBar(
                              content: Text(model.exceptions.toString())));
                        }
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Already have an Account? "),
                        GestureDetector(
                          onTap: model.goBack,
                          child: Text("LOGIN HERE!",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
