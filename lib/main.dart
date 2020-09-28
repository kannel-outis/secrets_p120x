import 'package:flutter/material.dart';
import 'app/locator/locator.dart';
import 'app/route/routes.gr.dart';
import 'services/navigation/navigation_service.dart';
import 'ui/const/theme.dart';
import 'ui/screens/authentication/login/login_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: Routes.loginScreen,
      onGenerateRoute: Router().onGenerateRoute,
      home: LoginScreen(),
    );
  }
}
