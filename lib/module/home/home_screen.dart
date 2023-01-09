import 'package:chat_app/module/add_room/add_room.dart';
import 'package:chat_app/module/home/home_screen_controller.dart';
import 'package:chat_app/module/home/home_screen_view_model.dart';
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
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
