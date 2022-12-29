import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'homeScreen';

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
          height: double.infinity,
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Chat App',
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
          ),
        ),
      ],
    );
  }
}
