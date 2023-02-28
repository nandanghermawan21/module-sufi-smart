class UserModel {
  final String? username;
  final String? password;
  final String? deviceId;
  final String? playerid;
  final String? version;
  final String? jamdevice;

  UserModel({
    this.username,
    this.password,
    this.deviceId,
    this.playerid,
    this.version,
    this.jamdevice
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"] as String?,
      password: json["password"] as String?,
      deviceId: json["deviceId"] as String?,
      playerid: json["playerid"] as String?,
      version: json["version"] as String?,
      jamdevice: json["jamdevice"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "deviceId": deviceId,
      "playerid": playerid,
      "version": version,
      "jamdevice": jamdevice,
    };
  }
}
