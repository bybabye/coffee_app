import 'package:app_social/page/login/login_page_account.dart';

import 'package:app_social/page/user/home_page.dart';

import 'package:app_social/provider/authencation_provider.dart';

import 'package:app_social/routes/navigation_service.dart';
import 'package:app_social/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NavigationService().setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return AuthencationProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: ThemeData(
          backgroundColor: Colors.white,
        ),
        initialRoute: Routes.loginAccountPage,
        routes: {
          Routes.loginAccountPage: (context) => const LoginPageAccount(),
          Routes.homePage: (context) => const HomePage(),
        },
      ),
    );
  }
}
