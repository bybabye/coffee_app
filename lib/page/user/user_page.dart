import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_fonts.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late double height;
  late double width;
  late AuthencationProvider auth;
  late UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(auth),
        )
      ],
      child: Builder(
        builder: (context) {
          userProvider = context.watch<UserProvider>();
          return Scaffold(
              body: SingleChildScrollView(
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    height: height / 3,
                    width: width,
                    child: DecoratedBox(
                      decoration:
                          const BoxDecoration(color: AppColor.kFirstMainColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'My Account',
                            style: AppStyle.h2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          CircleAvatar(
                            minRadius: 40,
                            maxRadius: 60,
                            backgroundImage: NetworkImage(
                              auth.user.photoURL,
                            ),
                          ),
                          Text(
                            auth.user.displayname,
                            style: AppStyle.h2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  info('My infomation', Icons.account_box, () {}),
                  info('Address', Icons.location_on_outlined, () {}),
                  info('Payment', Icons.payment, () {}),
                  info('My Wistlist', Icons.favorite, () {}),
                  info('Cafe Following', Icons.coffee_outlined, () {}),
                  info('Refund', Icons.rotate_left_rounded, () {}),
                  info('Setting', Icons.settings, () {}),
                  info('Log out', Icons.logout, () async {
                    await auth.logout();
                  }),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget info(String name, IconData icon, Function() func) {
    return InkWell(
      onTap: func,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(.2),
                  child: Icon(
                    icon,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: AppStyle.h4.copyWith(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
