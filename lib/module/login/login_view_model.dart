import 'package:chat_app/module/login/login_controller.dart';
import 'package:chat_app/shared/component/firebase_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInViewModel extends ChangeNotifier {
  late LoginController loginController;

  void loginFirebaseAuth(String email, String password) async {
    try {
      loginController.showLoading();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      loginController.hideLoading();
      loginController.showMessage('Login Successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.userNotFound) {
        loginController.hideLoading();
        loginController.showMessage('No user found for that email');
        print('No user found for that email.');
      } else if (e.code == FirebaseError.wrongPassword) {
        loginController.hideLoading();
        loginController.showMessage('Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }
  }
}
