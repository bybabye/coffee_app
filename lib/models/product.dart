enum T {
  hot,
  cold,
  other,
}

class Product {
  final String uid;
  final String name;
  final String des;
  final String price;
  final String image;
  final T t;
  Product({
    required this.uid,
    required this.name,
    required this.des,
    required this.price,
    required this.t,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    // ignore: no_leading_underscores_for_local_identifiers
    String _t;
    switch (t) {
      case T.hot:
        _t = 'hot';
        break;
      case T.cold:
        _t = 'cold';
        break;
      case T.other:
        _t = 'other';
        break;
    }
    return {
      'uid': uid,
      'name': name,
      'des': des,
      'price': price,
      't': _t,
      'image': image
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    // ignore: no_leading_underscores_for_local_identifiers
    T _t = T.hot;
    switch (json['t']) {
      case 'hot':
        _t = T.hot;
        break;
      case 'cold':
        _t = T.cold;
        break;
      case 'other':
        _t = T.other;
    }
    return Product(
      uid: json['uid'] ?? "",
      name: json['name'] ?? "",
      des: json['des'] ?? "",
      price: json['price'] ?? "",
      t: _t,
      image: json['image'] ?? "",
    );
  }
}
