import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int miliseconds;

  Timer? timer;

  Debouncer({this.miliseconds = 2000});

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(microseconds: miliseconds), action);
  }
}
