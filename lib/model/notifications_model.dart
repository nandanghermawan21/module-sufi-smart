import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sufismart/model/chat_model.dart';
import 'package:sufismart/util/enum.dart';
import 'package:sufismart/util/system.dart';

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

  Future<void> handleNotif(Map<String, dynamic> data) async {
    String key = data["key"];
    switch (key) {
      case NotifKey.newChat:
        Map<String, dynamic> notifData = json.decode(json.encode(data["data"]));
        ChatModel chat = ChatModel.fromJson(notifData);
        chat.saveToDb(db: System.data.database?.db).then(
          (value) {
            if (System.data.global.chatViewModel != null &&
                System.data.global.customerModel?.id.toString() ==
                    chat.receiver) {
              System.data.global.chatViewModel?.chats.add(chat);
              System.data.global.chatViewModel?.commit();
              System.data.global.chatViewModel?.toBottom();
            }
          },
        );
        break;
      default:
        break;
    }
  }
}
