import 'package:flutter/material.dart';
import 'package:sufismart/component/circular_loader_component.dart';
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';

class ChatViewModel extends ChangeNotifier {
  CustomerModel? reciver;
  CircularLoaderController loadingController = CircularLoaderController();
  TextEditingController messageController = TextEditingController();
  ScrollController listScrollController = ScrollController();
  List<ChatModel> chats = [];

  void getAll() {
    ChatModel.getByReceiverFromDb(
      db: System.data.database?.db,
      receiver: reciver?.id.toString(),
    ).then((value) {
      ModeUtil.debugPrint("total chats ${value?.length}");
      chats = value ?? [];
      commit();
    }).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  void send() {
    ChatModel newChat = ChatModel(
      createDate: DateTime.now().toUtc(),
      messageType: "CustomerToCustomer",
      sender: System.data.global.customerModel?.id.toString(),
      receiver: reciver?.id.toString(),
      message: messageController.text,
      status: 0,
    );

    newChat.saveToDb(System.data.database?.db).then((value) {
      ModeUtil.debugPrint("result from insert $value");
      newChat.id = value;
      chats.add(newChat);
      messageController.text = "";
      listScrollController.animateTo(
          listScrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn);
      commit();
      newChat.sendNotifToCustomer(
          senderName: System.data.global.customerModel?.fullName,
          deviceIds: [reciver?.deviceId ?? ""]).then(
        (value) {
          ModeUtil.debugPrint("result from send notification id $value");
        },
      ).catchError((onError) {
        loadingController.stopLoading(
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      });
    }).catchError(
      (onError) {
        loadingController.stopLoading(
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      },
    );
  }

  void commit() {
    notifyListeners();
  }
}
