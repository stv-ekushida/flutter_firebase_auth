import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/base/BaseAuth.dart';
import 'package:flutter_firebase_auth/services/FirestoreUsersService.dart';
import 'package:flutter_firebase_auth/models/User.dart';

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
  final FirestoreUsersService _firestore = FirestoreUsersService();

  void signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[_showActionButton()],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return FutureBuilder<User>(
        future: widget.auth.getCurrentUser().then((uid) async {
          return _firestore.findUserById(uid);
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            return _showLoginUser(user);
          } else {
            return _showWaiting();
          }
        });
  }

  Widget _showLoginUser(User user) {
    return Scaffold(body: Center(child: Text('ようこそ! ${user.name}')));
  }

  Widget _showWaiting() {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _showActionButton() {
    return FlatButton(
        child: Text('ログアウト',
            style: TextStyle(fontSize: 16.0, color: Colors.white)),
        onPressed: signOut);
  }
}
