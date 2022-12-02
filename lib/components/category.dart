import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  const CategoryComponent(
      {super.key, required this.func, required this.name, required this.path});
  final Function() func;
  final String path;
  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              path,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: AppStyle.h4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
