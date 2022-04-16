import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sufismart/util/system.dart';
import 'package:sprintf/sprintf.dart';
import 'notifications_model.dart';

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

  sendToCustomer({
    String? token,
  }) {
    http.post(
      Uri.parse(System.data.apiEndPoint.sendChatToCustomer()),
      body: json.encode(
        {
          "receiverId": receiver,
          "message": message,
        },
      ),
      headers: {
        HttpHeaders.authorizationHeader: "bearer $token",
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return ChatModel.fromJson(json.decode(value.body));
        } else {
          throw json;
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  Future<String?> sendNotifToCustomer({
    required String? senderName,
    required List<String>? deviceIds,
  }) {
    return NotificationModel(
            appId: "5950883a-0066-4be7-ac84-3d240982ffaf",
            $apiKey: "NGVhYmMxNmEtODM3Zi00MDM3LWI5ZjYtNDQ3ZTNiMDExMWVi")
        .sendBasicNotif(
      title: senderName ?? "",
      message: message ?? "",
      receiver: deviceIds ?? [],
      appUrl: "sufismart://customer/chat?sender=${sender ?? ""}&id=${id ?? ""}",
      data: toJson(),
    );
  }
}
