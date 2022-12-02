import 'package:app_social/models/oder_product.dart';
import 'package:app_social/page/user/home_page.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_assets.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({
    super.key,
    required this.orders,
    required this.discount,
    required this.vAT,
    required this.subTotal,
    required this.total,
    required this.userProvider,
  });
  final List<OrderProduct> orders;
  final double total;
  final double subTotal;
  final double vAT;
  final double discount;
  final UserProvider userProvider;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(.9),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Your Invioce',
          style: AppStyle.h3.copyWith(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            userProvider.auth.navigationService
                .goToPageAndRemoveAllRoutes(const HomePage());
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: height / 1.5,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withOpacity(.1),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        minRadius: 40,
                        maxRadius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          AppAssets.logo,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Coffee House',
                        style: AppStyle.h2,
                      ),
                    ),
                    Container(
                      height: 2,
                      color: Colors.black.withOpacity(.2),
                    ),
                    ListView(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      children: orders
                          .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.name,
                                    style: AppStyle.h3,
                                  ),
                                  Text(
                                    '${e.price} VND',
                                    style: AppStyle.h4,
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    Container(
                      height: 2,
                      color: Colors.black.withOpacity(.2),
                    ),
                    returnItem(
                        'Sub total', '${subTotal.toInt().toString()} VND'),
                    returnItem('VAT', '${vAT.toInt().toString()} VND'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: AppStyle.h1,
                          ),
                          Text(
                            '${total.toInt().toString()} VND',
                            style: AppStyle.h2,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      'Thank You !',
                      style: AppStyle.h1,
                    ),
                    const Text(
                      'Wifi : huybui | pass : 123456789',
                      style: AppStyle.h3,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget returnItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppStyle.h3,
          ),
          Text(
            value,
            style: AppStyle.h4,
          ),
        ],
      ),
    );
  }
}
