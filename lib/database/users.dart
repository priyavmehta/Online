import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  Firestore _firestore = Firestore.instance;
  String collection = "users";

  void createUser({String email, String gender, String userId, String name,String password}){
    print("heellllo");
    _firestore.collection(collection)
    .document(userId)
    .setData({
      "username": name,
      "gender": gender,
      "Id":userId,
      "email":email,
      "password": password
    });
  }
}