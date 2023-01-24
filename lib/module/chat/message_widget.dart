import 'package:chat_app/model/message.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id == message.senderID
        ? SendMessage(message: message)
        : ReceiveMessage(message: message);
  }
}

class SendMessage extends StatelessWidget {
  Message message;

  SendMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    DateTime showTime = DateTime.fromMicrosecondsSinceEpoch(message.dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            message.content,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              message.senderName,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              '${showTime.hour}:${showTime.minute}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}

class ReceiveMessage extends StatelessWidget {
  Message message;

  ReceiveMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    DateTime showTime = DateTime.fromMicrosecondsSinceEpoch(message.dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              message.senderName,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              '${showTime.hour}:${showTime.minute}',
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Text(
            message.content,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
