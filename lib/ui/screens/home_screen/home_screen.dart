import 'package:flutter/material.dart';
import '../../.././models/user_model.dart';
import '../../../ui/fonts/my_flutter_app_icons.dart';
import '../../../ui/widgets/submit_button.dart';
import '../../../ui/widgets/text_form_field.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  DateTime _lastQuitTime;
  UserModel _userModel;

  @override
  void initState() {
    super.initState();
    getData();
    controller = TextEditingController();
  }

  void getData() async {
    print("Start Here");
    _userModel = await HomeScreenViewModel().getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.shortestSide;
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          key: _key,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
                "Signed in as ${_userModel != null ? _userModel.name : ""}"),
            actions: [
              GestureDetector(
                onTap: () {
                  model.deleteDataAndLogOut(false);
                },
                child: Container(
                  height: double.infinity,
                  width: 100,
                  child: Center(
                    child: Icon(Icons.exit_to_app),
                  ),
                ),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (_lastQuitTime == null ||
                  DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
                var snackbar =
                    SnackBar(content: Text('Press again Back Button exit'));

                _key.currentState.showSnackBar(snackbar);
                _lastQuitTime = DateTime.now();
                return false;
              } else {
                model.deleteDataAndLogOut(true);
                return true;
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Center(
                        child: Icon(MyFlutterApp.key,
                            color: Theme.of(context).accentColor, size: 80),
                      ),
                      SizedBox(height: deviceWidth * .01),
                      Center(
                        child: Text("Secrets!", style: TextStyle(fontSize: 50)),
                      ),
                      SizedBox(height: deviceWidth * .01),
                      Center(
                        child: Text(
                          "Don't keep your secrets, share them anonymously!",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .color
                                  .withOpacity(0.5)),
                        ),
                      ),
                      SizedBox(height: deviceWidth * .1),
                      CustomTextFormField(
                        controller: controller,
                        labelText: "Share Anonymously",
                        onChanged: (String value) {
                          model.setSecret = value;
                        },
                      ),
                      SizedBox(height: deviceWidth * .08 - 10),
                      SubmitButton(
                        isLoading: model.isLoading,
                        labelText: "SHARE",
                        onPressed: () {
                          var result =
                              model.shareSecret(token: _userModel.token);
                          result.then((value) {
                            if (value != null) {
                              _key.currentState.showSnackBar(SnackBar(
                                  content: Text(model.exceptions.toString())));
                            } else {
                              controller.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            // color: Colors.pink,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: model.navigateTo,
                  child: Container(
                    height: double.infinity,
                    width: 100,
                    child: Center(
                      child: Text("All Secrets"),
                    ),
                  ),
                ),
                // SizedBox(width: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
