import 'dart:ui';

import 'package:app_social/components/custom_button.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/theme/app_assets.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPageAccount extends StatefulWidget {
  const LoginPageAccount({super.key});

  @override
  State<LoginPageAccount> createState() => _LoginPageAccountState();
}

class _LoginPageAccountState extends State<LoginPageAccount> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  late TextEditingController controllerUser;
  late TextEditingController controllerPassword;
  bool isLoading = true;

  @override
  void initState() {
    controllerUser = TextEditingController();
    controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.logo),
              scale: 1,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: !isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Welcome to My Chat App TMF',
                        style: AppStyle.h1.copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 200,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10.0,
                                  sigmaY: 10.0,
                                ),
                                child: Container(
                                  height: 200,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      width: .9,
                                      color: Colors.white.withOpacity(.3),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Sign in with',
                                        style: AppStyle.h3
                                            .copyWith(color: Colors.white),
                                      ),
                                      CustomButton(
                                        image: AppAssets.google,
                                        text: 'Login In With Google',
                                        func: () async {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          await auth.signInWithGoogle();
                                          setState(() {
                                            isLoading = true;
                                          });
                                        },
                                      ),
                                      CustomButton(
                                        image: AppAssets.facebook,
                                        text: 'Login In With facebook',
                                        func: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
