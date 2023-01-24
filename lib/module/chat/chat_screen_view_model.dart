import 'package:chat_app/database/database_helper.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/module/chat/chat_screen_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreenViewModel extends ChangeNotifier {
  late ChatScreenController chatScreenController;
  late ChatUser user;
  late Room room;
  late Stream<QuerySnapshot<Message>> streamMessage;

  void sendMessage(String content) async {
    Message message = Message(
      roomID: room.roomID,
      content: content,
      senderID: user.id,
      senderName: user.userName,
      dateTime: DateTime.now().microsecondsSinceEpoch,
    );
    try {
      var result = await DatabaseHelper.insertMessage(message);
      chatScreenController.clearMessage();
    } catch (error) {
      chatScreenController.showMessage(error.toString());
    }
  }

  void listenToUpdateMessage() {
    streamMessage = DatabaseHelper.getMessageFromFirebase(room.roomID);
  }
}
