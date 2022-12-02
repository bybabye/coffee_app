import 'package:app_social/page/user/search_page.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.displayname, required this.url});
  final String url;
  final String displayname;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SearchPage()));
          },
          icon: const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
      elevation: 10,
      backgroundColor: AppColor.kFirstMainColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: AppStyle.h5.copyWith(color: Colors.white),
              ),
              Text(
                displayname,
                style: AppStyle.h4.copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
