import 'package:action_slider/action_slider.dart';
import 'package:app_social/components/custom_button_circle.dart';
import 'package:app_social/components/custom_button_login.dart';
import 'package:app_social/models/id_custom.dart';
import 'package:app_social/models/oder_product.dart';
import 'package:app_social/models/product.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_colors.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductDesCriptionPage extends StatefulWidget {
  const ProductDesCriptionPage({
    super.key,
    required this.item,
    required this.userProvider,
  });
  final Product item;
  final UserProvider userProvider;

  @override
  State<ProductDesCriptionPage> createState() => _ProductDesCriptionPageState();
}

class _ProductDesCriptionPageState extends State<ProductDesCriptionPage> {
  late double height;
  late double width;
  int soluong = 1;
  bool isCheck = true;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height * 0.4,
                  width: width,
                  child: CachedNetworkImage(
                    imageUrl: widget.item.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SizedBox(
                        height: 60,
                        width: 60,
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        )),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: CustomButtonCircle(
                    radiusOutSide: 20,
                    radiusInSide: 18,
                    color: Colors.transparent,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColor.kFirstMainColor,
                    ),
                    func: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.6,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: AppStyle.h2,
                    ),
                    Text(
                      widget.item.des,
                      style: AppStyle.h4.copyWith(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Loại : ${widget.item.t.name}  /  Số lượng : ',
                          style: AppStyle.h3,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => setState(() {
                                      soluong++;
                                    }),
                                icon: const Icon(Icons.add)),
                            Text(
                              '$soluong',
                              style: AppStyle.h4,
                            ),
                            IconButton(
                              onPressed: () {
                                if (soluong > 1) {
                                  setState(() {
                                    soluong--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Price',
                          style: AppStyle.h3,
                        ),
                        Text(
                          '${widget.item.price} VND',
                          style: AppStyle.h3,
                        ),
                      ],
                    ),
                    isCheck
                        ? CustomButtonLogin(
                            func: () {
                              setState(() => isCheck = !isCheck);
                            },
                            height: height / 12.5,
                            width: width,
                            widget: const Text(
                              'Add to cart',
                              style: AppStyle.h3,
                            ),
                          )
                        : Center(
                            child: ActionSlider.standard(
                              backgroundColor: Colors.white,
                              toggleColor: AppColor.kFirstMainColor,
                              successIcon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                              width: width,
                              actionThresholdType: ThresholdType.release,
                              child: Text(
                                'Slide to confirm',
                                style: AppStyle.h3.copyWith(
                                    letterSpacing: 1.2, color: Colors.black),
                              ),
                              action: (controller) async {
                                controller.loading(); //starts loading animation
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                controller.success(); //starts success animation
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                setState(() => isCheck = !isCheck);

                                controller.reset(); //resets the slider
                                OrderProduct oder = OrderProduct(
                                  oid: IdCustom.idv1(),
                                  name: widget.item.name,
                                  pid: widget.item.uid,
                                  price: widget.item.price,
                                  uid: widget.userProvider.auth.user.uid,
                                  amount: soluong.toString(),
                                  sentTime: DateTime.now(),
                                  image: widget.item.image,
                                );
                                await widget.userProvider.oder(oder);
                                soluong = 1;

                                // ignore: use_build_context_synchronously
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
