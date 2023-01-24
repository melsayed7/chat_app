import 'package:chat_app/database/database_helper.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/module/add_room/add_room_controller.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomController addRoomController;

  void createRoom(String titleRoom, String desRoom, String categoryID) async {
    var room = Room(
      roomID: '',
      title: titleRoom,
      description: desRoom,
      categoryID: categoryID,
    );

    try {
      addRoomController.showLoading();
      await DatabaseHelper.addRoomToFirebase(room);
      addRoomController.hideLoading();
      addRoomController.showMessage('Room has been created successfully');
      addRoomController.navigateToHome();
    } catch (error) {
      addRoomController.hideLoading();
      addRoomController.showMessage(error.toString());
    }
  }
}
