import 'package:app_social/components/custom_button_login.dart';
import 'package:app_social/components/show_request.dart';
import 'package:app_social/models/bill_order.dart';
import 'package:app_social/models/id_custom.dart';
import 'package:app_social/page/user/my_order.dart';

import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_fonts.dart';
import 'package:app_social/theme/app_styles.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCard extends StatefulWidget {
  const MyCard({
    super.key,
    required this.userProvider,
  });

  final UserProvider userProvider;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late double height;
  late double width;

  int price = 0;
  late TextEditingController controller;
  double discount = 0;
  late double total;
  List<double> discounts = [0.3, 0.2, 0.1, 0.15];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    total = widget.userProvider.total();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kFirstMainColor,
        centerTitle: true,
        title: const Text(
          'My Cart',
          style: AppStyle.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.userProvider.order.length,
                itemBuilder: (_, index) {
                  price = int.parse(widget.userProvider.order[index].price) *
                      int.parse(widget.userProvider.order[index].amount);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: SizedBox(
                      height: 120,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black.withOpacity(.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    maxRadius: 40,
                                    minRadius: 20,
                                    backgroundImage: NetworkImage(
                                      widget.userProvider.order[index].image,
                                      scale: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.userProvider.order[index].name,
                                        style: AppStyle.h3,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '$price VND',
                                        style: AppStyle.h4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                widget.userProvider.order[index].amount,
                                style: AppStyle.h3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 1,
              color: Colors.black.withOpacity(.25),
            ),
            const Text(
              'Order Summary',
              style: AppStyle.h2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub total',
                  style: AppStyle.h4.copyWith(
                    fontFamily: AppFonts.poppins,
                  ),
                ),
                Text(
                  '${widget.userProvider.subTotal().toInt()} VND',
                  style: AppStyle.h4,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VAT',
                  style: AppStyle.h4.copyWith(
                    fontFamily: AppFonts.poppins,
                  ),
                ),
                Text(
                  '${widget.userProvider.vAT().toInt()} VND',
                  style: AppStyle.h4,
                )
              ],
            ),
            Flexible(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Coupon Here',
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: InkWell(
                      onTap: () => discount == 0
                          ? showDiscountCode(context)
                          : const SizedBox(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: discount == 0
                              ? AppColor.kFirstMainColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          'Apply',
                          style: AppStyle.h5.copyWith(
                            fontFamily: AppFonts.poppins,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: AppStyle.h3.copyWith(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${total.toInt()} VND',
                  style: AppStyle.h2,
                ),
              ],
            ),
            CustomButtonLogin(
              func: () async {
                BillOrder item = BillOrder(
                  bid: IdCustom.idv1(),
                  oid: widget.userProvider.order.map((e) => e.oid).toList(),
                  uid: widget.userProvider.auth.user.uid,
                  price: total.toInt().toString(),
                  code: '${(discount * 100).toInt()} %',
                  sentTime: DateTime.now(),
                );
                String result = await widget.userProvider.bill(item);

                // ignore: use_build_context_synchronously
                show(context, result);

                widget.userProvider.auth.navigationService.navigateToPage(
                  MyOrder(
                    orders: widget.userProvider.order,
                    discount: discount,
                    vAT: widget.userProvider.vAT(),
                    subTotal: widget.userProvider.subTotal(),
                    total: total,
                    userProvider: widget.userProvider,
                  ),
                );
              },
              height: 50,
              width: width,
              widget: const Text(
                'Place Order',
                style: AppStyle.h2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDiscountCode(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: height / 3,
            width: width,
            child: ListView.builder(
              itemCount: discounts.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () => {
                    setState(() {
                      discount = discounts[index];
                      controller.text = '${(discount * 100).toInt()} %';
                      total = widget.userProvider.total() -
                          widget.userProvider.total() * discount;
                    }),
                    Navigator.pop(context),
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: height / 9.4,
                      child: Center(
                        child: Text('${(discounts[index] * 100).toInt()} %'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
