import 'package:flutter/material.dart';

void show(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: message == 'success' ? Colors.green : Colors.red,
  ));
}
