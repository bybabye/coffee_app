import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButtonCircleColor extends StatelessWidget {
  const CustomButtonCircleColor({
    super.key,
    required this.child,
    required this.func,
    required this.color,
  });
  final Widget child;
  final Function() func;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        height: 7.h,
        width: 15.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            height: 4.h,
            width: 11.w,
            child: child,
          ),
        ),
      ),
    );
  }
}
