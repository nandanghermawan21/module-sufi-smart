import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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
  ChatModel chatmodel = ChatModel();


   void send() {
    ChatModel newChat = ChatModel(
      createDate: DateTime.now().toUtc(),
      messageType: "CustomerToCustomer",
      sender: System.data.global.customerModel?.id.toString(),
      receiver: reciver?.id.toString(),
      message: messageController.text,
      status: 0,
    );

    newChat.saveToDb(System.data.database?.db).then((value){
      newChat.id = value;
      chats.add(newChat);
      commit();
    }).catchError((onerror){
      loadingController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(onerror)
      );
    });

   }

  void commit(){
    notifyListeners();
  }

}