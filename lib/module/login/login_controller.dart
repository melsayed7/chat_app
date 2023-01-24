import 'package:chat_app/model/chat_user.dart';

abstract class LoginController {
  void showLoading();

  void hideLoading();

  void showMessage(String message);

  void navigateToHome(ChatUser user);
}
