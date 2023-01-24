import 'package:chat_app/model/message.dart';
import 'package:chat_app/model/room.dart';
import 'package:chat_app/module/chat/chat_screen_controller.dart';
import 'package:chat_app/module/chat/chat_screen_view_model.dart';
import 'package:chat_app/module/chat/message_widget.dart';
import 'package:chat_app/provider/user_provider.dart';
import 'package:chat_app/shared/component/utils.dart' as Utils;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    implements ChatScreenController {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.chatScreenController = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.listenToUpdateMessage();
    viewModel.user = provider.user!;
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
                args.title,
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
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.streamMessage,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        var messageList = snapshot.data?.docs
                                .map((doc) => doc.data())
                                .toList() ??
                            [];
                        return ListView.builder(
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return MessageWidget(message: messageList[index]);
                          },
                        );
                      }
                    },
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              hintText: 'Type your message',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20)))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(controller.text);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: Row(
                          children: const [
                            Text(
                              'Send',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.send,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void clearMessage() {
    controller.clear();
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(
      context,
      message,
      'OK',
      (context) {
        Navigator.pop(context);
      },
    );
  }
}
