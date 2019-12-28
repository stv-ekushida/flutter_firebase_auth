import 'package:flutter_firebase_auth/models/User.dart';

abstract class BaseUser {
  Future<List<User>> findAllUsers();

  Future<User> findUserById(String uid);

  void addUser(String uid, Map data);
}
