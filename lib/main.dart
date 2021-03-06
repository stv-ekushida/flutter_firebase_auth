import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/RootPage.dart';
import 'package:flutter_firebase_auth/services/FirebaseAuthService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ログインデモ',
      home: RootPage(auth: FirebaseAuthService()),
    );
  }
}
