import 'package:flutter/material.dart';

class CustomButtonCircle extends StatelessWidget {
  const CustomButtonCircle(
      {super.key,
      required this.icon,
      required this.func,
      required this.color,
      required this.radiusInSide,
      required this.radiusOutSide});

  final Icon icon;
  final Function() func;
  final Color color;
  final double radiusOutSide;
  final double radiusInSide;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: CircleAvatar(
        backgroundColor: Colors.white70,
        radius: radiusOutSide,
        child: CircleAvatar(
          backgroundColor: color,
          radius: radiusInSide,
          child: icon,
        ),
      ),
    );
  }
}
