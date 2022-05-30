class FeedbackModel {
  String? msg;
  int? stat;

  FeedbackModel({
    this.msg,
    this.stat,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      msg: json["msg"] as String?,
      stat: json["stat"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'msg': msg,
      'stat': stat,
    };
  }
}
