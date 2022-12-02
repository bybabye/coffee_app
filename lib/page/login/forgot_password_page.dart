import 'package:app_social/components/custom_appbar.dart';
import 'package:app_social/components/custom_button_login.dart';
import 'package:app_social/components/custom_validator_field.dart';
import 'package:app_social/components/show_request.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgosPasswordPage extends StatefulWidget {
  const ForgosPasswordPage({super.key});

  @override
  State<ForgosPasswordPage> createState() => _ForgosPasswordPageState();
}

class _ForgosPasswordPageState extends State<ForgosPasswordPage> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  late TextEditingController controllerUser;
  @override
  void initState() {
    controllerUser = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => auth.navigationService.goBack(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Forgot Password',
                  style: AppStyle.h1,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Enter your email or phone',
                  style: AppStyle.h3.copyWith(color: Colors.yellow.shade900),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                const SizedBox(
                  height: 30,
                ),
                CustomButtonLogin(
                  func: () async {
                    if (controllerUser.text.isEmpty ||
                        !controllerUser.text.contains('@')) {
                      show(context, 'Invalid  email');
                    } else {
                      String result =
                          await auth.forgotPassword(controllerUser.text);
                      // ignore: use_build_context_synchronously
                      show(context, result);
                    }
                  },
                  height: 60,
                  width: width,
                  widget: const Text(
                    'Continue',
                    style: AppStyle.h3,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
