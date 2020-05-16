import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  static const String ID = 'Id';
  static const String EMAIL = 'email';
  static const String GENDER = 'gender';
  static const String PASSWORD = 'password';
  static const String USERNAME = 'username';

  String _id;
  String _username;
  String _gender;
  String _password;
  String _email;

  String get id => _id;
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get gender => _gender;

  User.fromSnapshot(DocumentSnapshot snapshot){
    _id = snapshot.data[ID];
    _email = snapshot.data[EMAIL];
    _gender = snapshot.data[GENDER];
    _password = snapshot.data[PASSWORD];
    _username = snapshot.data[USERNAME];
  }
}