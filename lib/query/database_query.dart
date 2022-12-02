import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseQuery {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> query(
      String collection, String field, String condition) {
    return db
        .collection(collection)
        .where(field, isEqualTo: condition)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> queryForName(
      String collection, String field, String condition) {
    return db
        .collection(collection)
        .where(field, isGreaterThanOrEqualTo: condition)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getQuery(
    String collection,
  ) {
    return db.collection(collection).snapshots();
  }

  Future<void> putQuery(
      Map<String, dynamic> json, String collection, String uid) {
    return db.collection(collection).doc(uid).set(json);
  }

  Future<void> deteleQuery(String collection, String id) {
    return db.collection(collection).doc(id).delete();
  }

  Future<void> updateQuery(
      String collection, String id, Map<String, dynamic> map) {
    return db.collection(collection).doc(id).update(map);
  }
}
