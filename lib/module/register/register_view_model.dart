import 'package:chat_app/database/database_helper.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/module/register/register_controller.dart';
import 'package:chat_app/shared/component/firebase_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterController registerController;

  void registerFirebaseAuth(String email, String password, String firstName,
      String lastName, String userName) async {
    try {
      registerController.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var user = ChatUser(
          id: credential.user!.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);

      await DatabaseHelper.registerUser(user);

      registerController.hideLoading();
      registerController.showMessage('Account has been created');
      registerController.navigateToHome(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseError.weakPassword) {
        registerController.hideLoading();
        registerController.showMessage('The password provided is too weak');
        print('The password provided is too weak.');
      } else if (e.code == FirebaseError.emailAlreadyInUse) {
        registerController.hideLoading();
        registerController
            .showMessage('The account already exists for that email');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
