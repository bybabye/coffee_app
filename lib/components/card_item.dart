import 'package:app_social/theme/app_styles.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.text,
    required this.senderId,
    required this.userId,
    required this.photoURL,
  });
  final String text;
  final String senderId;
  final String userId;
  final String photoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: senderId == userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (senderId != userId)
            Padding(
              padding: const EdgeInsets.only(bottom: 24, right: 12),
              child: CircleAvatar(
                backgroundImage: NetworkImage(photoURL),
              ),
            ),
          SizedBox(
            width: text.length > 10 ? 160 : 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF4A5767),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: AppStyle.h4.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
