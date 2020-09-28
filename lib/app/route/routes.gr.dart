// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';

import '../../ui/screens/authentication/login/login_screen.dart';
import '../../ui/screens/authentication/register/register.dart';
import '../../ui/screens/home_screen/home_screen.dart';
import '../../ui/screens/shared/all_shared/all_shared_screen.dart';
import '../../ui/screens/shared/my_shared/my_shared_screen.dart';

class Routes {
  static const String loginScreen = '/';
  static const String homeScreen = '/home_screen';
  static const String registerScreen = '/register_screen';
  static const String allSharedSecretsScreen = '/all_shared_screen';
  static const String mySharedScreen = '/my_shared_secrets';
  static const all = <String>{
    loginScreen,
    homeScreen,
    registerScreen,
    allSharedSecretsScreen,
    mySharedScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.registerScreen, page: RegisterScreen),
    RouteDef(Routes.allSharedSecretsScreen, page: AllSharedSecretsScreen),
    RouteDef(Routes.mySharedScreen, page: MySharedScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    RegisterScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => RegisterScreen(),
        settings: data,
      );
    },
    AllSharedSecretsScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => AllSharedSecretsScreen(),
        settings: data,
      );
    },
    MySharedScreen: (data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (context) => MySharedScreen(),
        settings: data,
      );
    },
  };
}
