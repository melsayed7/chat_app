import 'package:chat_app/database/database_helper.dart';
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

      var userObj = await DatabaseHelper.getUser(credential.user?.uid ?? '');

      if (userObj == null) {
        loginController.hideLoading();
        loginController.showMessage('Register failed Please try again ');
      } else {
        loginController.navigateToHome(userObj);
      }
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

/*Future<void> loginWithGoogle() async {
    loginController.showLoading();
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    loginController.hideLoading();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    var authResult =
    await FirebaseAuth.instance.signInWithCredential(authCredential);
    loginController.showMessage('Login successfully');
    print(authResult.user?.email);
  }*/
}
