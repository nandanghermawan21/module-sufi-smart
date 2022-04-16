import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'package:sufismart/view_model/chat_view_model.dart';

class ChatView extends StatefulWidget {
  final CustomerModel? customerModel;

  const ChatView({Key? key, this.customerModel}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatViewState();
  }
}

class ChatViewState extends State<ChatView> {
  ChatViewModel chatViewModel = ChatViewModel();

  @override
  void initState() {
    super.initState();
    chatViewModel.reciver = widget.customerModel;
    chatViewModel.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: chatViewModel,
      child: CircularLoaderComponent(
        controller: chatViewModel.loadingController,
        child: Scaffold(
          appBar: appBar(),
          backgroundColor: Colors.grey,
          body: Column(children: [chatArea(), chatInput()]),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.network(
                  widget.customerModel?.imageUrl ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (bb, o, st) => Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/avatar.jpeg"),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(widget.customerModel?.fullName ?? ""),
          ],
        ),
      ),
    );
  }

  Widget chatArea() {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: Consumer<ChatViewModel>(
          builder: (c, d, w) {
            return ListView(
              controller: chatViewModel.listScrollController,
              children: List.generate(d.chats.length, (index) {
                return chatBallon(d.chats[index]);
              }),
            );
          },
        ),
      ),
    );
  }

  Widget chatBallon(ChatModel chat) {
    bool isSender =
        (chat.receiver == System.data.global.customerModel?.id.toString())
            ? true
            : false;

    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue.shade500 : Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: isSender ? const Radius.circular(10) : Radius.zero,
              bottomRight: isSender ? Radius.zero : const Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              isSender ? const SizedBox() : status(chat.status),
              const SizedBox(
                width: 5,
              ),
              Text(chat.message ?? ""),
              const SizedBox(
                width: 5,
              ),
              isSender ? status(chat.status) : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }

  Widget status(int? status) {
    switch (status) {
      case 0:
        return const Icon(
          FontAwesomeIcons.clock,
          size: 15,
        );
      case 1:
        return const Icon(
          FontAwesomeIcons.check,
          size: 15,
        );
      case 2:
        return const Icon(
          FontAwesomeIcons.checkDouble,
          size: 15,
        );
      default:
        return const SizedBox();
    }
  }

  Widget chatInput() {
    return Container(
      color: Colors.transparent,
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 5),
              color: Colors.transparent,
              child: TextField(
                controller: chatViewModel.messageController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              chatViewModel.send();
              ModeUtil.debugPrint("Tapped.");
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
