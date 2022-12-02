import 'package:app_social/theme/app_colors.dart';

import 'package:flutter/material.dart';

class CustomButtonLogin extends StatelessWidget {
  const CustomButtonLogin({
    super.key,
    required this.func,
    required this.height,
    required this.width,
    required this.widget,
  });
  final Function() func;
  final double height;
  final double width;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColor.kFirstMainColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),
        ),
        onPressed: func,
        child: widget,
      ),
    );
  }
}
