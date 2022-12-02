import 'package:app_social/components/custom_button_login.dart';
import 'package:app_social/components/custom_validator_field.dart';
import 'package:app_social/components/show_request.dart';
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
      body: SingleChildScrollView(
        child: !isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: height * 0.45,
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.logo,
                          fit: BoxFit.cover,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            'Sign In',
                            style: AppStyle.h1,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.55,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomValidatorField(
                            controller: controllerUser,
                            isPassword: false,
                            icon: const Icon(
                              Icons.email_outlined,
                              color: Colors.black87,
                              size: 30,
                            ),
                            hintText: 'Email',
                          ),
                          CustomValidatorField(
                            controller: controllerPassword,
                            isPassword: true,
                            icon: const Icon(
                              Icons.private_connectivity_outlined,
                              color: Colors.black87,
                              size: 30,
                            ),
                            hintText: 'password',
                          ),
                          CustomButtonLogin(
                            func: () async {
                              isLoading = false;
                              if (controllerUser.text.isNotEmpty &&
                                  controllerPassword.text.isNotEmpty) {
                                if (!controllerUser.text.contains('@')) {
                                  show(context,
                                      'Invalid Email , Example Email : example@gmail.com');
                                } else {
                                  String result =
                                      await auth.signInWithEmailAndPassword(
                                          controllerUser.text,
                                          controllerPassword.text);

                                  if (result != 'success') {
                                    // ignore: use_build_context_synchronously
                                    show(context, result);
                                  }
                                }
                              } else {
                                show(context, 'Email and Password Invalid');
                              }

                              isLoading = true;
                            },
                            height: height / 15.31,
                            width: width,
                            widget: const Text(
                              'Sign In',
                              style: AppStyle.h2,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Forgot Password?",
                              style: AppStyle.h3.copyWith(
                                  letterSpacing: 1, color: Colors.blue),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 3,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  'or sign in with',
                                  style: AppStyle.h4.copyWith(letterSpacing: 1),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await auth.signInWithGoogle();
                                },
                                child: Image.asset(
                                  AppAssets.google,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Image.asset(
                                AppAssets.twitter,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                AppAssets.facebook,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          Center(
                            child: Text(
                              "Don't have a account?",
                              style: AppStyle.h3.copyWith(
                                  letterSpacing: 1, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
