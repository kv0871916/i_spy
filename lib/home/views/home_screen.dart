import 'package:flutter/material.dart';
import 'package:i_spy/auth/controller/auth_controller.dart';
import 'package:i_spy/database/controller/db_controller.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController =
        Provider.of<AuthController>(context, listen: false);
    DBController db = Provider.of<DBController>(context, listen: false);
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(
              child: Text('Home'),
            ),
            Center(
              child: Text(authController.userCredential!.user!.email ??
                  'Error loading email'),
            ),
            FutureBuilder(
              future: db.getAllUsers(),
              builder: (
                BuildContext context,
                AsyncSnapshot snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data.toString(),
                        style:
                            const TextStyle(color: Colors.cyan, fontSize: 36));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Logout'),
                onPressed: () async {
                  await authController.logout();
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
