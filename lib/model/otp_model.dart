import 'dart:core';

class OtpModel {
  String? resendUrl;
  String? confirmUrl;
  String? jsonData;
  DateTime? expired;

  OtpModel({
    this.resendUrl,
    this.confirmUrl,
    this.expired,
    this.jsonData,
  });

  static OtpModel fromJson(Map<String, dynamic> json) {
    return OtpModel(
      resendUrl: json["resendUrl"] as String,
      confirmUrl: json["confirmUrl"] as String,
      jsonData: json["jsonData"] as String,
      expired: json["expired"] == null
          ? null
          : DateTime.parse(json["expired"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "resendUrl": resendUrl,
      "confirmUrl": confirmUrl,
      "jsonData": jsonData,
      "expired": expired?.toIso8601String(),
    };
  }
}
