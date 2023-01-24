import 'package:chat_app/database/database_helper.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/module/add_room/add_room.dart';
import 'package:chat_app/module/add_room/room_widget.dart';
import 'package:chat_app/module/home/home_screen_controller.dart';
import 'package:chat_app/module/home/home_screen_view_model.dart';
import 'package:chat_app/module/login/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements HomeScreenController {
  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.homeScreenController = this;
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
                'Chat App',
                style: Theme.of(context).textTheme.headline1,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    DatabaseHelper.logOUt();
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: const Icon(Icons.add),
            ),
            body: StreamBuilder<QuerySnapshot<Room>>(
              stream: DatabaseHelper.getRoomsFromFirebase(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  var roomList =
                      snapshot.data?.docs.map((doc) => doc.data()).toList() ??
                          [];
                  return GridView.builder(
                    itemCount: roomList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return RoomWidget(room: roomList[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
