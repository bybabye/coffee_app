import 'package:app_social/provider/authencation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  late AuthencationProvider auth;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: userName,
            ),
          ),
          Expanded(
            child: TextField(
              controller: password,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await auth.signInWithEmailAndPassword(
                  userName.text, password.text);
            },
            child: const Text('check'),
          )
        ],
      ),
    );
  }
}
