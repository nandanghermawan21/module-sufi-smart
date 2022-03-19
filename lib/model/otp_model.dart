class OtpModel {
  String? resendUrl; // "string",
  String? confirmUrl; // "2022-03-19T06:36:26.208Z",
  String? jsonData; // "string",
  DateTime? expired;

  OtpModel({
    this.resendUrl,
    this.confirmUrl,
    this.jsonData,
    this.expired,
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
