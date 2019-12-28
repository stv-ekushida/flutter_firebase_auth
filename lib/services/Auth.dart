import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {

  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();

  Future<void> sendEmailVerification();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {

    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async{
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword
      (email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async{
    return await _firebaseAuth.currentUser();
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification(){
    return getCurrentUser().then((user) => user.sendEmailVerification());
  }

  Future<bool> isEmailVerified(){
    return getCurrentUser().then((user) => user.isEmailVerified);
  }
}