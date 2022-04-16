import 'package:flutter/material.dart';
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/notifications_model.dart';
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
    ).then(
      (value) {
        ModeUtil.debugPrint("get all ${value?.length}");
        chats = value ?? [];
        commit();
      },
    ).catchError((onError) {
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onError),
      );
    });
  }

  void send() {
    ChatModel chatModel = ChatModel(
      messageType: "CustomerToCustomer",
      creteDate: DateTime.now().toUtc(),
      receiver: reciver?.id.toString(),
      sender: System.data.global.customerModel?.id.toString(),
      message: messageController.text,
      status: 0,
    );
    chatModel
        .saveToDb(
      db: System.data.database?.db,
    )
        .then((value) {
      ModeUtil.debugPrint("save data success $value");
      chatModel.id = value;
      messageController.text = "";
      chats.add(chatModel);
      commit();
      NotificationModel(
        appId: "5950883a-0066-4be7-ac84-3d240982ffaf",
        apiKey: "63773c22-a638-49a1-b538-440bdd3b7975",
      )
          .sendBasicNotif(
        title: System.data.global.customerModel?.fullName ?? "",
        message: chatModel.message ?? "",
        receiver: reciver?.deviceId != null ? [reciver?.deviceId ?? ""] : [],
        appUrl:
            "sufismart://customer/chat?sender=${reciver?.id ?? ""}&id=${chatModel.id ?? ""}",
      )
          .then(
        (value) {
          chatModel.notificationId = value;
          chatModel.status = 1;
          chatModel.updateStatusInDb(db: System.data.database?.db).then(
            (value) {
              commit();
            },
          );
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
