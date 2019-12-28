import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/FirestoreUtils.dart';
import 'package:flutter_firebase_auth/User.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirestoreUtils _firestore = FirestoreUtils();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //全ユーザ一覧取得
//    _firestore.findAllUsers().then((users) {
//      users.forEach((user) => print(user.name));
//    });

    return FutureBuilder<User>(
        future: _auth.currentUser().then((user) async {
//          var data = {
//            'name': "山本　浩二",
//            'hometown': '広島',
//            'school': '法政大学',
//            'department': '体育科'
//          };
//
//          _firestore.addUser(user.uid, data);

          return _firestore.findUserById(user.uid);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;

            return Scaffold(
              body: Center(
                  child: Text(user.name)
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        });
  }
}
