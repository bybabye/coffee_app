import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Text(
          'Xin Lỗi hiện tại chúng tôi chưa phát triển chức năng này.',
          style: AppStyle.h3,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
