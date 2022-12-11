import 'package:app_social/page/home/homepage.dart';
import 'package:app_social/page/login/login_page_account.dart';
import 'package:app_social/page/login/test_login.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/chat_provider.dart';
import 'package:app_social/routes/navigation_service.dart';
import 'package:app_social/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ChatProvider();
          },
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          navigatorKey: locator<NavigationService>().navigatorKey,
          initialRoute: Routes.loginAccountPage,
          routes: {
            '/': (context) => const TestLogin(),
            Routes.loginAccountPage: (context) => const LoginPageAccount(),
            Routes.homePage: (context) => const HomePage(),
          },
        );
      }),
    );
  }
}
