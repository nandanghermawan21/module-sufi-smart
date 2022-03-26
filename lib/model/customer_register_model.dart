class CustomerRegisterModel {
  String? avatar;
  String? nik;
  String? fullName;
  String? genderId;
  String? cityId;
  String? phoneNumber;
  String? username;
  String? password;
  String? deviceId;

  CustomerRegisterModel({
    this.avatar,
    this.nik,
    this.fullName,
    this.genderId,
    this.cityId,
    this.phoneNumber,
    this.username,
    this.password,
    this.deviceId,
  });

  get token => null;

  CustomerRegisterModel fromJson(Map<String, dynamic> json) {
    return CustomerRegisterModel(
      avatar: json["avatar"] as String,
      nik: json["nik"] as String,
      fullName: json["fullName"] as String,
      genderId: json["genderId"] as String,
      cityId: json["cityId"] as String,
      phoneNumber: json["phoneNumber"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      deviceId: json["deviceId"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar,
      "nik": nik,
      "fullName": fullName,
      "genderId": genderId,
      "cityId": cityId,
      "phoneNumber": phoneNumber,
      "username": username,
      "password": password,
      "deviceId": deviceId,
    };
  }
}
