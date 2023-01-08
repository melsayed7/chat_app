import 'package:chat_app/database/database_helper.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  ChatUser? user;

  User? firebaseUser;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initUser();
  }

  void initUser() async {
    if (firebaseUser != null) {
      user = await DatabaseHelper.getUser(firebaseUser?.uid ?? '');
    }
  }
}
