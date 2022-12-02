import 'package:app_social/models/product.dart';
import 'package:app_social/theme/app_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCardProduct extends StatelessWidget {
  const CustomCardProduct({super.key, required this.item});
  final Product item;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    height: 60,
                    imageUrl: item.image,
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
            Text(
              item.name,
              style: AppStyle.h4.copyWith(letterSpacing: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price',
                  style: AppStyle.h5,
                ),
                Text(
                  '${item.price} VND',
                  style: AppStyle.h5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
