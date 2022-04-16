import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sufismart/util/system.dart';

class ChatModel {
  int? id;
  String? messageType;
  DateTime? createDate;
  String? sender;
  String? receiver;
  String? message;
  String? notificationId;
  int? status;

  ChatModel({
    this.id,
    this.messageType,
    this.createDate,
    this.sender,
    this.receiver,
    this.message,
    this.notificationId,
    this.status,
  });

  static ChatModel fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"] as int?,
      messageType: json["messageType"] as String?,
      createDate: json["createDate"] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      sender: json["sender"] as String?,
      receiver: json["receiver"] as String?,
      message: json["message"] as String?,
      notificationId: json["notificationId"] as String?,
      status: json["status"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "messageType": messageType,
      "createDate": createDate?.toIso8601String(),
      "sender": sender,
      "receiver": receiver,
      "message": message,
      "notificationId": notificationId,
      "status": status,
    };
  }


   Future<int?> saveToDb(Database? db) {
    return rootBundle.loadString("dbquery/insertnewchat.sql").then((sql) async {
      sql = sprintf(sql, [
        createDate?.toIso8601String() ??
            DateTime.now().toUtc().toIso8601String(),
        messageType,
        sender,
        receiver,
        message,
        status ?? 0,
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