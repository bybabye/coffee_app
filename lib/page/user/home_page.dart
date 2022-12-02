import 'package:app_social/page/user/cart_page.dart';
import 'package:app_social/page/user/favorites_page.dart';
import 'package:app_social/page/user/home.dart';

import 'package:app_social/page/user/user_page.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  int _selectedIndex = 0;
  List<Widget> home = [
    const Home(),
    const FavoritesPage(),
    const CartPage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);

    return Scaffold(
      body: home[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Container(
            color: AppColor.kFirstMainColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.white70,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.card_travel_outlined,
                    text: 'Cart',
                  ),
                  GButton(
                    icon: Icons.account_circle_rounded,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
