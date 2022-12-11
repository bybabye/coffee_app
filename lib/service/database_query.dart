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

  Future<DocumentSnapshot<Map<String, dynamic>>> queryGetUser(
      String collection, String uid) {
    return db.collection(collection).doc(uid).get();
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

  Future<QuerySnapshot<Map<String, dynamic>>> getChatQuery(
      String collection, String uid) {
    return db.collection(collection).where('members', arrayContains: uid).get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageQuery(
      String collection, String collection2, String cid) {
    return db
        .collection(collection)
        .doc(cid)
        .collection(collection2)
        .orderBy('sentTime', descending: true)
        .snapshots();
  }

  Future<void> sendMessQuery(String collection, String cid, String collection2,
      String mid, Map<String, dynamic> json) {
    return db
        .collection(collection)
        .doc(cid)
        .collection(collection2)
        .doc(mid)
        .set(json);
  }

  Future<void> updateMessQuery(String collection, String cid,
      String collection2, String mid, Map<String, dynamic> json) {
    return db
        .collection(collection)
        .doc(cid)
        .collection(collection2)
        .doc(mid)
        .update(json);
  }

  Future<void> deteleQuery(String collection, String id) {
    return db.collection(collection).doc(id).delete();
  }

  Future<void> updateQuery(
      String collection, String id, Map<String, dynamic> map) {
    return db.collection(collection).doc(id).update(map);
  }
}
