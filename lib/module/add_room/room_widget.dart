import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';

class RoomWidget extends StatelessWidget {
  Room room;

  RoomWidget({required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 12, left: 12, top: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset('asset/images/${room.categoryID}.png', height: 100),
          const SizedBox(
            height: 10,
          ),
          Text(room.title),
        ],
      ),
    );
  }
}
