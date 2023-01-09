import 'dart:async';

import 'package:chat_app/model/category.dart';
import 'package:chat_app/module/add_room/add_room_controller.dart';
import 'package:chat_app/module/add_room/add_room_view_model.dart';
import 'package:chat_app/shared/component/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'add_room';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomController {
  AddRoomViewModel viewModel = AddRoomViewModel();
  var titleRoom = TextEditingController();
  var desRoom = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategory();
  late Category selectedItem;

  @override
  void initState() {
    super.initState();
    viewModel.addRoomController = this;
    selectedItem = categoryList[0];
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
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Add Room',
                style: Theme.of(context).textTheme.headline1,
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create New Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Image.asset('asset/images/group.png'),
                    TextFormField(
                      controller: titleRoom,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please entre room name';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text('Room Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownButton<Category>(
                      value: selectedItem,
                      items: categoryList
                          .map(
                            (category) => DropdownMenuItem<Category>(
                              value: category,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(category.title),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                  ),
                                  Image.asset(category.image),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (newCategory) {
                        if (newCategory == null) return;
                        selectedItem = newCategory;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: desRoom,
                      maxLines: 3,
                      minLines: 3,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please entre room description';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        label: const Text('Room Description'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          viewModel.createRoom(
                              titleRoom.text, desRoom.text, selectedItem.id);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
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
  void navigateToHome() {
    Timer(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  void showLoading() {
    utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'OK', (context) {
      Navigator.pop(context);
    });
  }
}
