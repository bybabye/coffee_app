import 'package:app_social/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButtonCircle extends StatelessWidget {
  const CustomButtonCircle({
    super.key,
    required this.child,
    required this.func,
  });
  final Widget child;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 7.h,
        width: 15.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              AppColor.kSecondCircleColorButton.withOpacity(.3),
              AppColor.kFirstCircleColorButton.withOpacity(.05),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            height: 5.h,
            width: 12.w,
            child: child,
          ),
        ),
      ),
    );
  }
}
