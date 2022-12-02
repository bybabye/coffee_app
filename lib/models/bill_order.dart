class BillOrder {
  final String bid;
  final List<String> oid;
  final String uid;
  final String price;
  final String code;
  final DateTime sentTime;

  BillOrder({
    required this.bid,
    required this.oid,
    required this.uid,
    required this.price,
    required this.code,
    required this.sentTime,
  });

  Map<String, dynamic> toJson() => {
        'bid': bid,
        'oid': oid,
        'uid': uid,
        'price': price,
        'code': code,
        'sentTime': sentTime,
      };
  factory BillOrder.fromJson(Map<String, dynamic> json) {
    return BillOrder(
      bid: json['bid'],
      oid: json['oid'],
      uid: json['uid'],
      price: json['price'],
      code: json['code'],
      sentTime: json['sentTime'].toDate(),
    );
  }
}
