import 'dart:async';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/module/home/home_screen.dart';
import 'package:chat_app/module/register/register_controller.dart';
import 'package:chat_app/module/register/register_view_model.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/shared/component/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterController {
  var formKey = GlobalKey<FormState>();

  var firstName = TextEditingController();

  var lastName = TextEditingController();

  var userName = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.registerController = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
                'Create Account',
                style: Theme.of(context).textTheme.headline1,
              ),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      TextFormField(
                        controller: firstName,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please entre first name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('First Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: lastName,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please entre last name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Last Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: userName,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please entre user name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('User Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: email,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please entre valid email';
                          }
                          final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email.text);
                          if (!emailValid) {
                            return 'Please entre valid email like john@gmail.com';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: password,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please entre password';
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Password'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            viewModel.registerFirebaseAuth(
                                email.text,
                                password.text,
                                firstName.text,
                                lastName.text,
                                userName.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          'Create Account',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    utils.hideLoading(context);
  }

  @override
  void showLoading() {
    utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    Timer(const Duration(seconds: 2), () {
      utils.showMessage(context, message, 'Ok', (context) {
        if (message == 'The password provided is too weak') {
          Navigator.of(context).pop();
        } else if (message == 'The account already exists for that email') {
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void navigateToHome(ChatUser user) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.user = user;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
  }
}
