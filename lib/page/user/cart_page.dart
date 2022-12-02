import 'package:app_social/components/custom_appbar.dart';
import 'package:app_social/components/custom_card_product_cart.dart';
import 'package:app_social/components/show_request.dart';
import 'package:app_social/models/oder_product.dart';
import 'package:app_social/page/user/my_cart.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: CustomAppBar(
                  displayname: auth.user.displayname, url: auth.user.photoURL),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 10,
              backgroundColor: AppColor.kFirstMainColor,
              onPressed: () {
                if (userProvider.order.isNotEmpty) {
                  auth.navigationService.navigateToPage(MyCard(
                    userProvider: userProvider,
                  ));
                } else {
                  show(context, 'Xin lỗi bạn chưa đặt món nào!');
                }
              },
              child: const Icon(
                Icons.attach_money_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
            body: StreamBuilder(
              stream: userProvider.getOderProduct(),
              builder: (context, AsyncSnapshot<List<OrderProduct?>> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? const Center(
                          child: Text(
                            'Bạn chưa đặt món nào cả!',
                            style: AppStyle.h3,
                          ),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            OrderProduct item = snapshot.data![index]!;
                            return CustomCardProductCart(
                              item: item,
                              height: height,
                              width: width,
                              userProvder: userProvider,
                            );
                          },
                        );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
