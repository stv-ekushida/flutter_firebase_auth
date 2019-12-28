import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String school;
  String hometown;
  String department;

  User({this.name, this.school, this.hometown, this.department});

  User.fromMap(DocumentSnapshot map) :
        name = map['name'],
        school = map['school'],
        hometown = map['hometown'],
        department = map['department'];
}
