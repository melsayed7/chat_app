import 'package:chat_app/module/home/home_screen.dart';
import 'package:chat_app/module/login/login_screen.dart';
import 'package:chat_app/module/register/register_screen.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/shared/style/my_Theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      initialRoute: userProvider.firebaseUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      theme: MyTheme.lightTheme,
    );
  }
}
