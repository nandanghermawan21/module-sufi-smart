import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/view_model/chat_view_model.dart';
import 'package:sufismart/util/system.dart';

class ChatView extends StatefulWidget {
  final CustomerModel? customer;

  const ChatView({
    Key? key,
    this.customer,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChatViewState();
  }
}

class _ChatViewState extends State<ChatView> {
  ChatViewModel chatViewModel = ChatViewModel();

  @override
  void initState() {
    super.initState();
    chatViewModel.reciver = widget.customer;
    chatViewModel.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: chatViewModel,
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: appBar(),
        body: CircularLoaderComponent(
          controller: chatViewModel.loadingController,
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                chatArea(),
                chatImput(),
              ],
            ),
          ),
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
                  widget.customer?.imageUrl ?? "",
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
            Text(widget.customer?.fullName ?? ""),
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
        chat.receiver == System.data.global.customerModel?.id.toString()
            ? true
            : false;
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSender ? Colors.white : Colors.blue.shade300,
              borderRadius: BorderRadius.only(
                bottomLeft: !isSender ? const Radius.circular(15) : Radius.zero,
                bottomRight: isSender ? const Radius.circular(15) : Radius.zero,
              ),
            ),
            child: Row(
              children: [
                isSender ? status(chat.status) : const SizedBox(),
                const SizedBox(
                  width: 5,
                ),
                Text(chat.message ?? ""),
                const SizedBox(
                  width: 5,
                ),
                !isSender ? status(chat.status) : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
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

  Widget chatImput() {
    return Container(
      color: Colors.transparent,
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              color: Colors.transparent,
              child: TextField(
                controller: chatViewModel.messageController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: chatViewModel.send,
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  )),
              width: 50,
              height: 50,
              child: const Icon(Icons.send),
            ),
          )
        ],
      ),
    );
  }
}
