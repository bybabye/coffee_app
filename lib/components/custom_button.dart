import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.image, required this.text, required this.func});
  final String image;
  final String text;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        height: 50,
        width: 240,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(.3), width: 2),
          borderRadius: BorderRadius.circular(24),
          // gradient: LinearGradient(
          //   colors: [
          //     AppColor.kFirstColorButton,
          //     AppColor.kFirstColorButton.withOpacity(.5)
          //   ],
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              text,
              style: AppStyle.h4.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
