import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_spy/auth/views/mains/main_auth_screen.dart';
import 'package:i_spy/database/controller/db_controller.dart';
import 'package:i_spy/routes/routes.dart';
import 'package:provider/provider.dart';

import 'auth/controller/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (_) => AuthController(),
        ),
        ChangeNotifierProvider<DBController>(
          create: (_) => DBController(),
        ),
      ],
      child: MaterialApp(
        initialRoute: NamedPath.loginPath,
        title: 'ISPY',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainAuthScreen(),
        routes: namedPathRoutes(),
      ),
    );
  }
}
