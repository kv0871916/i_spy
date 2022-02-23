import 'package:flutter/material.dart';
import '../register/register_screen.dart';
import '../login/login_screen.dart';

class MainAuthScreen extends StatelessWidget {
  const MainAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: const <Widget>[
          Expanded(
            child: LoginView(),
          ),
          Expanded(
            child: RegisterView(),
          ),
        ],
      ),
    );
  }
}
