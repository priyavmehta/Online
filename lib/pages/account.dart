import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  CollectionReference collectionCategory = Firestore.instance.collection("users");
  List<DocumentSnapshot> users = <DocumentSnapshot>[];
  StreamSubscription<QuerySnapshot> subscriptionCategory;
  List<String> categories = <String>[];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}