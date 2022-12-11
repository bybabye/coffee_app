import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.content,
    required this.isCheck,
    required this.photoURL,
    required this.type,
  });
  final String content;
  final bool isCheck;
  final String photoURL;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment:
            isCheck ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCheck)
            Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 12),
              child: CircleAvatar(
                backgroundImage: NetworkImage(photoURL),
              ),
            ),
          if (type == 'text')
            SizedBox(
              width: content.length > 10 ? 160 : 80,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF4A5767),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    content,
                    style: AppStyle.h4.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          if (type == 'image')
            SizedBox(
              height: 37.h,
              width: 51.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: content.isEmpty
                      ? SizedBox(
                          height: 5.h,
                          width: 12.w,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.network(
                            content,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
