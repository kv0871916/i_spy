import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../database/controller/db_controller.dart';
import '../../controller/auth_controller.dart';
import '../common/common_auth.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                'login'.toUpperCase(),
                style: TextStyle(
                  fontSize: 32,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: CupertinoColors.systemBlue.withOpacity(0.1),
                      offset: const Offset(2, 2),
                    ),
                    const Shadow(
                      blurRadius: 5,
                      color: CupertinoColors.white,
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      blurRadius: 5,
                      color: CupertinoColors.systemBlue.withOpacity(0.1),
                      offset: const Offset(-2, -2),
                    ),
                  ],
                  color: CupertinoColors.systemBlue,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customdecoratedBox(
                    child: CupertinoTextField(
                      controller: _emailController,
                      placeholder: 'Email',
                      maxLength: 40,
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.mail,
                            color: CupertinoColors.link),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customdecoratedBox(
                    child: CupertinoTextField(
                      maxLength: 20,
                      controller: _passwordController,
                      placeholder: 'Password',
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.padlock,
                            color: CupertinoColors.link),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
              ],
            ),
            customdecoratedBox(
              borderRadius: 10,
              color: CupertinoColors.systemFill,
              child: CupertinoButton.filled(
                child: const Text('Login'),
                onPressed: () async {
                  AuthController authcontroller =
                      Provider.of<AuthController>(context, listen: false);

                  if (_emailController.text == null &&
                      _emailController.text.trim() == '' &&
                      _passwordController.text == null &&
                      _passwordController.text.trim() == '') {
                    await customAlretDialog(
                        context: context,
                        title: 'Error',
                        message: 'Please enter email and password');
                  } else {
                    try {
                      DBController db =
                          Provider.of<DBController>(context, listen: false);

                      await db.updateUserData(_emailController.text.trim(),
                          _passwordController.text.trim());
                    } catch (e) {
                      await customAlretDialog(
                          context: context,
                          title: 'Error',
                          message: 'Please try again in sometime');
                    }

                    await authcontroller.login(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    if (authcontroller.isError != null &&
                        authcontroller.isError != '') {
                      await customAlretDialog(
                          context: context,
                          title: 'Error',
                          message: authcontroller.isError!);
                    } else {
                      Navigator.pushNamed(context, '/home');
                    }
                  }
                },
              ),
            ),
            CupertinoButton(
              child: const Text('Not a member? Sign up'),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
