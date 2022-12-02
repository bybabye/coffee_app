import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomValidatorField extends StatelessWidget {
  const CustomValidatorField({
    super.key,
    required this.controller,
    required this.isPassword,
    required this.icon,
    required this.hintText,
  });
  final TextEditingController controller;
  final bool isPassword;
  final Icon icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        icon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: icon,
        ),
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
      ),
    );
  }
}
