import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DBController extends ChangeNotifier {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String __username, String __password) async {
    Map<String, dynamic> user = {
      'username': __username.trim().toLowerCase(),
      'password': __password,
    };

    await userCollection.doc(__username.trim().toLowerCase()).set(user);
    notifyListeners();
  }

  Future<bool> checkUser(String __username, String __password) async {
    bool isUser = false;
    await userCollection
        .doc(__username.trim().toLowerCase())
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;

        var password = data?['password'];
        if (password.toString().contains(__password)) {
          isUser = true;
        }
      }
    });
    return isUser;
  }

  getUserData(String __username) async {
    List<String> userData = [];
    await userCollection
        .doc(__username.trim().toLowerCase())
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
        userData.add(data?['username']);
        userData.add(data?['password']);
      }
    });
    return userData;
  }

  Future<List<String>> getAllUsers() async {
    List<String> users = [];
    if (kDebugMode) {
      print('getAllUsers called');
    }
    await userCollection.get().then((snap) {
      if (kDebugMode) {
        print('getAllUsers value $snap ');
      }

      for (var doc in snap.docs) {
        if (kDebugMode) {
          print('getAllUsers docs $doc');
        }
        var data = json.decode(doc.data().toString());
        if (kDebugMode) {
          print('getAllUsers data $data');
        }
        users.add(data?['username']);
      }
    });
    if (kDebugMode) {
      print('getAllUsers $users');
    }
    return users;
  }
}
