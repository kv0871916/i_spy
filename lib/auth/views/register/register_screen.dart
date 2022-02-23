import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_controller.dart';
import '../common/common_auth.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                'Register'.toUpperCase(),
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
                      placeholder: 'Email',
                      controller: _emailController,
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.mail,
                            color: CupertinoColors.link),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customdecoratedBox(
                    child: CupertinoTextField(
                      placeholder: 'Password',
                      controller: _passwordController,
                      prefix: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.padlock,
                            color: CupertinoColors.link),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customdecoratedBox(
                    child: CupertinoTextField(
                      placeholder: 'Confirm password',
                      controller: _confirmPasswordController,
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
                child: const Text('Register'),
                onPressed: () async {
                  AuthController authcontroller =
                      Provider.of<AuthController>(context, listen: false);

                  if (_emailController.text.trim() == '' &&
                      _passwordController.text.trim() == '' &&
                      _confirmPasswordController.text.trim() == '') {
                    await customAlretDialog(
                        context: context,
                        title: 'Error',
                        message: 'Please enter email and password');
                  } else if (_confirmPasswordController.text.trim() !=
                      _passwordController.text.trim()) {
                    await customAlretDialog(
                        context: context,
                        title: 'Error',
                        message:
                            'Password and confirm password does not match');
                  } else {
                    await authcontroller.register(
                      context: context,
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
              child: const Text('Already have an account?'),
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }
}
