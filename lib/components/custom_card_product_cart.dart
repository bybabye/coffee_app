import 'package:app_social/components/custom_button_login.dart';
import 'package:app_social/components/show_request.dart';
import 'package:app_social/models/oder_product.dart';
import 'package:app_social/provider/user_provider.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCardProductCart extends StatefulWidget {
  const CustomCardProductCart({
    super.key,
    required this.item,
    required this.height,
    required this.width,
    required this.userProvder,
  });
  final OrderProduct item;
  final double width;
  final double height;
  final UserProvider userProvder;
  @override
  State<CustomCardProductCart> createState() => _CustomCardProductCartState();
}

class _CustomCardProductCartState extends State<CustomCardProductCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 160,
        width: widget.width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      height: 60,
                      imageUrl: widget.item.image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 12, right: 12, bottom: 12),
                  child: SizedBox(
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: AppStyle.h3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.item.price} VND',
                              style: AppStyle.h4,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                ' | ',
                                style: AppStyle.h4,
                              ),
                            ),
                            Text(
                              ' SL : ${widget.item.amount}',
                              style: AppStyle.h4,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${int.parse(widget.item.price) * int.parse(widget.item.amount)} VND',
                              style: AppStyle.h4,
                            ),
                            const Spacer(),
                            CustomButtonLogin(
                              func: () async {
                                String result = await widget.userProvder
                                    .delete(widget.item.oid, 'order');
                                // ignore: use_build_context_synchronously
                                show(context, result);
                              },
                              height: 25,
                              width: 70,
                              widget: Text(
                                'Delete',
                                style:
                                    AppStyle.h4.copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
