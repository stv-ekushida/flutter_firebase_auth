import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_auth/User.dart';

class FirestoreUtils {

  Future<QuerySnapshot> getDocuments(String collection) async {
    return await Firestore.instance.collection(collection).getDocuments();
  }

  Future<DocumentSnapshot> getData(String collection, String documentId) async {
    return await Firestore.instance
        .collection(collection)
        .document(documentId)
        .get();
  }

  void setData(String collection, String documentId, Map data) {
    Firestore.instance
        .collection(collection)
        .document(documentId)
        .setData(data);
  }

  Future<List<User>> findAllUsers() async {
    return getDocuments('users').then((users) {
      List<User> userList = [];

      for (DocumentSnapshot user in users.documents) {
        userList.add(User.fromMap(user));
      }

      return userList;
    });
  }

  Future<User> findUserById(String uid) async {
    return getData('users', uid).then((user) {
      return User.fromMap(user);
    });
  }

  void addUser(String documentId, Map data) {
    setData('users', documentId, data);
  }
}