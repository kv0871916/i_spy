import 'package:flutter/material.dart';

import '../auth/views/login/login_screen.dart';
import '../auth/views/register/register_screen.dart';
import '../home/views/home_screen.dart';

class NamedPath {
  static String homePath = "/home";
  static String loginPath = "/login";
  static String signupPath = "/signup";
  static String splashPath = "/splash";
}

namedPathRoutes() {
  return {
    NamedPath.signupPath: (context) => const Material(
          child: RegisterView(),
        ),
    NamedPath.loginPath: (context) => const Material(
          child: LoginView(),
        ),
    NamedPath.homePath: (context) => const Material(
          child: HomeView(),
        ),
  };
}
