import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'loginScreen';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          'asset/images/background.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Login'),
            centerTitle: true,
          ),
        ),
      ],
    );
  }
}
