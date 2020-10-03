// import 'package:auto_route/auto_route_annotations.dart';
import '../../ui/screens/authentication/login/login_screen.dart';
import '../../ui/screens/authentication/register/register.dart';
import '../../ui/screens/home_screen/home_screen.dart';
import '../../ui/screens/shared/all_shared/all_shared_screen.dart';
import '../../ui/screens/shared/my_shared/my_shared_screen.dart';
import 'package:auto_route/auto_route_annotations.dart';

@AdaptiveAutoRouter(routes: [
  AdaptiveRoute(page: LoginScreen, initial: true),
  AdaptiveRoute(page: HomeScreen, path: "/home_screen"),
  AdaptiveRoute(page: RegisterScreen, path: "/register_screen"),
  AdaptiveRoute(page: AllSharedSecretsScreen, path: "/all_shared_screen"),
  AdaptiveRoute(page: MySharedScreen, path: "/my_shared_secrets"),
])
class $Router {}
