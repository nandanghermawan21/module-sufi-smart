import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sufismart/util/mode_util.dart';

class ChatModel {
  int? id;
  DateTime? creteDate;
  String? messageType;
  String? sender;
  String? receiver;
  String? message;
  String? notificationId;
  int? status;
  DateTime? receivedDate;
  DateTime? deliveredDate;

  ChatModel({
    this.id,
    this.creteDate,
    this.messageType,
    this.sender,
    this.receiver,
    this.message,
    this.notificationId,
    this.status,
    this.receivedDate,
    this.deliveredDate,
  });

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
        id: json["id"] as int?,
        creteDate:
            json["creteDate"] == null ? null : json["creteDate"] as DateTime?,
        messageType: json["messageType"] as String?,
        sender: json["sender"] as String?,
        receiver: json["receiver"] as String?,
        message: json["message"] as String?,
        notificationId: json["notificationId"] as String?,
        status: json["status"] as int?,
        receivedDate: json["receivedDate"] == null
            ? null
            : json["receivedDate"] as DateTime?,
        deliveredDate: json["deliveredDate"] == null
            ? null
            : json["deliveredDate"] as DateTime?);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "creteDate": creteDate?.toIso8601String(),
      "messageType": messageType,
      "sender": sender,
      "receiver": receiver,
      "message": message,
      "notificationId": notificationId,
      "status": status,
      "receivedDate": receivedDate?.toIso8601String(),
      "deliveredDate": deliveredDate?.toIso8601String(),
    };
  }

  Future<int?> saveToDb({required Database? db}) {
    return rootBundle.loadString("dbquery/insertnewchat.sql").then((sql) async {
      sql = sprintf(sql, [
        creteDate != null
            ? creteDate?.toIso8601String()
            : DateTime.now().toUtc().toIso8601String(),
        messageType,
        sender,
        receiver,
        message,
        status ?? 0
      ]);

      return db?.rawInsert(sql).then((value) {
        ModeUtil.debugPrint("New Chat : $value");

        return value;
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      ModeUtil.debugPrint(onError);
    });
  }

  static Future<List<ChatModel>?> getByReceiverFromDb({
    required Database? db,
    String? receiver,
  }) {
    return rootBundle.loadString("dbquery/selectchat.sql").then((sql) async {
      sql = sprintf(sql, [
        receiver,
      ]);
      return db?.rawQuery(sql).then((value) {
        return value.map((e) => ChatModel.fromJson(e)).toList();
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }
}
