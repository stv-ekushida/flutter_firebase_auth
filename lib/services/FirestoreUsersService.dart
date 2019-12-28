import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth/models/User.dart';
import 'package:flutter_firebase_auth/services/base/BaseUser.dart';

class FirestoreUsersService implements BaseUser {
  final String documentId = 'users';

  Future<List<User>> findAllUsers() async {
    return _getDocuments(documentId).then((users) {
      List<User> userList = [];

      for (DocumentSnapshot user in users.documents) {
        userList.add(User.fromMap(user));
      }
      return userList;
    });
  }

  Future<User> findUserById(String uid) async {
    return _getData(documentId, uid).then((user) {
      return User.fromMap(user);
    });
  }

  void addUser(String uid, Map data) {
    _setData(documentId, uid, data);
  }

  Future<QuerySnapshot> _getDocuments(String collection) async {
    return await Firestore.instance.collection(collection).getDocuments();
  }

  Future<DocumentSnapshot> _getData(
      String collection, String documentId) async {
    return await Firestore.instance
        .collection(collection)
        .document(documentId)
        .get();
  }

  void _setData(String collection, String documentId, Map data) {
    Firestore.instance
        .collection(collection)
        .document(documentId)
        .setData(data);
  }
}
