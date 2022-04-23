import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sqlite_api.dart';

class ChatModel {
  int? id; // INTEGER PRIMARY KEY,
  DateTime? creteDate; // DATETIME,
  String? messageType; // VARCHAR(50),
  String? sender; // VARCHAR(50),
  String? senderToken;
  String? receiver;
  String? receiverToken; // VARCHAR(50),
  String? message; // TEXT,
  String? notificationId; // VARCHAR(50),
  int? status; // int,
  DateTime? receivedDate; // DATETIME,
  DateTime? deliveredDate;
  String? messageId;
  bool? isVisible;

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
    this.messageId,
    this.senderToken,
    this.receiverToken,
    this.isVisible = false,
  }); // DateTime

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"] as int?,
      creteDate: json["creteDate"] == null
          ? null
          : DateTime.parse(json['creteDate'] as String),
      messageType: json["messageType"] as String?,
      sender: json["sender"] as String?,
      receiver: json["receiver"] as String?,
      message: json["message"] as String?,
      notificationId: json["notificationId"] as String?,
      status: json["status"] as int?,
      receivedDate: json["receivedDate"] == null
          ? null
          : DateTime.parse(json['receivedDate'] as String),
      deliveredDate: json["deliveredDate"] == null
          ? null
          : DateTime.parse(json['deliveredDate'] as String),
      messageId: json["sender"] as String?,
      senderToken: json["sender"] as String?,
      receiverToken: json["sender"] as String?,
    );
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
      "messageId": messageId,
      "senderToken": senderToken,
      "receiverToken": receiverToken,
    };
  }

  Future<int?> saveToDb({
    required Database? db,
  }) {
    return rootBundle.loadString("dbquery/insertnewchat.sql").then((sql) async {
      sql = sprintf(sql, [
        creteDate != null
            ? creteDate?.toIso8601String()
            : DateTime.now().toUtc().toIso8601String(),
        messageType,
        sender,
        receiver,
        message,
        status,
        messageId,
        senderToken,
        receiverToken
      ]);
      return db?.rawInsert(sql).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<List<ChatModel>?> getByReceiverFromDb({
    required Database? db,
    required String? receiver,
    required String? sender,
    required String? reciver,
    required String? receiverToken,
    required String? senderToken,
  }) {
    return rootBundle.loadString("dbquery/selectchat.sql").then((sql) async {
      sql = sprintf(sql,
          [receiver, sender, sender, receiver, senderToken, receiverToken]);
      return db?.rawQuery(sql).then((value) {
        return value.map((e) => ChatModel.fromJson(e)).toList();
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  Future<int?> updateStatusInDb({
    required Database? db,
    String? receiver,
  }) {
    return rootBundle
        .loadString("dbquery/updatestatuschat.sql")
        .then((sql) async {
      sql = sprintf(
        sql,
        [
          notificationId,
          status,
          id,
        ],
      );
      return db?.rawUpdate(sql).then((value) {
        return value;
      }).catchError((onError) {
        throw onError;
      });
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}
