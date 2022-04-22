import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/error_handling_util.dart';
import 'package:sufismart/util/mode_util.dart';
import 'package:sufismart/util/system.dart';
import 'chat_model.dart';

class NotificationModel {
  String appId;
  String apiKey;

  NotificationModel({
    required this.appId,
    required this.apiKey,
  });

  Future<String?> sendBasicNotif({
    required String title,
    required String message,
    required List<String> receiver,
    required String appUrl,
    Map<String, dynamic>? data,
  }) {
    return http.post(
      Uri.parse("https://onesignal.com/api/v1/notifications"),
      body: json.encode({
        "app_id": appId,
        "include_player_ids": receiver,
        "headings": {
          "en": title,
          "id": title,
        },
        "contents": {
          "en": message,
          "id": message,
        },
        "app_url": appUrl,
        "ios_sound": "my_notification_sound.wav",
        "android_channel_id": "6d52b765-dc9f-4735-a38b-77b784dbe90b",
        "data": data ?? {},
      }),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return json.decode(value.body)["id"] as String?;
        } else {
          throw json.decode(value.body)["errors"];
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  Future<String?> sendSilentNotif({
    required String title,
    required String message,
    required List<String> receiver,
    required String appUrl,
    Map<String, dynamic>? data,
  }) {
    return http.post(
      Uri.parse("https://onesignal.com/api/v1/notifications"),
      body: json.encode({
        "app_id": appId,
        "include_player_ids": receiver,
        "headings": {
          "en": title,
          "id": title,
        },
        "contents": {
          "en": message,
          "id": message,
        },
        "app_url": appUrl,
        "ios_sound": "my_blank.wav",
        "android_channel_id": "a40249fc-a1a6-4cf2-9ed5-cf913515f504",
        "data": data ?? {},
      }),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).then(
      (value) {
        if (value.statusCode == 200) {
          return json.decode(value.body)["id"] as String?;
        } else {
          throw json.decode(value.body)["errors"];
        }
      },
    ).catchError((onError) {
      throw onError;
    });
  }

  Future<void> handleNotif(Map<String, dynamic> data) async {
    String key = data["key"];
    ModeUtil.debugPrint("handle notification $key");
    switch (key) {
      case NotifKey.newChat:
        Map<String, dynamic> notifData = json.decode(json.encode(data["data"]));
        ChatModel chat = ChatModel.fromJson(notifData);
        ModeUtil.debugPrint("handle $key read chat");
        ModeUtil.debugPrint("handle $key add chat to db");
        chat.saveToDb(db: System.data.database?.db).then((value) {
          ModeUtil.debugPrint("handle $key success add chat to db");
          if (System.data.global.chatViewModel != null &&
              System.data.global.chatViewModel?.reciver?.id.toString() ==
                  chat.sender) {
            ModeUtil.debugPrint("handle $key process add chat to chatview");
            System.data.global.chatViewModel?.chats.add(chat);
            System.data.global.chatViewModel?.commit();
            System.data.global.chatViewModel?.toButton();
            ModeUtil.debugPrint("handle $key success add chat to chatview");
          }
          chat.deliveredDate = DateTime.now();
          sendBasicNotif(
            title: System.data.strings!.yourMessageSent,
            message:
                "${System.data.strings!.yourMessageSent} at ${chat.deliveredDate?.toIso8601String()}",
            receiver: chat.senderToken != null ? [chat.senderToken ?? ""] : [],
            appUrl: "sufismart://customer",
            data: {
              "key": NotifKey.sendedChat,
              "data": chat,
            },
          );
        }).catchError((onError) {
          ModeUtil.debugPrint(ErrorHandlingUtil.handleApiError(onError));
        });
        break;
      case NotifKey.sendedChat:
        Map<String, dynamic> notifData = json.decode(json.encode(data["data"]));

        ChatModel chat = ChatModel.fromJson(notifData);
        ModeUtil.debugPrint("handle $key delivered chat");
        ModeUtil.debugPrint("handle $key update chat to db");
        chat.status = 2;
        chat.updateStatusInDb(db: System.data.database?.db).then((value) {
          ModeUtil.debugPrint("handle $key success update chat to db");
          if (System.data.global.chatViewModel != null &&
              System.data.global.chatViewModel?.reciver?.id.toString() ==
                  chat.receiver) {
            ModeUtil.debugPrint("handle $key process add chat to chatview");
            System.data.global.chatViewModel?.chats
                .where((e) => e.id == chat.id)
                .first
                .status = 2;
            System.data.global.chatViewModel?.commit();
            ModeUtil.debugPrint("handle $key success add chat to chatview");
          }
        }).catchError((onError) {
          ModeUtil.debugPrint(ErrorHandlingUtil.handleApiError(onError));
        });
        break;
      case NotifKey.readChat:
        List<String?> messageIds =
            (data["data"] as List).map((e) => e as String?).toList();
        DateTime? deliveredDate = data["date"] == null
            ? null
            : DateTime.parse(data['date'] as String);
        ModeUtil.debugPrint("handle $key chat");
        ModeUtil.debugPrint("handle $key update chat to db");
        ChatModel.updateAllStatusInDb(
          db: System.data.database?.db,
          status: 3,
          deliveredDate: deliveredDate,
          messageIds: messageIds,
        ).then((value) {
          ModeUtil.debugPrint("handle $key success update chat to db");
          if (System.data.global.chatViewModel != null) {
            ModeUtil.debugPrint("handle $key process add chat to chatview");
            System.data.global.chatViewModel?.chats
                .where((e) => messageIds.contains(e.messageId))
                .first
                .status = 3;
            System.data.global.chatViewModel?.commit();
            System.data.global.chatViewModel?.toButton();
            ModeUtil.debugPrint("handle $key success add chat to chatview");
          }
        }).catchError((onError) {
          ModeUtil.debugPrint(ErrorHandlingUtil.handleApiError(onError));
        });
        break;
      default:
        break;
    }
  }
}
