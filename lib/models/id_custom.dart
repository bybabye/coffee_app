import 'package:uuid/uuid.dart';

class IdCustom {
  static var uuid = const Uuid();

  static String idv1() {
    return uuid.v1();
  }
}
