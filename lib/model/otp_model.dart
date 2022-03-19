class OtpModel {
  String? resendurl;
  String? confirmurl;
  String? jsondata;
  DateTime? expired;

  OtpModel({this.resendurl, this.confirmurl, this.jsondata, this.expired});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(
        resendurl: json["resendurl"] as String,
        confirmurl: json["confirmurl"] as String,
        jsondata: json["jsondata"] as String,
        expired: json["expired"] == null
            ? null
            : DateTime.parse(json["expired"] as String));
  }

  Map<String, dynamic> tojson() {
    return {
      "resendurl": resendurl,
      "confirmurl": confirmurl,
      "jsondata": jsondata,
      "expired": expired?.toIso8601String(),
    };
  }
}
