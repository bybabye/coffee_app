import 'package:flutter/material.dart';

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
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SizedBox(
            height: 40,
            width: 40,
            child: child,
          ),
        ),
      ),
    );
  }
}
