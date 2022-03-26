class UserModel {
  final String? username;
  final String? password;
  final String? deviceId;

  UserModel({
    this.username,
    this.password,
    this.deviceId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"] as String,
      password: json["password"] as String,
      deviceId: json["deviceId"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "deviceId": deviceId,
    };
  }
}