import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/Auth.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            new FlatButton(
                child: Text('ログアウト',
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
        body: Center(child: Text('Home')));
  }
}