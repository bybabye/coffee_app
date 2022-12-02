class OrderProduct {
  final String oid;
  final String pid;
  final String name;
  final String price;
  final String uid;
  final String amount;
  final DateTime sentTime;
  final String image;
  // ghi chu
  OrderProduct({
    required this.oid,
    required this.name,
    required this.pid,
    required this.price,
    required this.uid,
    required this.amount,
    required this.sentTime,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'oid': oid,
      'pid': pid,
      'uid': uid,
      'name': name,
      'price': price,
      'amount': amount,
      'sentTime': sentTime,
      'image': image,
    };
  }

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      oid: json['oid'],
      pid: json['pid'],
      uid: json['uid'],
      name: json['name'],
      price: json['price'],
      amount: json['amount'],
      sentTime: json['sentTime'].toDate(),
      image: json['image'],
    );
  }
}
