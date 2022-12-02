import 'package:app_social/models/bill_order.dart';
import 'package:app_social/models/oder_product.dart';
import 'package:app_social/models/product.dart';
import 'package:app_social/provider/authencation_provider.dart';
import 'package:app_social/query/database_query.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  AuthencationProvider auth;
  late DatabaseQuery dq;
  List<OrderProduct> order = [];
  UserProvider(this.auth) {
    dq = DatabaseQuery();
  }

  Stream<List<Product>> getProduct() {
    // lấy dữ liệu từ collection coffee
    final data = dq.getQuery('coffee');
    return data.map((snapshot) {
      return snapshot.docs.map((e) => Product.fromJson(e.data())).toList();
    });
  }

  Stream<List<OrderProduct>> getOderProduct() {
    // lấy dữ liệu từ collection order
    final data = dq.query('order', 'uid', auth.user.uid);
    return data.map((snapshot) {
      return order =
          snapshot.docs.map((e) => OrderProduct.fromJson(e.data())).toList();
    });
  }

  Future<String> oder(OrderProduct item) async {
    // dùng để đặt món
    String result = '';
    try {
      await dq.putQuery(item.toJson(), 'order', item.oid);
      result = 'success';
    } catch (e) {
      result = 'error!!';
    }
    return result;
  }

  Stream<List<Product>> searchProduct(String name) {
    final data = dq.queryForName('coffee', 'name', name);

    return data.map((snapshot) {
      return snapshot.docs.map((e) => Product.fromJson(e.data())).toList();
    });
  }

  Future<String> delete(String oid, String collection) async {
    // xoá món
    String result = 'success';
    try {
      await dq.deteleQuery(collection, oid);
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> bill(BillOrder item) async {
    //  đẩy bill lên cho admin và đẩy về làm lịch sử giao dịch của khách hàng
    String result = '';
    try {
      await dq.putQuery(item.toJson(), 'bill', item.bid);
      await dq.putQuery(item.toJson(), 'transaction', item.bid);
      item.oid.map((e) async {
        await delete(e, 'order');
      }).toList();
      result = 'success';
    } catch (e) {
      result = 'error!!';
    }
    return result;
  }

  double subTotal() {
    // hàm dùng để cộng tất cả tiền của món đã đặt
    double price = 0;
    for (var item in order) {
      price += (double.parse(item.amount) * double.parse(item.price));
    }
    return price;
  }

  double vAT() {
    // lấy 10% của tất cả món đã đặt
    double vat = (subTotal() * 0.1);
    return vat;
  }

  double total() {
    // công tất cả tiền kể cả thuế VAT
    return (subTotal() + vAT());
  }
}
