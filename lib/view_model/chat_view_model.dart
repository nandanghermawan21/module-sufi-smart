
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/model/customer_model.dart';
import 'package:sufismart/component/cilcular_loader_component.dart';
import 'package:sufismart/model/notifications_model.dart';
import 'package:sufismart/util/enum.dart';
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
      sender: System.data.global.customerModel?.id.toString(),
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
      receivertoken: reciver?.deviceId,
      sender: System.data.global.customerModel?.id.toString(),
      sendertoken: System.data.global.customerModel?.deviceId.toString(),
      message: messageController.text,
      messageid: "${reciver?.id}-${randomAlphaNumeric(10)}",
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
      toButton();
      NotificationModel(
        appId: System.data.global.notifAppId,
        apiKey: System.data.global.notifAppKey,
      ).sendBasicNotif(
        title: System.data.global.customerModel?.fullName ?? "",
        message: chatModel.message ?? "",
        receiver: reciver?.deviceId != null ? [reciver?.deviceId ?? ""] : [],
        appUrl:
            "sufismart://customer/chat?sender=${reciver?.id ?? ""}&id=${chatModel.id ?? ""}",
        data: {
          "key": NotifKey.newChat,
          "data": chatModel.toJson(),
        },
      ).then(
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

  void toButton() {
    listScrollController.animateTo(
        listScrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn);
  }

  // void sendReadReport() {
  //   List<ChatModel> chatAsRead = chats
  //       .where((e) =>
  //           e.onVisible == true &&
  //           e.status == 2 &&
  //           e.receiver == System.data.global.customerModel?.id.toString())
  //       .toList();
  //   if (chatAsRead.isNotEmpty) {
  //     for (var e in chatAsRead) {
  //       e.deliveredDate = DateTime.now().toUtc();
  //     }
  //     ChatModel.updateAllStatusInDb(
  //             db: System.data.database?.db,
  //             messageIds: chatAsRead.map((e) => e.messageId).toList(),
  //             deliveredDate: chatAsRead.first.deliveredDate,
  //             status: 3)
  //         .then(
  //       (val) {
  //         for (var e in chatAsRead) {
  //           e.status = 3;
  //         }
  //         NotificationModel(
  //           appId: System.data.global.notifAppId,
  //           apiKey: System.data.global.notifAppKey,
  //         ).sendSilentNotif(
  //           title: System.data.strings!.someMesageHasBeenRead,
  //           message:
  //               "${System.data.strings!.someMesageHasBeenRead} ${chatAsRead.first.deliveredDate?.toIso8601String()}}",
  //           receiver:
  //               reciver?.deviceId == null ? [] : [reciver?.deviceId ?? ""],
  //           appUrl: "sufismart://customer",
  //           data: {
  //             "key": NotifKey.readChat,
  //             "data": chatAsRead.map((e) => e.messageId).toList(),
  //             "date": chatAsRead.first.deliveredDate?.toIso8601String()
  //           },
  //         );
  //       },
  //     );
  //   }
  // }

  markAsRead() async{
    
    List<ChatModel> readedChat=chats.where((e) => e.isVisible==true && (e.status??0)<3 && e.isRead==false && e.receiver==System.data.global.customerModel?.id.toString() ).toList();
    if (readedChat.isNotEmpty) {
      for (var e in readedChat) {
        e.isRead =true;
      }

      for (var e in readedChat) {
        e.status =3;
        e.receivedDate=DateTime.now().toUtc();
        await e.updateStatusInDb(db: System.data.database?.db).then((value) {
          ModeUtil.debugPrint("Success update read ${e.messageid}");
        });
      }

      NotificationModel(
        apiKey: System.data.global.notifAppKey,
        appId: System.data.global.notifAppId
      ).sendBasicNotif(

        title: "pesan telah dibuka", 
        message: "pesan telah dibuka", 
        receiver: reciver?.deviceId != null ? [ reciver?.deviceId  ??""] : [] ,
        appUrl: "sufismart://customer",
        data: {
          
          "key":NotifKey.readChat,
          "data":readedChat.map((e) => e.messageid).toList(),
          "date":readedChat.first.receivedDate?.toIso8601String()
         
         }
        );

        commit();

    }

  }

  void commit() {
    notifyListeners();
  }
}
